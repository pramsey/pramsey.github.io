---
layout: post
title: Buffering Jujutsu
date: '2008-07-26T15:14:00.000-07:00'
author: Paul Ramsey
tags: 
modified_time: '2008-08-05T10:33:52.817-07:00'
blogger_id: tag:blogger.com,1999:blog-14903426.post-8643612051290372668
blogger_orig_url: http://blog.cleverelephant.ca/2008/07/buffering-jujutsu.html
---

**Update:** Martin Davis [tried out a variant of simplification](http://www.jump-project.org/pipermail/jts-devel/2008-July/002602.html), and produced results even faster than Micha&euml;l's.

Inquiring about some slow cases in the JTS buffer algorithm, Micha&euml;l Michaud [asked](http://lists.jump-project.org/pipermail/jts-devel/2008-July/002588.html):

> I have no idea why a large buffer should take longer than a small one, and I don't know if there is a better way to compute a buffer.

[Martin Davis](http://lin-ear-th-inking.blogspot.com/) and I dragged out the usual hacks to make large buffers faster, [simplifying the input geometry, or buffering outwards in stages](http://lists.jump-project.org/pipermail/jts-devel/2008-July/002590.html). Said Martin:

> The reason for this is that as the buffer size gets bigger, the "raw offset curve" that is initially created prior to extracting the buffer outline gets more and more complex.  Concave angles in the input geometry result in perpendicular "closing lines" being created, which usually intersect other offset lines.  The longer the perpendicular line, the more other lines it intersects, and hence the more noding and topology analysis has to be performed.

A couple days later, Micha&euml;l comes back with [this](http://lists.jump-project.org/pipermail/jts-devel/2008-July/002593.html):

> I made some further tests which show there is place for improvements with the excellent stuff you recently added.
>
> I created a simple linestring: length = 25000m, number of segments = 1000
>
>Trying to create a buffer at a distance of 10000 m ended with a heapspace exception (took more than 256 Mb!) after more than 4 minutes of intensive computation !
>
>The other way is: decompose into segments (less than 1 second); create individual buffers (openjump says 8 seconds but I think it includes redrawing); cascaded union of resulting buffer (6 seconds).

Holy algorithmic cow, Batman! Creating and merging 1000 wee buffers is orders of magnitude faster than computing one large buffer, *if you merge them in the right order* (by using the [cascaded union](http://lin-ear-th-inking.blogspot.com/2007/11/fast-polygon-merging-in-jts-using.html)).  Huge kudos to Micha&euml;l for attempting such a counter-intuitive processing path and finding the road to nirvana.

