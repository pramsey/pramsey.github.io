---
layout: post
title: Breaking a Linestring into Segments
date: '2015-02-06T10:50:00.001-08:00'
author: Paul Ramsey
category: technology
tags:
- postgis
modified_time: '2015-03-19T05:38:21.094-07:00'
blogger_id: tag:blogger.com,1999:blog-14903426.post-6033266774773224546
blogger_orig_url: http://blog.cleverelephant.ca/2015/02/breaking-linestring-into-segments.html
comments: True
---

Like doing a sudoku, solving a "simple yet tricky" problem in spatial SQL can grab ones mind and hold it for a period. Someone on the PostGIS IRC channel was trying to "convert a linestring into a set of two-point segments", using an external C++ program, and I thought: "hm, I'm sure that's doable in SQL".

And sure enough, it is, though the syntax for referencing out the parts of the dump objects makes it look a little ugly.

<script src="https://gist.github.com/pramsey/87f8d7cb0633282c37e5.js"></script> 