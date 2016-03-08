---
layout: post
title: Is "Good Enough" Good Enough?
date: '2009-11-30T17:16:00.000-08:00'
author: Paul Ramsey
tags: 
modified_time: '2009-11-30T18:46:47.064-08:00'
blogger_id: tag:blogger.com,1999:blog-14903426.post-2422858832117107392
blogger_orig_url: http://blog.cleverelephant.ca/2009/11/is-good-enough-good-enough.html
comments: True
---

The gift that keeps on giving, for me, is performance work. Users love it, and it tickles my cerebral cortex in a way other work just cannot touch. Some of my first substantive patches to MapServer were performance patches, and I've also taken that tack into PostGIS.

One of the things that surprised me while investigating the MapServer QIX index structure was how little a badly built tree impacted real world performance. The QIX file, when built on point files, tends to build in far more depth than it needs, strictly speaking. The extra depth adds theoretical time to traverse the tree for searches and yet... even when I tested quite huge shape files the performance was fine.

Recently I've been looking again at internally indexing geometries for high performance testing of things like distance and intersections. We already have some of this for PostGIS, using the GEOS "PreparedGeometry" construction, but I'd like a native implementation, and something that doesn't necessarily depend on a cached implementation.

There is already a form of internally indexed testing in PostGIS, in the point-in-polygon case, and while reading it over I was struck by the elegance of the underlying assumption: rather than pre-sort the geometry edges, and then build the tree, the implementation simply scans the point array from start to finish and builds parent nodes from each successive pair of nodes. The result is not a perfect tree, by any stretch of the imagination, but... it's good enough. Because the edges are spatially auto-correlated, the parent nodes end up having good locality. 

The beauty of this approach to index building is that since there is no sorting step and no re-balancing of the tree or any of that fancy stuff, you can actually build an "index" in O(n) time. A brute force intersection test is O(nm) time. But if you can build your indexes in O(n) time the cost of doing an intersection starts to get closer to O(n+m) time! (Note, I am not a computer scientist and the O() term for the actual tree-on-tree intersection test is beyond my powers.)

Now, since no sorting is being applied in the building of these "indexes" they could theoretically be terrible indexes. But since we're indexing GIS data, and the edges have this wonderful autocorrelation, they are actually "good enough", and obtainable in very little time.

The same tricks apply to building indexes for intersection and distance in geodetic space, which I predict will be in hot demand once people experience just how computationally expensive operations on the new PostGIS 1.5 <code>geography</code> type are!

