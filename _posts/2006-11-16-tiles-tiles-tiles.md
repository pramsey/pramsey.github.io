---
layout: post
title: Tiles Tiles Tiles
date: '2006-11-16T20:44:00.000-08:00'
author: Paul Ramsey
tags: 
modified_time: '2006-11-16T21:02:37.715-08:00'
blogger_id: tag:blogger.com,1999:blog-14903426.post-6915537306800920595
blogger_orig_url: http://blog.cleverelephant.ca/2006/11/tiles-tiles-tiles.html
---

One of the oddball tasks I came home from the [FOSS4G](http://www.foss4g2006.org) conference with was the job of writing the first draft of a tiling specification.  My particular remit was to do a server capable of handling arbitrary projections and scale sets, which made for an interesting design decision: to extend [WMS](http://www.opengeospatial.org/standards/wms) or not?

I mulled it over at the conference, and talked to some of the luminaries like Paul Spencer and [Allan Doyle](http://think.random-stuff.org/).  My concern was that the amound of alteration required to WMS in order to support the arbitrary projections and scales was such that there was not much benefit remaining in using the WMS standard in the first place -- existing servers wouldn't be able to implement, and existing clients wouldn't be able to benefit.

On top of that, a number of the client writers wanted something a little more "tiley" in their specification than WMS.  Rather than requests in coordinate space, they wanted requests in tile space: "give me tile [4,5]!"

So, I originally set off to write either a GetTile in WMS or a Tile Server using the [Open Web Services](http://www.opengeospatial.org/standards) baseline from the [Open Geospatial Consortium](http://www.opengeospatial.org).  

But then I had an Intellectual Experience, which came from reading [Sean Gillies'](http://zcologia.com/news/) blog on [REST](http://en.wikipedia.org/wiki/Representational_State_Transfer) web services, and [his thoughts](http://zcologia.com/news/283) on how Web Feature Server (WFS) could have been implemented more attractively as a REST interface.  I was drawn in by the Abstract Beauty of the whole concept.

So I threw away the half-page of OWS boiler-plate I had started with and began anew, thinking about the tiling problem as a problem of exposing "resources" ala REST.

The result is the [Tile Map Service](http://wiki.osgeo.org/index.php/Tile_Map_Service_Specification) specification, and no, it is not really all that RESTful.  That's because tiles themselves are really boring resources, and completely cataloguing a discovery path from root resource to individual tile would add a lot of scruft to the specification that client writers would never use.  So I didn't.

That was the general guiding principle I tried to apply during the process -- what information can client writers use.  Rather than writing for an abstract entity, I tried to think of the poor schmuck who would have to write a client for the thing and aim the content at him.

I have put up a reference server at [http://mapserver.refractions.net/cgi-bin/tms](http://mapserver.refractions.net/cgi-bin/tms) and there are other servers referenced in the document.  My colleague [Jody Garnett](http://weblogs.java.net/blog/jive/) is working on a client implementation in Java for the [GeoTools](http://www.geotools.org) library, for exposure in the [uDig](http://udig.refractions.net) interface.  Folks from [OpenLayers](http://www.openlayers.org) and [WorldKit](http://worldkit.org) have already built reference clients. It has been great fun!