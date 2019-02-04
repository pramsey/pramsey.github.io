---
layout: post
title: Dr. JTS comes to Crunchy
date: '2019-02-04T06:00:00.00-07:00'
#date: '2019-02-04T06:00:00.00-07:00'
author: Paul Ramsey
category: technology
tags:
- geos
- jts
- postgis
- open source
- geospatial
comments: True
image: "2019/drjts2.png"
---

Today's an exciting day in the Victoria office of Crunchy Data -- our local staff count goes from one to two, as [Martin Davis](https://github.com/dr-jts) [joins the company](https://lin-ear-th-inking.blogspot.com/2019/02/joining-crunchy-data-to-work-on-postgis.html)! 

This is kind of a big deal, because this year Martin and I will be spending much or our time on the core computational geometry library that powers PostGIS, the [GEOS library](https://trac.osgeo.org/geos), and the JTS library from which it derives its structure.

Why is that a big deal? Because GEOS, JTS and other language ports provide the computational geometry algorithms underneath most of the open source geospatial ecosystem -- so improvements in our core libraries ripple out to help a huge swathe of other software.

[JTS](https://github.com/locationtech/jts) came first, initially as a project of the British Columbia government. [GEOS](https://trac.osgeo.org/geos/) is a C++ port of JTS. There are also Javascript and .Net ports ([JSTS](https://github.com/bjornharrtell/jsts) and [NTS](https://github.com/NetTopologySuite/
NetTopologySuite, respectively).

<img src="https://docs.google.com/drawings/d/e/2PACX-1vRHW78fR1a1cYnfy3MVhXWH_kf114dO8eypgmoNqTZNYo-IOGU3_t4K29TJz-aU6SRusyJuN_gowk-Y/pub?w=967&amp;h=849">

Each of those libraries has developed a rich downline of other libraries and projects that depend on them. On the desktop, on the web, in the middleware, JTS and GEOS power all of it.

So we know that work on JTS and GEOS on our side is going to benefit far more than just PostGIS. 

I've already spent a decent amount of time on bringing the GEOS library up to date with the changes in JTS over the past few months, and trying to fulfill the "maintainer" role, merging pull requests and closing some outstanding tickets. 

As Martin starts adding to JTS, I now feel more confident in my ability to bring those changes into the C++ world of GEOS as they land.

Without pre-judging what will get first priority, topics of overlay robustness, predicate performance, and geometry cleaning are near the top of our list. 

Our spatial customers at Crunchy process a lot of geometry, so ensuring that PostGIS (GEOS) operations are robust and high performance is a big win for PostgreSQL and for our customers as well.

