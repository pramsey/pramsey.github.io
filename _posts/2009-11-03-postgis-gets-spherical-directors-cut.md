---
layout: post
title: PostGIS gets Spherical (Directors Cut)
date: '2009-11-03T13:46:00.000-08:00'
author: Paul Ramsey
tags: 
modified_time: '2009-11-06T13:47:49.715-08:00'
blogger_id: tag:blogger.com,1999:blog-14903426.post-1134055540627336333
blogger_orig_url: http://blog.cleverelephant.ca/2009/11/postgis-gets-spherical-directors-cut.html
comments: True
---

**Update:** Installation instructions have changed slightly since this post was written.

For a business oriented discussion of the new `GEOGRAPHY` type, see [my post on the OpenGeo blog](http://blog.opengeo.org/2009/11/04/postgis-gets-spherical/).

<img src="http://t3.gstatic.com/images?q=tbn:A6ab0_KaSzQg2M:http://www.avidimages.com/preview/2006/10/01/globe_world_map_avidimages_1045_prev.jpg" style="float:right; padding:5px;"/>So you want to try the new `GEOGRAPHY` type and see what it can do? Alright then!

If you are running Windows, please follow the directions on the [Windows experimental binaries](http://postgis.net/download/windows/experimental.php) download page on the PostGIS site. Note that these builds might not be the absolute latest versions available.

If you are running Linux, fetch the latest code from SVN (svn checkout http://svn.osgeo.org/postgis/trunk postgis-svn) and then follow the [install instructions](http://postgis.net/docs/manual-svn/ch02.html#PGInstall).

After installing, you should find the usual `postgis.sql` file which contains the old geometry and now the new geography features too. Install PostGIS and spatial reference information as usual:

    createdb mydb
    psql -d mydb -f postgis.sql
    psql -d mydb -f spatial_ref_sys.sql

I find it useful for testing to load a shape file in the usual way, then add a geography column to it.

    shp2pgsql -s 26910 -g geom taxlots.shp taxlots | psql mydb
    psql mydb

Once you have a table to play with, it's time to add a geography column, and build indexes. You have to transform the geometry into EPSG:4326 before casting to geography. When you build the index on the geography column, it builds a special index over the sphere which respects the poles and dateline.

{% highlight sql %}
alter table taxlots add column geog geography;
update taxlots set geog = geography(st_transform(tgeom,4326));
create index roads_geom_idx on taxlots using gist (geom);
create index roads_geog_idx on taxlots using gist (geog);
{% endhighlight %}

How does this magic index work? The "trick" is to be as lazy as possible. I didn't want to write a whole new indexing scheme, and I already had a serviceable R-Tree index. What I needed to do was convert the lat/lon coordinates to a domain where the problems of the singularities at the poles and dateline would go away. The answer is to convert from spherical coordinates (lat/lon) relative to Greenwich into geocentric coordinates (x/y/z) relative to the center of earth. It's  easy then to build a 3D R-Tree on the geocentric bounds of the features. Calculating the bounds in 3D is tricky, because the curvature of the features over the spherical surface must be respected, but once that is done, the index performs admirably.

Now you can compare properties calculated on the plane and on the spheroid.

{% highlight sql %}
select 
  st_area(geom) as geomarea, 
  st_area(geog) as geogarea 
from taxlots limit 10;
{% endhighlight %}

Note that the units returned by the geography functions are metric. Square meters for area and linear meters for distances and lengths.

How about a quick spatial self-join, to test the indexes?

{% highlight sql %}
\timing

-- geography test
select sum(st_area(geog)) 
from taxlots a, taxlots b 
where st_dwithin(a.geog, b.geog, 100.0) and b.gid = 1;

-- geometry test
select sum(st_area(geom)) 
from taxlots a, taxlots b 
where st_dwithin(a.geom, b.geom, 100.0) and b.gid = 1;
{% endhighlight %}

In testing, I have been finding the geography index slightly faster than the geometry index, which is perhaps because I was able to write the geography index binding from scratch, trying to apply the lessons I have taken from reviewing the existing geometry index. In PostGIS 1.5 (coming Christmastime or sooner) the geography and geometry types will coexist, but use different disk serializations and index bindings. In PostGIS 2.0 (fall 2010) the geometry will also be swapped over to a new serialization and index binding and should become as fast (faster) than the geography index.

Finally, try out the transparent integration of the `ST_Buffer()` function from geometry with the geography type.

{% highlight sql %}
select st_area(st_buffer(geog, 2.0)) from taxlots limit 1;
{% endhighlight %}

By carefully transforming geometries out to appropriate planar spatial reference systems, you can use the functions built for geometry to provide operations on geographies. The definition for `ST_Buffer(geography, double)` looks like this:

{% highlight sql %}
CREATE OR REPLACE FUNCTION ST_Buffer(geography, float8)
  RETURNS geography
  AS '
    SELECT 
      geography(
        ST_Transform(
          ST_Buffer(
            ST_Transform(geometry($1), _ST_BestSRID($1)), 
            $2
          ), 
          4326
        )
      )'
  LANGUAGE 'SQL' IMMUTABLE STRICT;
{% endhighlight %}

Note that `ST_Transform()` appears twice, once to transform from geographics to a planar system and again to transform back after the buffer operation is complete. Also note the `_ST_BestSRID()` function, which analyzes the geography and provides a best guess planar system suitable for carrying out the operation. Right now the system picks an appropriate UTM zone, or a polar stereographic, or falls back to a mercator if there is no good choice.

**Acknowledgements:** Of course, top billing goes to the funder, who has chosen to remain anonymous. Also, it would have been impossible for me to build the `ST_Area()` or `ST_Distance()` functions on the sphere and spheroid without the contributions of David Skea (if you check the PostGIS source code, you'll find he has contributed mathematical magic in the past also). And finally, [Regina Obe](http://www.paragoncorporation.com/team.aspx) who has been testing and documenting my work as it is committed, resulting in very effective on-the-spot debugging and fixing of issues as they occur. Thanks everyone!

