---
layout: post
title: 'Timmy''s Telethon #4'
date: '2008-02-14T09:58:00.000-08:00'
author: Paul Ramsey
tags: 
modified_time: '2008-02-14T10:24:51.755-08:00'
blogger_id: tag:blogger.com,1999:blog-14903426.post-2078627450962358554
blogger_orig_url: http://blog.cleverelephant.ca/2008/02/timmys-telethon-4.html
comments: True
---

Out of left field:

> 4. Compatibility: This problem reaches across the board but when it comes to open source vs. closed source; from what you’ve seen is it a wash? I must admit that I’m inclined to stick with the devil that I and everyone else knows. Additionally doesn’t the nature of open source introduce opportunities for proprietary stovepipes?

This one I frankly do not understand, but perhaps it is in the nature of the word "compatibility". 

In general, open source software is wildly more interoperable and therefore "compatible" with different proprietary stovepipes than the proprietary alternatives.  <img src="http://www.gascoals.net/Portals/1/Direct%20Vent/dv%20group.gif" style="float:right;border-width:0;padding:6px" alt="Stovepipes?" /> Mapserver, for example, can pull data out of dozens of file formats, as well as SDE, Oracle, geodatabase, and the usual open source suspects like PostGIS.  Because open source development priorities are "scratch the itch" and people in real offices need to do real work, one of the first features requested and funded is almost always "connect to my proprietary database X".

(This is not just about Mapserver either: Geoserver, uDig, gvSIG, QGIS, even good old GRASS all have better multi-format connectivity than leading proprietary brands. Note the word "leading"... the non-leading proprietary brands tend to have good connectivity too, but the market leader uses lack of interoperability as a means to protect their lead.)

If "compatibility" is really a synonym for "does it work with ArcMap", then indeed there is a problem, but it is not on the open source side. ESRI ties ArcMap tightly to their own stovepipe for very good (to them) reasons of competitiveness and market protection. ArcMap sells ArcSDE licenses, not vice versa.  (How many times have you heard someone say "this SDE stuff is great! if only I had a mapping tool to work with the data...")

I'm open to suggestions as to what part of open source "nature" actually lends itself to proprietary stovepipes.  That part I don't get at all.