---
layout: post
title: Snapping Points in PostGIS
date: '2008-04-08T15:38:00.001-07:00'
author: Paul Ramsey
tags: 
modified_time: '2008-04-08T15:44:42.115-07:00'
blogger_id: tag:blogger.com,1999:blog-14903426.post-1632710810256723515
blogger_orig_url: http://blog.cleverelephant.ca/2008/04/snapping-points-in-postgis.html
---

Fun question on the #postgis IRC channel today, just hard enough to be interesting and just easy enough to not be overwhelming:

> Given a table of points and a table of lines, snap all the points within 10 metres of the lines to the lines.

My first thought was "PostGIS doesn't have that snapping function", but it actually does, hidden in the linear-referencing functions: `ST_Line_Locate_Point(line, point)`.

OK, that returns a measure along the line, but I want a point! No problem, ST_Line_Interpolate_Point(line, measure) returns a point from a measure.

Great, so now all I need are, for each point within 10 metres of the lines, the nearest line. Yuck, finding the minimum.  However, with the PostgreSQL `DISTINCT ON` syntax and some ordering, it all pops out:

{% highlight sql %}
SELECT DISTINCT ON (pt_id)
    pt_id,
    ln_id, 
    ST_AsText(
        ST_line_interpolate_point(
            ln_geom, 
            ST_line_locate_point(ln_geom, vgeom)
        )
    ) 
FROM
(
    SELECT 
        ln.the_geom AS ln_geom,
        pt.the_geom AS pt_geom, 
        ln.id AS ln_id, 
        pt.id AS pt_id, 
        ST_Distance(ln.the_geom, pt.the_geom) AS d
    FROM 
        point_table pt, 
        line_table ln 
    WHERE 
        ST_DWithin(pt.the_geom, ln.the_geom, 10.0) 
    ORDER BY pt_id, d
) AS subquery;
{% endhighlight %}
                           
The sub-query finds all the points/line combinations that meet the 10 meter tolerance rule, and returns them in sorted order, by point id and distance.  The outer query then strips off the first entry for each distinct point id and runs the LRS functions on it to derive the new snapped point.

Snapperiffic!