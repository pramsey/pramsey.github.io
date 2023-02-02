---
layout: post
title: 'When Proj Grid-Shifts Disappear'
date: '2023-02-02T00:00:00-08:00'
author: Paul Ramsey
category: technology
tags:
- postgis
comments: True
image: "2023/datum.gif"
---

Last week a user noted on the [postgis-users](https://lists.osgeo.org/pipermail/postgis-users/2023-January/045829.html) list (paraphrase):

> I upgraded from PostGIS 2.5 to 3.3 and now the results of my coordinate transforms are wrong. There is a **vertical shift** between the systems I'm using, but my vertical coordinates are unchanged.

Hmmm. 

PostGIS gets all its coordinate reprojection smarts from the [proj](https://proj.org/) library. The user's query looked like this:

```sql
SELECT ST_AsText(
    ST_Transform('SRID=7405;POINT(545068 258591 8.51)'::geometry, 
    4979
    ));
```

"We just use proj" is a lot less certain and stable an assertion than it appears on the surface. In fact, PostGIS "just uses proj" for proj versions from 4.9 all the way up to 9.2, and there has been a [lot of change](https://github.com/OSGeo/PROJ/blob/master/NEWS) to the proj library over that sweep of releases.

* The API radically changed around proj version 6, and that required a [major rework](https://proj.org/development/migration.html) of how PostGIS called the library.
* The way proj dereferenced spatial reference identifiers into reprojection algorithms changed around then too (it got much slower) which required more changes in how we interacted with the library.
* More recently the way proj handled "transformation grids" changed, which was the source of the complaint.

## Exploring Proj

The first thing to do in debugging this "PostGIS problem" was to establish if it was in fact a PostGIS problem, or a problem in proj. There are commandline tools in proj to query what pipelines the system will use for a transform, and what the effect on coordinates will be, so I can take PostGIS right out of the picture.

We can run the query on the commandline:

```
echo 545068 258591 8.51 | cs2cs 'EPSG:7405' 'EPSG:4979'
```

Which returns:

```
52d12'23.241"N  0d7'17.603"E 8.510
```

So directly using proj we are seeing the same problem as in PostGIS SQL: no change in the vertical dimension, it goes in at 8.51 and comes out at 8.51. So the problem is not PostGIS, **is is proj**.

## Transformation Grids

Cartographic transformations are nice deterministic functions, they take in a longitude and latitude and spit out an X and a Y.

```
(x,y) = f(theta, phi)
(theta, phi) = finv(x, y)
```

But not all transformations are cartographic transformations, some are transformation between geographic reference systems. And many of those are lumpy and kind of random. 

For example, the North American 1927 Datum (NAD27) was built from [classic survey techniques](https://civilstuff.com/what-is-chain-surveying/), starting from the "middle" (Kansas) and working outwards, chain by chain, sighting by sighting. The North American 1983 Datum (NAD83) was built with the assistance of the first GPS units. The accumulated errors of survey over distance are not deterministic, they are kind of lumpy and arbitrary. So the transformation from NAD27 to NAD83 is also kind of lumpy and arbitrary.

How do you represent lumpy and arbitrary transformations? With a grid! The grid says "if your observation falls in this cell, adjust it this much, in this direction".

For the NAD27->NAD83 conversion, the NADCON grids have been around (and continuously improved) for a generation. 

Here's a picture of the horizontal deviations in the NADCON grid.

![]({{ site.images }}/2023/nadcon-5.jpg)

Transformations between vertical systems also frequently require a grid.

So what does this have to do with our bug? Well, the way proj gets its grids changed in version 7.

## Grid History

Proj grids have always been a bit of an outlier. They are much larger than just the source code is. They are localized in interest (someone in New Zealand probably doesn't need European grids), not everyone needs all the grids. So historically they were distributed in zip files **separately** from the code. 

This is all well and good, but software **packagers** wanted to provide a good "works right at install" experience to their end users, so they bundled up the grids into the proj packages. 

As more and more people consumed proj via packages and software installers, the fact that the grids were "separate" from proj became invisible to the end users: they just download software and it works.

This was fine while the collection of grids was a manageable size. But it is not manageable any more. 

In working through the [GDALBarn](https://gdalbarn.com/) project to improve proj, [Even Roualt](https://www.spatialys.com/en/about/) decided to find all the grids that various agencies had released for various places. It turns out, there are a lot more grids than proj previously bundled. Gigabytes more.

## Grid CDN

Simply distributing the whole collection of grids as a default with proj was not going to work anymore.

So for proj 7, Even [proposed](https://proj.org/community/rfc/rfc-4.html) moving to a download-on-demand model for proj grids. If a transformation request requires a grid, proj will attempt to download the necessary grid from the internet, and save it in a local cache.

Now everyone can get the very best possible tranformation between system, everywhere on the globe, as long as they are connected to the internet.

## Turn It On!

Except... the [network grid feature](https://proj.org/usage/network.html) is not turned on by default! So for versions of proj higher than 7, the software ships with no grids, and the software won't check for grids on the network... until you turn on the feature!

There are three ways to turn it on, I'm going to focus on the `PROJ_NETWORK` environment variable because it's easy to toggle. Let's look at the proj transformation pipeline from our original bug.

```
projinfo -s EPSG:7405 -t EPSG:4979
```

The `projinfo` utility reads out all the possible transformation pipelines, in order of desirability (accuracy) and shows what each step is. Here's the most desireable pipeline for our transform.

```
+proj=pipeline
  +step +inv +proj=tmerc +lat_0=49 +lon_0=-2 +k=0.9996012717 +x_0=400000
        +y_0=-100000 +ellps=airy
  +step +proj=hgridshift +grids=uk_os_OSTN15_NTv2_OSGBtoETRS.tif
  +step +proj=vgridshift +grids=uk_os_OSGM15_GB.tif +multiplier=1
  +step +proj=unitconvert +xy_in=rad +xy_out=deg
  +step +proj=axisswap +order=2,1
```

This transform actually uses **two** grids! A horizontal **and** a vertical shift. Let's run the shift with the network explicitly turned **off**.

```
echo 545068 258591 8.51 | PROJ_NETWORK=OFF cs2cs 'EPSG:7405' 'EPSG:4979'

52d12'23.241"N  0d7'17.603"E 8.510
```

Same as before, and the elevation value is unchanged. Now run with `PROJ_NETWORK=ON`.

```
echo 545068 258591 8.51 | PROJ_NETWORK=ON cs2cs 'EPSG:7405' 'EPSG:4979'

52d12'23.288"N  0d7'17.705"E 54.462
```

Note that the horizontal and vertical results are different with the network, because we now have **access to both grids**, via the CDN.

## No Internet?

If you have no internet, how do you do grid shifted transforms? Well, much like in the old days of proj, you have to manually grab the grids you need. Fortunately there is a utility for that now that makes it very easy: [projsync](https://proj.org/apps/projsync.html).

You can just download all the files:

```
projsync --all
```

Or you can download a subset for your area of concern:

```
projsync --bbox 2,49,2,49
```

If you don't want to turn on network access via the environment variable, you can hunt down the `proj.ini` file and flip the `network = on` variable.