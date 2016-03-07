---
layout: post
title: Performance and Contains()
date: '2007-06-12T08:11:00.000-07:00'
author: Paul Ramsey
tags: 
modified_time: '2007-06-12T08:32:41.157-07:00'
blogger_id: tag:blogger.com,1999:blog-14903426.post-8830373604617033650
blogger_orig_url: http://blog.cleverelephant.ca/2007/06/performance-and-contains.html
---

The reason I was thinking about performance improvements &mdash; and [how billing by CPU usage provides vendors with no incentive to work on them](http://blog.cleverelephant.ca/2007/06/perverse-incentives.html) &mdash; is because we have been thinking about a particular PostGIS use case recently.

Suppose you have a very large candidate table of smallish things, 10s of millions of them, and you want to find all of the smallish things that are contained by a largish polygon.  

The spatial index will be very useful for quickly winnowing down the 10s of millions of things to the 10s of thousands of things that might fall inside the polygon.  However, after that, you're left testing each of the smallish things individually for containment.  And a majority of the smallish things will be unambiguously inside the large polygon, not even close to the edge, so a great deal of computation will be wasted.  The same issue adheres to Intersects() and inversely to Within().

The trick, clearly, is to provide some kind of short circuit, so that the "easy" cases can be trivially dealt with and only the boundary cases need a full test.  

A nice approach for generally convex polygons would be a "maximum inscribed rectangle" (MIR) &mdash; any small thing whose MBR fits in the MIR is definitely contained.  However, then you have to calculate a MIR, which is itself costly.  

A variation on the MIR approach is just to superimpose the polygon on a grid and find all those squares that are fully contained in the polygon. Any smallish feature whose MBR is fully contained by "inside grid squares" is itself fully contained.

What it looks like we'll do first is to speed up the general calculation of containment, by caching a topologized version of the large polygon.  The topologized version will have an index on all the edge segments, for fast testing if a given candidate crosses the boundary, and an index for fast point-in-polygon testing.  The idea is first you see if the candidate crosses the boundary, if it does not then it must be either fully inside or fully outside, so then use a point-in-polygon test on one of the end points to see if it is in or out.

All in all, it is a lot of complexity for what seems like a very common hard-to-index case: test a large number of candidates for containment.