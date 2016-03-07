---
layout: post
title: Extra, extra, PostGIS Really Fast!
date: '2009-12-10T15:09:00.000-08:00'
author: Paul Ramsey
tags: 
modified_time: '2009-12-10T15:12:42.113-08:00'
blogger_id: tag:blogger.com,1999:blog-14903426.post-1706889555645827424
blogger_orig_url: http://blog.cleverelephant.ca/2009/12/extra-extra-postgis-really-fast.html
---

Because, frankly, I love nothing more than approbation, I am going to quote [this comment](http://blog.cleverelephant.ca/2009/01/must-faster-unions-in-postgis-14.html?showComment=1260481766531#c388201837491522179) on "[Much Faster Unions in PostGIS](http://blog.cleverelephant.ca/2009/01/must-faster-unions-in-postgis-14.html)" in full:

<blockquote>This is a truly spectacular piece of work. We have often been asked by clients to buffer and merge point datasets with several million points. We attempted this using ArcWhatever (could barely open the points, let along buffer them) and FME, which ran for a week and then gave an out of memory error. So, I do the whole configure, make, make install thing, 4 times, for postgres, goes, proj4 and postgis. After a lot of swearing and running ldconfig a few million times I eventually get postgis to accept that geos really is installed -- MySQL might have more limited spatial functionality, but it sure is a lot easier to build from source. Anyway, I digress. I run a few random queries using the excellent generate series capability in postgres, and manage to create, buffer and merge 100,000 points in a few seconds. Finally, I try this on a real world dataset, namely all of the postal addresses in Wales, 1.4 million or so. With a 200m buffer, this ran on a reasonably pokey 64-bit linux box in 19 minutes. Truly astonishing. Well done. Much as I love MySQL, this was a bit of St. Paul on the road to Damascus moment. </blockquote>

Full credit to Martin Davis, who [implemented this technique](http://lin-ear-th-inking.blogspot.com/2007/11/fast-polygon-merging-in-jts-using.html) in JTS. We just borrowed it for database land.

