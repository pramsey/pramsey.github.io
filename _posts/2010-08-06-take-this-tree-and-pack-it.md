---
layout: post
title: Take this Tree and Pack it
date: '2010-08-06T15:51:00.000-07:00'
author: Paul Ramsey
tags: 
modified_time: '2010-08-07T15:03:03.784-07:00'
thumbnail: http://4.bp.blogspot.com/_uYlrslhrgyY/SrvWIvKAeWI/AAAAAAAAABg/OJ25YFNVCN8/s72-c/packed.png
blogger_id: tag:blogger.com,1999:blog-14903426.post-9220564513978512526
blogger_orig_url: http://blog.cleverelephant.ca/2010/08/take-this-tree-and-pack-it.html
comments: True
---

<img src="http://4.bp.blogspot.com/_uYlrslhrgyY/SrvWIvKAeWI/AAAAAAAAABg/OJ25YFNVCN8/s400/packed.png" style="float:right; padding: 3px; width: 200px;"/>Noticing this a little late, but have a peak at these posts from Chris Hodgson about how the R-Tree [fails for variable density GIS](http://cognitivelychris.blogspot.com/2008/10/nitpicking-pick-split.html) data, and his [approach to a packing process](http://cognitivelychris.blogspot.com/2009/09/send-your-r-trees-packing.html).  Unfortunately, packing is a post-facto process, and it's not clear to me how we would do it with the GiST infrastructure that undergirds the PostGIS database. But it's nice to see a good R-Tree and a reminder of just how ugly they can get under the covers.

