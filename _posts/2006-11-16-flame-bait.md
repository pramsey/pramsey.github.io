---
layout: post
title: Flame Bait
date: '2006-11-16T21:15:00.000-08:00'
author: Paul Ramsey
tags: 
modified_time: '2006-11-16T22:09:30.578-08:00'
blogger_id: tag:blogger.com,1999:blog-14903426.post-2734446781416812342
blogger_orig_url: http://blog.cleverelephant.ca/2006/11/flame-bait.html
comments: True
---

Why end the evening on a high note, when I can end it rancourously and full of bile!

On the [postgis-users](http://lists.osgeo.org.net/mailman/listinfo/postgis-users) mailing list, Stephen Woodbridge [writes](https://lists.osgeo.org/pipermail/postgis-users/2006-November/013882.html):

> Can you describe what dynamic segmentation is? What is the algorithm? I guess I can google for it ...

As with many things, the terminological environment has been muddied by the conflation of specific ESRI terms for particular features with generic terms for the similar things.  Call it the "Chesterfield effect".

* ESRI "Dynamic segmentation" is really just "linear referencing of vectors and associated attributes".
* ESRI "Geodatabase" is "a database with a bunch of extra tables defined by and understood almost exclusively by ESRI"
* ESRI "Coverage" is a "vector topology that covers an area" (ever wonder why the OGC Web Coverage Server specification is about delivering *raster* data, not vector topologies? because most people have a different understanding of the word than us GIS brainwashees).
* ESRI "Topology" is a "middleware enforcement of spatial relationship rules"

ESRI rules the intellectual world of GIS people so thoroughly that they define the very limits of the possible. Just last week someone told me "oh, editing features over the web? the only way to do that is with ArcServer". 

The **only** way, and said with complete certainty. You don't want to argue with people like that, it seems almost rude, like arguing with people about religion.