---
layout: post
title: '5x Faster Spatial Join with this One Weird Trick'
date: '2018-09-28T00:00:00-08:00'
author: Paul Ramsey
category: technology
tags:
- storage
- point-in-polygon
- postgis
- postgresql
comments: True
image: "2018/ne-map.jpg"
---

My go-to performance test for PostGIS is the point-in-polygon spatial join: given a collection of polygons of variables sizes and a collection of points, count up how many points are within each polygon. It's a nice way of testing indexing, point-in-polygon calculations and general overhead.

## Setup

First download some polygons and some points.

* [Admin 0 - Countries](https://www.naturalearthdata.com/http//www.naturalearthdata.com/download/10m/cultural/ne_10m_admin_0_countries.zip)
* [Populated Places](https://www.naturalearthdata.com/http//www.naturalearthdata.com/download/10m/cultural/ne_10m_populated_places.zip)

Load the shapes into your database.

    shp2pgsql -s 4326 -D -I ne_10m_admin_0_countries.shp countries | psql performance
    shp2pgsql -s 4326 -D -I ne_10m_populated_places.shp places | psql performance

Now we are ready with **255 countries** and **7343 places**. 

<img src="{{ site.images }}/2018/ne-map.jpg" alt="Countries and Places" />

One thing to note about the countries is that they are quite large objects, with 149 of them having enough vertices to be stored in [TOAST](https://www.postgresql.org/docs/11/static/storage-toast.html) tuples.

{% highlight sql %}
SELECT count(*) 
  FROM countries 
  WHERE ST_NPoints(geom) > (8192 / 16);
{% endhighlight %}

## Baseline Performance

Now we can run the baseline performance test.

{% highlight sql %}
SELECT count(*), c.name 
  FROM countries c 
  JOIN places p 
  ON ST_Intersects(c.geom, p.geom) 
  GROUP BY c.name;
{% endhighlight %}

On my laptop, this query takes **25 seconds**.

If you stick the process into a profiler while running it you'll find that **over 20 of those seconds are spent in the `pglz_decompress` function**. Not doing spatial algorithms or computational geometry, just decompressing the geometry before handing it on to the actual processing.

Among the things we talked about this week at our [PostGIS code sprint](https://trac.osgeo.org/postgis/wiki/PostGISCodeSprint2018) have been clever ways to avoid this overhead:

* Patch PostgreSQL to allow partial decompression of geometries.
* Enrich our serialization formation to include a unique hash key at the front of geometries.

These are cool have-your-cake-and-eat-too ways to both retain compression for large geometries and be faster when feeding them into the point-in-polygon machinery. 

However, they ignore a more brutal and easily testable approach to avoiding decompression: just **don't compress in the first place**.

## One Weird Trick

PostGIS uses the "main" storage option for it's geometry type. The main option tries to keep geometries in their original table until they get too large, then compresses them in place, then moves them to TOAST. 

There's another option "external" that keeps geometries in place, and if they get too big moves them to TOAST **uncompressed**. PostgreSQL allows you to change the storage on columns at run-time, so no hacking or code is required to try this out.

{% highlight sql %}
-- Change the storage type
ALTER TABLE countries
  ALTER COLUMN geom
  SET STORAGE EXTERNAL;

-- Force the column to rewrite
UPDATE countries
  SET geom = ST_SetSRID(geom, 4326);

-- Re-run the query  
SELECT count(*), c.name 
  FROM countries c 
  JOIN places p 
  ON ST_Intersects(c.geom, p.geom) 
  GROUP BY c.name;
{% endhighlight %}

The spatial join now runs in **under 4 seconds**.

What's the penalty? 

* With a "main" storage the table+toast+index is 6MB.
* With a "external" storage the table+toast+index is 9MB.

## Conclusion

For a 50% storage penalty, on a table that has far more large objects than most spatial tables, we achieved a 500% performance improvement. Maybe we shouldn't apply compression to our large geometry at all?

Using "main" storage was mainly a judgement call back when we decided on it, it wasn't benchmarked or anything. it's possible that we were just wrong. Also, only large objects are compressed; since most tables are full of lots of small objects (short lines, points) changing to "external" by default wouldn't have any effect on storage size at all.

