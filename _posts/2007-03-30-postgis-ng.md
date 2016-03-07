---
layout: post
title: PostGIS-NG
date: '2007-03-30T11:28:00.000-07:00'
author: Paul Ramsey
tags: 
modified_time: '2007-03-30T11:41:26.011-07:00'
blogger_id: tag:blogger.com,1999:blog-14903426.post-8779904231167852487
blogger_orig_url: http://blog.cleverelephant.ca/2007/03/postgis-ng.html
---

PostGIS has been around for a surprisingly long time now, over five years, and has accumulated a lot of crufty stuff kept around for backwards compatibility.  (The only function I have found to have been removed is an old point point-in-polygon function from the very early versions called truly_inside().)

Here are some things that I think it would be wise to pursue going forward:<ul><li>Complete SQL/MM support. We already have a [good deal](http://postgis.refractions.net/docs/ch06.html#id3062986) of it, to provide compatibility with SDE (should SDE wish to provide spatial SQL access to PostGIS).  We will need to complete curve support to get substantially closer.<li>Clean up function names, deprecate old OGC function names and move to using XX_ prefixes to define where the functions come from.  ST_ for SQL/MM, SE_ for SDE-specific, PGIS_ for PostGIS specific, etc.<li>Automagic indexes. Wrap all the ST_ functions in index magic so that Contains(A,B) kicks in the index automatically.<li>Automagic geographic support. More controversially, recognize when simple spatial ops are being called on lat/lon features and apply appropriate translations to do them in a planar system, or on a sphere/spheroid. The danger here is that in pleasing the crowd, we will quietly confuse a small number of people for whom the automagic assumptions are wrong.<li>Update documentation. PostGIS is now far in advance of its last serious documentation update. The reference material is all correct, but the tutorial level stuff needs to be updated. All the examples work, but they are not the "right" way to do things anymore.  Particularly important if we start deprecating old function names.</ul>It is a bit over-the-top to call the above changes "next generation", because only one of them (full SQL/MM curvepolygon support) would involve touching the core object representation. But they would definitely effect the user-level interaction with PostGIS a lot, and in my mind "complete" the simple-features aspect of PostGIS, allowing us to move on to the *real* next generation topics, like topology, networks, routing and other "on top of simple features" functionality.