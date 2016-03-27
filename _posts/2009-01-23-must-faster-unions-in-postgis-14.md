---
layout: post
title: (Much) Faster Unions in PostGIS 1.4
date: '2009-01-23T12:31:00.000-08:00'
author: Paul Ramsey
tags: 
modified_time: '2009-01-23T12:58:24.503-08:00'
thumbnail: http://farm4.static.flickr.com/3492/3219940589_8a2c9127fe_t.jpg
blogger_id: tag:blogger.com,1999:blog-14903426.post-7858723334268277640
blogger_orig_url: http://blog.cleverelephant.ca/2009/01/must-faster-unions-in-postgis-14.html
comments: True
---

*Originally posted at [GeoSpeil](http://docs.opengeo.org/geospiel/2009/01/23/much-faster-unions-in-postgis/).*

I have had a very geeky week, [working](http://www.opengeo.org/blog) on bringing the "cascaded union" functionality to [PostGIS](http://www.postgis.net). 

By way of background, about a year ago, a PostGIS user [brought a question up](http://lists.osgeo.org/pipermail/postgis-users/2007-November/017653.html). He had about 30K polygons he was unioning and the process was taking hours.  ArcMap could to it in 20 minutes, what was up?  First of all, he had an [unbelievably degenerate](http://lists.osgeo.org/pipermail/postgis-users/2007-November/017673.html) data set, which really did a great job of exposing the inefficiency of the PostGIS union aggregate.  Second, the union aggregate really **was** inefficient.

This is what his data looked like, before and after union.

<img class="alignnone" title="Before Union" src="http://farm4.static.flickr.com/3492/3219940589_8a2c9127fe.jpg" alt="" width="233" height="294" /><img class="alignnone" title="After Union" src="http://farm4.static.flickr.com/3332/3219940531_0d0a301010.jpg?v=0" alt="" width="234" height="291" />

The old PostGIS [ST_Union()](http://postgis.net/docs/ST_Union.html) aggregate just naively built the final result from the input table: union rows 1 and 2 together, then add row 3, then row 4, etc. As a result, each new row generally made the interim polygon more complex &mdash; more vertices, more parts. In contrast, the "[cascaded union](http://lin-ear-th-inking.blogspot.com/2007/11/fast-polygon-merging-in-jts-using.html)" approach first structures the data set into an [STR-Tree](http://citeseerx.ist.psu.edu/viewdoc/summary?doi=10.1.1.50.2828), then unions the tree from the bottom up. As a result, adjacent bits are merged together progressively, so each stage of the union does the minimum amount of work, and creates an interim result simpler than the input components.

Implementing this new functionality in PostGIS required a few steps: first, the algorithm had to be ported from [JTS](http://sourceforge.net/projects/jts-topo-suite/) in Java to the [GEOS](http://trac.osgeo.org/geos) C++ computational geometry library; second, the C++ algorithm in GEOS had to be exposed in the public GEOS C API; third, PostGIS functions to call the new GEOS function had to be added.

The difference on the test data set from our user was stark. My first cut brought the execution time in PostGIS from 3.5 hours to 4.5 **minutes** for the sample data set. That was excellent! But, we knew that the JTS implementation could carry out the same union on the same data in a matter of seconds.  Where was the extra 4 minutes going in PostGIS?  Some profiling turned up the answer.

Before you can run the cascaded union process, you need to aggregate all the data in memory, so that a tree can be built on it.  The PostGIS aggregation was being done using [ST_Accum()](http://postgis.net/docs/ST_Accum.html) to build an array of `geometry[]`, then handing that to the union operation.  But the `ST_Accum()` aggregation was incredibly inefficient!  Four minutes of overhead isn't a bit deal when your union is taking hours, but now that it was taking seconds, the overhead was swamping the processing.

Running a profiler found the problem immediately. The `ST_Accum()` aggregate built the `geometry[]` array in memory, repeatedly `memcpy()`'ing each interim array. So the array was being copied thousands of times.  Fortunately, the upcoming version of PostgreSQL (8.4) had a new `array_agg()` function, which used a much more efficient approach to array building.  I took that code and ported it into PostGIS, for use in all versions of PostgreSQL.  That reduced the aggregation overhead to a few seconds.

Final result, the sample union now takes 26 seconds! A big improvement on the original 3.5 hour time.

Here's a less contrived result, the 3141 counties in the United States.  Using the old `ST_Union()`, the union takes 42 seconds.  Using the new `ST_Union()` (coming in PostGIS 1.4.0) the union takes 3.7 seconds.

<img class="aligncenter" title="Counties Before Union" src="http://farm4.static.flickr.com/3354/3221055992_1446bb0781.jpg" alt="" width="500" height="218" />

<img class="aligncenter" title="Counties After Union" src="http://farm4.static.flickr.com/3413/3221056044_67de7cb4aa.jpg" alt="" width="500" height="215" />

