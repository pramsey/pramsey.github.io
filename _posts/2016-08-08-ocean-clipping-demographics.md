---
layout: post
title: Ocean Clipping in PostGIS
date: '2016-08-24T10:05:00.004-07:00'
modified_time: '2016-08-24T10:05:00.004-07:00'
author: Paul Ramsey
category: postgis
tags:
- sql
- cartography
- clipping
comments: True
image: "2016/outsourcing.jpg"
---

{% highlight sql %}
CREATE TABLE bc_ocean AS 
SELECT ST_Union(geom)::Geometry(MultiPolygon,4326) AS geom 
FROM statcan_ocean_2011_poly 
WHERE pruid = '59' 
   OR ogc_fid IN (28179,16317,54164);;
{% endhighlight %}

{% highlight sql %}
CREATE TABLE demographics_carto As
SELECT 
  v.id, v.var1, v.var2, v.var3
  CASE 
    WHEN o.geom IS NULL
    THEN v.geom        
    ELSE ST_Multi(ST_Difference(v.geom, o.geom))::Geometry(MultiPolygon,4326) 
  END AS geom  
FROM demographics v
LEFT JOIN bc_ocean o
ON ST_Intersects(o.geom, v.geom);
{% endhighlight %}

<img src="{{ site.images }}2016/ocean_clip_1" />

<img src="{{ site.images }}2016/ocean_clip_2" />

<img src="{{ site.images }}2016/ocean_clip_3" />

<img src="{{ site.images }}2016/ocean_clip_4" />

<img src="{{ site.images }}2016/ocean_clip_5" />

<img src="{{ site.images }}2016/ocean_clip_6" />
