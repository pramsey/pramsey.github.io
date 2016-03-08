---
layout: post
title: Point-in-Polygon Shortcuts
date: '2008-09-28T12:15:00.000-07:00'
author: Paul Ramsey
tags: 
modified_time: '2008-09-29T15:13:27.834-07:00'
blogger_id: tag:blogger.com,1999:blog-14903426.post-8490486116295927461
blogger_orig_url: http://blog.cleverelephant.ca/2008/09/point-in-polygon-shortcuts.html
comments: True
---

The code for spatial predicates in PostGIS is largely dependent on the GEOS topology library, because doing predicate calculations in generality is hard, and GEOS already exists.  <img src="http://www.spatialanalysisonline.com/output/images/image232.jpg" style="float:right; padding:4px;" />However, moving geometry from PostGIS into GEOS format incurs a cost.  And not all predicate algorithms are hard.  Point-in-polygon tests, for example, are relatively easy.

So, for performance reasons, a couple years ago, Mark Leslie (at Refractions at the time) implemented a point-in-polygon test directly in the PostGIS library.  Whenever ST_Contains(), ST_Intersects(), etc, are called, the geometries are first checked to see if they are points and polygons, and if they are, GEOS is avoided and the calculation is done in PostGIS.

But, why stop at one shortcut?

[What if you are testing](http://blog.cleverelephant.ca/2007/06/performance-and-contains.html) hundreds (or thousands) of points against one, or a small number, of polygons? Why iterate through all the segments of the polygon for every point, to carry out the test? By indexing the segments of the polygon, you can reduce the computational effort of doing a point-in-polygon test from O(NumberOfPolygonEdges) to O(log(NumberOfPolygonEdges)). However, for the index to be effective, you have to re-use it for each new point, not re-build it for every polygon/point pair. That means it has to be cached between function calls.

A bit over a year ago, Mark implemented a caching version of the point-in-polygon shortcut, with an indexing algorithm from [Martin Davis](http://lin-ear-th-inking.blogspot.com/), and that shortcut currently resides in the 1.3 release series. However, it has two drawbacks. 

<ul><li>First, it only works for POLYGON/POINT combinations, and most people working with polygons actually have MULTIPOLYGON/POINT (though their multi-polygons usually only have one member).</li><li>Second, it leaks a lot of memory during processing, so the postgres process size can get very large while the computation is running (PostgreSQL retrieves the memory at the end, so no permanent damage is done).</li></ul><br />Last week I took a couple days to delve deeply into what this shortcut was doing, and made the following improvements.

<ul><li>Removed all the memory leaks, so the process size remains constant throughout the run.</li><li>Added support for MULTIPOLYGON types.</li><li>Improved the caching logic slightly, so that segment indexes are only built when a polygon has been seen two times in a row, otherwise using a standard non-indexed version of the point-in-polygon algorithm.</li></ul><br />The point-in-polygon caching shortcut is extremely effective. Using the un-cached code, a spatial join of 8000 points to 80 polygons, where there are an average of 100 points per polygons, takes about 30 seconds on my workstation. With the caching segment indexes, the same join returns in 6 seconds.

The improved code is currently on trunk only, but I will back-port it into 1.3.X next week, so it will be available in the next points release.

**Update:** These changes have now been back-ported to 1.3 and will be generally available in 1.3.4 when it is released.

