---
layout: post
title: Can WFS Really Work?
date: '2006-12-01T11:34:00.000-08:00'
author: Paul Ramsey
tags:
- opengis
- udig
- wfs
modified_time: '2006-12-01T11:53:51.561-08:00'
blogger_id: tag:blogger.com,1999:blog-14903426.post-1664416474186599322
blogger_orig_url: http://blog.cleverelephant.ca/2006/12/can-wfs-really-work.html
comments: True
---

Of all the standards that have come out of the [OGC](http://www.opengeospatial.org) in the last few years, few has had the promise of the [Web Feature Server](http://www.opengeospatial.org/standards/wfs) standard.

* View and edit features over the web
* Client independent
* Server independent
* Format independent
* Database independent

What is not to like? Nothing!

One of the promises of [uDig](http://udig.refractions.net) is to be an "internet GIS", by which we mean a thick client system capable of consuming and integrating web services in a transparent and low-friction way.  The GIS equivalent of a web browser.  Web browsers use HTTP and HTML and CSS and Javascript to create a rich and compelling client/server interaction, regardless of the client/server pairing.  An internet GIS should use WMS and WFS and SLD to do the same thing, independent of vendor.

So, we have been working long and hard on a true WFS client, one that can connect to **any** WFS and read/write the features therein without modification.  And here's the thing -- it is **waaaaaaay** harder than it should be.

Here is why:

* First off, generic GML support is hard.  Every WFS exposes its own schema which in turn embeds GML, so a "GML parser" is actually a "generic XML parser that happens to also notice embedded GML", and the client has to be able to turn whatever odd feature collection the server exposes into its internal model to actually render and process it.  However, it is only a hard problem, not an impossible one, and we have solved it.
* The solution to supporting generic GML is to read the schema advertised by the WFS, and use that to build a parser for the document on the fly.  And this is where things get even harder: lots of servers advertise schemas that differ from the instance documents they actually produce.

    * The difference between schema and instance probably traces back to point #1 above. Because GML and XML schema are "hard", the developers make minor mistakes, and because there have not been generic clients around to heavily test the servers, the mistakes get out into the wild as deployed services.

So, once you have cracked the GML parsing problem (congratulations!) you run headlong into the next problem. Many of the servers have bugs and don't obey the schema/instance contract -- they do not serve up the GML that they say they do.

And now, if you aren't just building a university research project, you have a difficult decision. If you want to interoperate with the existing servers, you have to code exceptions around all the previously-deployed bugs.  

Unfortunately, our much loved UMN Mapserver is both (a) one of the most widely deployed WFS programs and (b) the one with the most cases of schema/instance mismatch.  Mapserver is not the only law-breaker though, we have found breakages even in proprietary products that passed the CITE tests.

All this before you even start editing features!

The relative complexity of WFS (compared to, say, WMS) means that the scope of ways implementors can "get it wrong" is much much wider, which in turn radically widens the field of "special cases to handle" that any client must write.

In some ways, this situation invokes to good old days of web browsers, when HTML purists argued that when encountering illegal HTML (like an unclosed tag) browsers should stop and spit up an error, while the browser writers themselves just powered through and tried to do a "best rendering" based on whatever crap HTML they happened to be provided with.