---
layout: post
title: Sponsor GEOS, Make PostGIS Faster
date: '2008-10-14T12:04:00.000-07:00'
author: Paul Ramsey
tags: 
modified_time: '2008-10-14T12:14:22.136-07:00'
blogger_id: tag:blogger.com,1999:blog-14903426.post-702881655970876206
blogger_orig_url: http://blog.cleverelephant.ca/2008/10/sponsor-geos-make-postgis-faster.html
comments: True
---

Martin Davis [just posted](http://lin-ear-th-inking.blogspot.com/2008/10/improvements-to-jts-buffering.html) about his improvements to the JTS buffering routines, speeding up buffering by a mere factor of 20 or so.

Martin has also added some improvements in the area of unions for large sets of geometries, a technique he calls "[cascaded union](http://lin-ear-th-inking.blogspot.com/2007/11/fast-polygon-merging-in-jts-using.html)".  It too is good for orders-of-magnitude performance improvements.

Do you have PostGIS queries of this form:

<code>SELECT [...], ST_Buffer(the_geom,1000) FROM [...] WHERE [...]</code>

or

<code>SELECT ST_Union(the_geom) FROM mytable WHERE [...] GROUP BY [...]</code>

If you do, then getting Martin's JTS algorithms ported to [GEOS](http://trac.osgeo.org/geos) (the C++ geometry library used by PostGIS) will make your database run faster. Lots faster. 

How can you help that happen? Become an OSGeo &ldquo;[Project Sponsor](http://wiki.osgeo.org/wiki/Project_Sponsorship)&rdquo; for GEOS. Project sponsor commit a modest sum to the ongoing maintenance of the code, which is generally used for hiring a maintainer to do things like ensure patches are properly integrated, that tests are added for reliability, and that upgrades like the ones Martin has created get folded into the code base in a timely manner.

If you're interested in sponsoring GEOS development, please get in touch with me. If you are using PostGIS in your business, it is money well spent.

