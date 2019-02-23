---
layout: post
title: Proj6 in PostGIS
date: '2019-02-22T06:00:00.00-07:00'
author: Paul Ramsey
category: technology
tags:
- proj
- postgis
- reprojection
- epsg
comments: True
image: "2019/proj1.png"
---

[Map projection](https://en.wikipedia.org/wiki/Map_projection) is a core feature of any spatial database, taking coordinates from one coordinate system and converting them to another, and [PostGIS](http://postgis.net) has depended on the [Proj](https://proj4.org/) library for coordinate reprojection support for many years.

<img src="{{ site.images }}{{ page.image }}" alt="{{ page.title }}" />

For most of those years, the Proj library has been extremely slow moving. New projection systems might be added from time to time, and some bugs fixed, but in general it was easy to ignore. How slow was development? So slow that the version number migrated into the name, and everyone just called it "Proj4".

No more.

Starting a couple years ago, [new developers](https://github.com/OSGeo/proj.4/blob/master/AUTHORS) started migrating into the project, and the pace of development picked up. [Proj 5](https://proj4.org/news.html#proj-5-0-0) in 2018 dramatically improved the plumbing in the difficult area of geodetic transformation, and promised to begin changing the API. Only a year later, here is [Proj 6](https://github.com/OSGeo/proj.4/blob/50cfb37a04c452bbdec2f6ce3c09ee20624ccb7f/NEWS), with yet more huge infrastructural improvements, and the new API. 

Some of this new work was funded via the [GDALBarn](https://gdalbarn.com/) project, so thanks go out to those sponsors who invested in this incredibly foundational library and GDAL maintainer [Even Roualt](https://github.com/rouault).

For PostGIS that means we have to [accomodate ourselves](https://trac.osgeo.org/postgis/ticket/4322) to the new API. Doing so not only makes it easier to track future releases, but gains us access to the fancy new plumbing in Proj.

<img src="{{ site.images }}/2019/proj2.jpg" alt="{{ page.title }}" />

For example, Proj 6 provides:

> Late-binding coordinate operation capabilities, that takes  metadata such as
area of use and accuracy into account... This can avoid in a
number of situations the past requirement of using WGS84 as a pivot system,
which could cause unneeded accuracy loss.

Or, put another way: more accurate results for reprojections that involve datum shifts.

Here's a simple example, converting from an old [NAD27/NGVD29](http://epsg.io/7406) 3D coordinate with height in feet, to a new [NAD83/NAVD88](http://epsg.io/5500) coordinate with height in metres.

{% highlight sql %}
SELECT ST_Astext(
         ST_Transform(
           ST_SetSRID(geometry('POINT(-100 40 100)'),7406), 
           5500));
{% endhighlight %}

Note that the height in NGVD29 is **100 feet**, if converted directly to meters, it would be **30.48 metres**. The transformed point is:

    POINT Z (-100.0004058 40.000005894 30.748549546)

Hey look! The elevation is slightly higher! That's because in addition to being run through a **horizontal** NAD27/NAD83 grid shift, the point has also been run through a **vertical** shift grid as well. The result is a more correct interpretation of the old height measurement in the new vertical system.

Astute PostGIS users will have long noted that PostGIS contains three sources of truth for coordinate references systems (CRS).

Within the `spatial_ref_sys` table there are columns:

* The `authname`, `authsrid` that can be used, if you have an authority database, to lookup an `authsrid` and get a CRS. Well, Proj 6 now ships with such a database. So there's one source of truth.
* The `srtext`, a string representation of a CRS, in a [standard ISO format](https://www.iso.org/standard/63094.html). That's two sources.
* The `proj4text`, the old [Proj string](https://proj4.org/operations/projections/index.html) for the CRS. Until Proj 6, this was the only form of definition that the Proj library could consume, and hence the only source of truth that mattered to PostGIS. Now, it's a third source of truth.

Knowing this, when you ask PostGIS to transform to an SRID, what will it do?

* If there are non-NULL values in `authname` and `authsrid` ask Proj to return a CRS based on those entries.
* If Proj fails, and there is a non-NULL `srtext` ask Proj to build a CRS using that text.
* If Proj still fails, and there is a non-NULL `proj4text` ask Proj to build a CRS using that text.

In general, the best transforms will come by having Proj look-up the CRS in its own database, because then it can apply all the power of "late binding" to ensure the best transformation for each geometry. Hence we bias in favour of Proj lookups, then the quite detailed WKT format, and finally the old Proj format.




