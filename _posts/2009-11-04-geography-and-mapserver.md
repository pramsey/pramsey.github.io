---
layout: post
title: Geography and MapServer
date: '2009-11-04T15:25:00.000-08:00'
author: Paul Ramsey
tags: 
modified_time: '2009-11-04T15:36:48.841-08:00'
blogger_id: tag:blogger.com,1999:blog-14903426.post-3403960739921712772
blogger_orig_url: http://blog.cleverelephant.ca/2009/11/geography-and-mapserver.html
comments: True
---

Can you use the new PostGIS <code>GEOGRAPHY</code> type with [MapServer](http://mapserver.org)? Yes! Just make sure your LAYER declares a geographic projection (e.g. "init=epsg:4326", or "proj=lonlat") so the correct coordinates are passed in. For simple DATA definitions(e.g. DATA "thegeog from thetable"), that's all you have to do. I haven't tested out more complex DATA statements yet, but I am pretty sure they should work fine. 

