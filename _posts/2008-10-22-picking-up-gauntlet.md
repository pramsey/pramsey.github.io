---
layout: post
title: Picking up the gauntlet
date: '2008-10-22T10:15:00.000-07:00'
author: Paul Ramsey
tags: 
modified_time: '2008-10-22T16:07:09.294-07:00'
blogger_id: tag:blogger.com,1999:blog-14903426.post-8859817745166843959
blogger_orig_url: http://blog.cleverelephant.ca/2008/10/picking-up-gauntlet.html
comments: True
---

[Mike Pumphrey](http://blog.geoserver.org/2008/10/22/geoserver-benchmarks-at-foss4g-2008/) over at the Geoserver blog has written a short post about this year's Geoserver-vs-Mapserver comparison.  I hope we can maintain this study as an annual event, and even get someone with an ArcServer license to join in the fun. Each iteration finds new areas that need work and resets the bar better and better every year.<img src="http://imagecache2.allposters.com/images/pic/SSPOD/superstock_40x-1557_b~At-the-Starting-Line-Posters.jpg" style="float:right" />

Basically, there are some differences that are small, and ignorable, and there are some differences that are really anomalous. And the end of the day, both systems are doing the same thing, so order-of-magnitude performance differences are cries for help.

I've been focussing on the Mapserver side. Last year, the study by Brock and Justin found an odd quirk where Mapserver got progressively worse at shape file rendering as the shape files got bigger.  I found the issue and [fixed it this spring](http://trac.osgeo.org/mapserver/ticket/2282), and (w00t!) Mapserver won the shape file race this year.

But... this year found that the PostGIS performance in Mapserver was (while fast) about half as fast as Geoserver. Hmmmm. So I know what I'll be working on this month. I have some guesses, but they will need to be tested.

Andrea added some aesthetic tests this year, and brought them to the [attention](http://lists.osgeo.org/pipermail/mapserver-dev/2008-September/007652.html) of the Mapserver team, and as a result the next release of Mapserver will include more attractive labeling results and line width control.

Any development team that's willing to swallow their pride (because for every test you win, there's one you'll lose) can get a lot of benefit in joining in this benchmarking exercise.

