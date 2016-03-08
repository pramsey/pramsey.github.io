---
layout: post
title: Introspection Double-Shot
date: '2014-02-04T11:05:00.002-08:00'
author: Paul Ramsey
category: technology
tags:
- postgis
- twitter
- tempest
modified_time: '2014-02-04T11:05:36.459-08:00'
thumbnail: http://4.bp.blogspot.com/-RGdDFOS0fq0/UvEz2m-CP7I/AAAAAAAAAIg/9ypyk7YsUOM/s72-c/screenshot_09.png
blogger_id: tag:blogger.com,1999:blog-14903426.post-8844587424420415199
blogger_orig_url: http://blog.cleverelephant.ca/2014/02/introspection-double-shot.html
comments: True
---

<p>Davy Stevenson has a [great post](http://davystevenson.com/2014/02/03/how-to-accidentally-be-a-jerk-on-twitter.html) (everyone should write more, more often) on a small Twitter storm she precipitated and that I participated in. Like all sound-and-fury-signifying-nothing it was mostly about misunderstandings, so I'd like to add my own information about mental state to help clarify where I come from as a maintainer. 

First, PostGIS is full of shortcomings. Have a look at the (never shrinking) [ticket backlog](http://trac.osgeo.org/postgis/report/3). Sure, a lot of those are feature ideas and stuff in "future", but there's also lots of bugs. Fortunately, most of those bugs affect almost nobody, and are easily avoided (so people report them, then avoid them). 

When we first come up an a "major" release (2.0 to 2.1 for example) I expect lots of bugs to shake out in the early days, as people try the new release in ways that are not anticipated by our regression tests. (It's worth noting that the ever-growing collection of regression tests provides a huge safety net under our work, allowing us to add features and speed without breaking things... for cases we test.) 

My expectation is that the relative severity of bugs reported decreases as the time from initial release increases. Basically, people will always be finding bugs, but they will be for narrower and narrower user cases, data situations that come up extremely infrequently. 

[The bug](http://trac.osgeo.org/postgis/ticket/2556) Davy's team ran across broke my usual rules. It took quite a while for users to find and report, and yet was broad enough to affect moderately common use cases. However, is was also something the vast majority of PostGIS users would not run across: </p><ul><li>If you were using the Geography type, **and**</li><li>If you were storing polygons in your Geography column, **and**</li><li>If you queried your column with another Polygon, **and**</li><li>If the query polygon was fully contained in one of the column polygons, **then**</li><li>The distance reported between the polygons would be non-zero (when it should be zero!)</li></ul><p>It happens! It happened to Davy's team, and it happened to other folks (the ones who originally filed [#2556](http://trac.osgeo.org/postgis/ticket/2556)) &mdash; I was actually working on the bug on the plane a couple weeks before. It was a tricky one to both find and to diagnose, because it was related to caching behaviour: you could not reproduce it using a query that returned a single record, it had to return more than one record.  

If I was prickly about the report from Davy: 

<img border="0" src="http://4.bp.blogspot.com/-RGdDFOS0fq0/UvEz2m-CP7I/AAAAAAAAAIg/9ypyk7YsUOM/s1600/screenshot_09.png" />

And pricklier still about the less nuanced report of her colleague Jerry: 

<img border="0" src="http://4.bp.blogspot.com/-L8DUrb8VOSM/UvEz2v131-I/AAAAAAAAAIk/MOgRGPnGP9A/s1600/screenshot_10.png" />

That prickliness arose because, on the basis of a very particular and narrow (but real!) use case, they were tarring the **whole release**, which had been out and functioning perfectly well for thousands and thousands of users for months. 

Also, I was feeling guilty for not addressing it earlier. PostGIS has gotten a lot bigger than me, and I don't even try to address raster or topology bugs, but in the vector space I take pride in knocking down real issues quickly. But this issue had dragged on for a couple months without resolution, despite the diligent sleuthing of [Regina Obe](http://www.bostongis.com), and a perfect [reproduction case](http://trac.osgeo.org/postgis/ticket/2556#comment:1) from "gekorob", the original reporter. 

That's where I'm coming from. 

I can also empathize with Jerry and others who ran across this issue. It's slippery, it would eat up a non-trivial amount of time isolating. Having had the time eaten, a normal emotional response would be "goddamn it, PostGIS, you've screwed me, I won't let you screw others!" Also, having eaten many of your personal hours, the bug would appear **big** not narrow, worthy of a broadcast condemnation, not a modest warning. 

Anyways, that's the tempest and teapot. I'm going to finish my morning by putting this case into the regression suite, so it'll never recur again. That's the best part of fixing a bug in PostGIS, locking the door behind you so it can never come out again.</p>