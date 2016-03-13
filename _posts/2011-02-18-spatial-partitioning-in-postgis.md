---
layout: post
title: Spatial Partitioning in PostGIS
date: '2011-02-18T16:37:00.000-08:00'
author: Paul Ramsey
tags: 
modified_time: '2011-02-18T16:40:43.311-08:00'
blogger_id: tag:blogger.com,1999:blog-14903426.post-5114831045286297330
blogger_orig_url: http://blog.cleverelephant.ca/2011/02/spatial-partitioning-in-postgis.html
comments: True
---

I've been meaning for a long time to see what an implementation of spatial partitioning in PostGIS would look like, and a trip next week to the Center for Topographic Information in Sherbrooke had given me the excuse to try a toy implementation.

Imaging map data constrained to a 1km square. Here is an example that partitions that square into a left- and right-side, and then inserts the data appropriately into the right table as it comes in. Features that straddle the two halves get put into a third special-case table for handling overlaps.

{% highlight sql %}
-- parent table
create table km (
id integer,
geom geometry
);

-- left side
create table km_left(
check ( _st_contains(st_makeenvelope(0,0,500,1000,-1),geom ) )
) inherits (km);

-- right side
create table km_right(
check ( _st_contains(st_makeenvelope(500,0,1000,1000,-1),geom ) )
) inherits (km);

-- border overlaps
create table km_overlaps(
check ( _st_intersects(st_makeline(st_makepoint(500,0),st_makepoint(500,1000)),geom ) )
) inherits (km);

-- indexes
create index km_left_gix on km_left using gist (geom);
create index km_right_gix on km_right using gist (geom);
create index km_overlaps_gix on km_overlaps using gist (geom);

-- direct insert to appropriate table
CREATE OR REPLACE FUNCTION km_insert_trigger()
RETURNS TRIGGER AS $$
BEGIN
    IF ( _st_contains(st_makeenvelope(0,0,500,1000,-1),NEW.geom) ) THEN
    INSERT INTO km_left VALUES (NEW.*);
    ELSIF ( _st_contains(st_makeenvelope(500,0,1000,1000,-1),NEW.geom) ) THEN
    INSERT INTO km_right VALUES (NEW.*);
    ELSEif ( _st_intersects(st_makeline(st_makepoint(500,0),st_makepoint(500,1000)),NEW.geom) ) THEN
    INSERT INTO km_overlaps VALUES (NEW.*);
    ELSE
    RAISE EXCEPTION 'Geometry out of range.';
    END IF;
    RETURN NULL;
END;
$$
LANGUAGE plpgsql;

CREATE TRIGGER insert_km_trigger
    BEFORE INSERT ON km
    FOR EACH ROW EXECUTE PROCEDURE km_insert_trigger();

-- add some data
insert into km (id, geom) values (1, 'POINT(50 50)');
insert into km (id, geom) values (2, 'POINT(550 50)');
insert into km (id, geom) values (3, 'LINESTRING(250 250, 750 750)');

-- see where it lands
select * from km;
select * from km_right;
select * from km where st_contains('POLYGON((20 20,20 60,60 60,60 20,20 20))',geom);
{% endhighlight %}

It's still a toy, I need to put more data in it and see how well the indexes and constraint exclusion mechanisms actually work in this case.

