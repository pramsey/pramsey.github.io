---
layout: post
title: Why use ArcSDE?
date: '2008-05-26T10:51:00.000-07:00'
author: Paul Ramsey
tags: 
modified_time: '2013-08-19T13:54:22.602-07:00'
blogger_id: tag:blogger.com,1999:blog-14903426.post-1392377375133575160
blogger_orig_url: http://blog.cleverelephant.ca/2008/05/why-use-arcsde.html
comments: True
---

Those not on the PostGIS users mailing list will have missed an [interesting thread](http://lists.osgeo.org/pipermail/postgis-users/2008-May/019735.html) that pulled together some good comments from both the usual suspects and some unexpected participants. 

Some choice quotes:

* "Yes, using SDE effectively castrates the spatial database. It still walks and talks, but it's a shell of the man it was before. "* &ndash; [yours truly](http://lists.osgeo.org/pipermail/postgis-users/2008-May/019749.html)

* "The 'economical' route for those that want to use PostGIS and have edit capabilities inside ArcGIS desktop would be to use the ZigGIS professional which (from my understanding) implements an editable PostGIS layer in ArcGIS desktop."* &ndash; [Rob Tester](http://lists.osgeo.org/pipermail/postgis-users/2008-May/019747.html)

* "If you compare [pricing] with Oracle then yes probably so... But honestly if you are talking about SQL Server vs. PostgreSQL, I think the savings you get from running PostgreSQL would be dwarfed by the cost of SDE."* &ndash; [Regina Obe](http://lists.osgeo.org/pipermail/postgis-users/2008-May/019756.html)

* "Spatial databases are being commoditized, but SDE is not a spatial database, it's a revenue enhancer for ArcMap, and ArcMap is *not* being commoditized."* &ndash; [yours truly](http://lists.osgeo.org/pipermail/postgis-users/2008-May/019760.html)

* "A few disclaimers and background : Until last year, I worked at ESRI. I contributed with some of bug fixes for the PostgreSQL/PostGIS support in the ArcObjects side of things."* &ndash; [Ragi Burhum](http://lists.osgeo.org/pipermail/postgis-users/2008-May/019770.html) (read this one!)

* "There is one thing to note in a mixed-client environment and that is this: if a non-ESRI client writes an invalid geometry to a the database then when ArcSDE constructs a query over an area that includes this feature ArcSDE will discover the error (as it passed all queried features into its own shape checking routines) and stop the query"* &ndash; [Simon Greener](http://lists.osgeo.org/pipermail/postgis-users/2008-May/019778.html) (read this one!)

I'm thinking of becoming an [instigator](http://www.cbc.ca/sports/hockey/instigator/). Apparently there's money in p***ing people off.

