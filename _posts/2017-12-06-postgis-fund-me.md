---
layout: post
title: 'PostGIS "Fund Me" Milestone'
date: '2017-12-06T08:00:00-08:00'
author: Paul Ramsey
category: technology
tags:
- postgis
- open source
comments: True
image: "2017/postgis-logo.jpg"
---

On the twitter this morning, there was a good question:

<blockquote class="twitter-tweet" data-lang="en"><p lang="en" dir="ltr"><a href="https://twitter.com/postgis?ref_src=twsrc%5Etfw">@postgis</a> what is the Fund Me milestone mean? There is a feature request there that we are interested in using: <a href="https://t.co/jqGKjOgueQ">https://t.co/jqGKjOgueQ</a></p>&mdash; Jonas Stawski (@jstawski) <a href="https://twitter.com/jstawski/status/938452458698928128?ref_src=twsrc%5Etfw">December 6, 2017</a></blockquote>
<script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

TL;DR: If you find a feature in "Fund Me" and want to fund it, join the [postgis-devel](https://lists.osgeo.org/mailman/listinfo/postgis-devel) mailing list and make yourself known. 
{: .note }

If you go to the [PostGIS ticket report](https://trac.osgeo.org/postgis/report/3) and scroll through the pages you'll first see some milestones tied to released versions. These are usually bug reports, both big and small, valid and invalid, and will eventually be closed. 

We unfortunately carry a lot of tickets in the current development milestone (2.5 right now) which are, at best, speculative. They should probably be closed (we really will never do them and don't much care) or moved to the "Fund Me" category (they are valid, but we have no personal/professional impetus to address them).

The "Fund Me" category used to be called "Future". This was a bad name, as it implied that sometime in the "Future" the ticket might actually be addressed, and all you needed was **sufficient patience** to wait. The reality is that the way a ticket got into the "Future" category was that it was ignored for long enough that we couldn't stand to see it in the current milestone anymore. 

The PostGIS development community includes all kinds of developers, who make livings in all kinds of ways, and there are folks who will work on tasks for money. The "Fund Me" milestone is a way of pointing up that there are tasks that can be done, if only someone is willing to pay a developer to do them.

That's the good news!

The bad news is that the tickets all look the same, but they are wildly variable in terms of level of effort and even feasibility.

* [#220](https://trac.osgeo.org/postgis/ticket/220) "Implement ST_Numcurves and ST_CurveN" would probably take a couple hours at the outside, and almost any C developer could do it, even oen with zero experience in the PostGIS/PostgreSQL/GEOS ecosystem.
* [#2597](https://trac.osgeo.org/postgis/ticket/2597) "[raster] St_Grayscale" would require some knowledge of the PostGIS raster implementation and image processing routines or at least the GDAL library.
* [#2910](https://trac.osgeo.org/postgis/ticket/2910) "Implement function to output Mapbox Vector Tiles" actually happened in 2.4, but the (duplicate) ticket remained open, as a reminder that we're terrible at ticket management.

And then there's the "big kahunas", tasks that live quietly in one ticket but actually encompass massive research and development projects spanning months or years.

* [#1629](https://trac.osgeo.org/postgis/ticket/1629) "Tolerance and Precision strategy" is a super idea, that would allow functions like `ST_Intersects()` or `ST_Equals()` to return true if a condition was met within a tolerance. However, it would require substantial enhancement to GEOS, to allow predicate evaluation within a tolerance context, as well as a changes to non-GEOS backed distance functions, and new signatures for every geometry relationship function. Given the depth of the GEOS problem, I'd estimate multiple months of effort, and a potential for zero deliverables at all if things went pear-shaped.
* [#472](https://trac.osgeo.org/postgis/ticket/472) "Missing ST_IsValid for Geography Types" is even worse than the tolerance problem, since it should really be implemented as a complete rewrite of GEOS to understand non-linear edge types, either through a cheater's strategy to turn do local projections of geographic edges, or as a full understanding of geographic edges. On the upside, doing that would allow many of the other GEOS functions to support geography which would vastly expand geography functionality in one stroke. On the downside, it is again in the category of a year-long effort with a potential failure at the end of it if for unexpected reasons it turns out to be impossible within that timeframe.

These kind of core features basically never get funded, because the marginal benefit they provide is generally much lower than the development cost for any one organization. This is a common open source weakness: aggregating funding is something everyone agrees is a great idea in principle but [rarely happens in practice](http://blog.cleverelephant.ca/2005/10/concurrency-for-postgis.html). 

Occasionally, lightning does strike and a major funded feature happens. PostGIS topology was funded by a handful of European governments, and my work on the geography type was [funded entirely by Palantir](https://www.directionsmag.com/article/1638). However, usually funders show up with a few thousand dollars in hand and are dismayed when they learn of the distance between their funds and their desires.