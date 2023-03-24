---
layout: post
title: Let's Call the Whole Thing Off...
date: '2007-12-21T10:50:00.000-08:00'
author: Paul Ramsey
tags: 
modified_time: '2007-12-21T13:27:09.471-08:00'
blogger_id: tag:blogger.com,1999:blog-14903426.post-8136698679547151006
blogger_orig_url: http://blog.cleverelephant.ca/2007/12/lets-call-whole-thing-off.html
comments: True
---

You say "potato", I say "potato"; you say "long/lat", I say "lat/long". Long/lat, lat/long, lat/long, long/lat, let's call the whole thing off!

[This thread](https://web.archive.org/web/20080303134017/http://forums.microsoft.com/MSDN/ShowPost.aspx?PostID=2431933&SiteID=1) at the MSDN forums is an interesting read, if you are a complete loser. (Disclosure: I **am** a complete loser.)

<img src="http://farm3.static.flickr.com/2259/2126731271_80b7eaf00d.jpg?v=0" align="right" alt="Y/X World" />

In a nutshell, Microsoft thinks the world looks like this.  OK, OK, I'm being unfair, what they think is that it makes sense to use a latitude/longitude (y/x) order for ordinates in the Well-Known Text (WKT) and Well-Known Binary (WKB) that their STAsText() and STAsBinary() methods return, respectively. (Pls. see above re: my complete loserness.)

This is what the SQL Server spatial team had to say to a user wondering at this behavior:

> This is the expected behavior, but as you found there is not a standard industry consensus on the ordering of latitude / longitude coordinates in formats such as WKT and WKB.  The OGC SFS document does not cover geographic coordinates, only planar data, so it is not clear that the same ordering is necessary.  However, the EPSG definition itself for 4326 defines the axis order as latitude / longitude, and that is what we use and what is defined by other formats such as GML / GeoRSS.
> 
> [Here is a thread](http://mail.opengeospatial.org/pipermail/wfs-dev/2005-May/000236.html) from the OpenGeoSpatial mailing list defining this behavior.

The place where I (surprise!) violently disagree with the Microsoft team is the assertion that  "there is not a standard industry consensus on the ordering of ... coordinates in ... WKT and WKB ". There is, in fact, a massive industry consensus on WKT and WKB coordinate order. If the Microsoft team can find a shipping product that deliberately creates WKT or WKB in lat/long order I'll send them a [5lb box of Roger's Chocolates](http://www.rogerschocolates.com/products.php?category_id=12&page=1&search=&product_id=5470411621727d756f86f5b7957c378bd).

The comment goes on to muddy the waters by talking about GML, and GeoRSS and the OGC discussions on the topic of axis order, but is totally wrong about the core issue: what is the industry standard order for WKT and WKB.  In this case, Microsoft is late to the game, they don't get to set the *de facto* standard, because there is already a *de facto* standard, and it is long/lat.  

If Microsoft wants to interoperate easily with the standards-based products already in the marketplace, they will implement the *de facto* standard for their  STAsBinary() and STAsText() functions.  If they are paying lip service to actual interoperability ("we implemented the standard but for some reason **absolutely everybody else is doing it different**! who knew?") they'll do something else.

The *de jure* standard is, as the comment correctly notes, well nigh impossible to divine, because the OGC guidance on the subject has been scattered through so many areas, and because there is no **explicit** guidance on the topic for WKB and WKT.  But the *de facto* standard, the  "standard industry consensus" is clear: long/lat.

**Update:** To clarify the chocolate challenge, products that produce backwards WKB and WKT to satisfy SQL Server (FME, Manifold) don't count. This is about the industry standard that pre-existed SQL Server.
