---
layout: post
title: More Simple Web Services Catalogues
date: '2006-02-10T14:50:00.000-08:00'
author: Paul Ramsey
tags: 
modified_time: '2006-10-21T11:22:57.776-07:00'
blogger_id: tag:blogger.com,1999:blog-14903426.post-113961315735042629
blogger_orig_url: http://blog.cleverelephant.ca/2006/02/more-simple-web-services-catalogues.html
comments: True
---

A couple months ago I [wrote a piece](http://blog.cleverelephant.ca/2005/10/simple-web-services-catalogues.html) about how [uDig](http://udig.refractions.net) made use of a simple web services catalogue to complete the web services publish-find-bind chain of being in a nice clean transparent way.  I was very proud, because at the time it was the only example of a decent desktop interface with a proper web services hook.

The times, the are a-catching-up to me! About the same time we were cobbling together our first catalogue of OGC WMS and WFS services, Jeremy Bartley at the University of Kansas was doing a similar thing, except he was mining Google for ArcIMS services.  (It should come as some disappointment to boosters of the OGC that he found about 10 times as many ArcIMS servers as we found OGC WMS servers of all types (including ArcIMS).)

Bartley took the results of his mining, and like us, stuffed them into a database for searching in useful ways: by layer and keyword.  He exposed the result as [Mapdex](http://www.mapdex.org).  For a while, Mapdex was just an HTML web user interface, which made it an interesting novelty, but not exactly an integrated experience.  

Then Bartley added a (again, simple!) web services API to the Mapdex database.  Now the doors were wide open, and along came the final piece: an [ArcMap toolbar](http://www.mapdex.org/MapdexToolbar/) that allows direct searching of Mapdex and adding of services to the ArcMap application in real time.  So now uDig is not longer unique in providing this particular capability.

I hope this stuff is not being lost on the OGC: facts on the ground are being established, and things that work now will be adopted in favour of things that do not.  Complex standards have utility, but if you want them to be adopted you need to provide a real reference implementation that people can deploy easily, without necessarily understanding the standard itself.  I would suggest BSD- or MIT- licensed open source code for things like GML parsing, Catalogue client, WFS client, WMS client, OpenLS client, and so on.  

The existence of freely-usable reference client code would allow people to quickly enrich their particular client applications with OGC web services ability, making the protocols more relevant and allowing the server makers (who form the bulk of the standards writing pool) to sell more of their product.

Ding! Ding! Ding! Time to wake up, the future is here, and it is not using OGC standards!