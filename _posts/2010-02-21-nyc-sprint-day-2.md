---
layout: post
title: 'NYC Sprint: Day 2'
date: '2010-02-21T11:42:00.000-08:00'
author: Paul Ramsey
tags:
- osgeo
- sprint
modified_time: '2010-03-01T09:16:28.384-08:00'
thumbnail: http://farm3.static.flickr.com/2794/4376132629_d5ea4065b3_t.jpg
blogger_id: tag:blogger.com,1999:blog-14903426.post-9033916703249082140
blogger_orig_url: http://blog.cleverelephant.ca/2010/02/nyc-sprint-day-2.html
comments: True
---

Today the Geoserver, MapServer and OpenLayers teams got together and really showed off the "[making things work together better](http://wiki.osgeo.org/wiki/New_York_Code_Sprint_2010_Agenda)" theme. Starting from Andrea Aime's new "WMS rotation" feature, Daniel Morissette implemented the same feature with the same semantics in MapServer, while Andreas Hocevar implemented client support for the feature into OpenLayers. During testing, a small bug showed up in the Geoserver implementation, which Andrea fixed. 

The final result is shown in this screenshot: layers from Geoserver and MapServer viewed and rotated together within OpenLayers.

[<img src="http://farm3.static.flickr.com/2794/4376132629_d5ea4065b3.jpg" width="500" height="233" alt="screenshot008tm" />](http://www.flickr.com/photos/92995391@N00/4376132629/" title="screenshot008tm by pwramsey3, on Flickr)

The MapServer team is now really digging into a couple major goals: [reading projection information automatically](http://mapserver.org/development/rfc/ms-rfc-37.html) from data sources; and, making the [rendering subsystem pluggable](http://trac.osgeo.org/mapserver/wiki/RenderingPluginStatus). Here they are deep in discussion on the rendering design:

[<img src="http://farm5.static.flickr.com/4044/4376445771_036bc5344a.jpg" width="500" height="375" alt="MapServer Conclave"  style="border: solid 1px #777;" />](http://www.flickr.com/photos/92995391@N00/4376445771/" title="photo by pwramsey3, on Flickr)

Automatic projection reading will make it easier for new users to work with data in mixed projections, because they will no longer have to manually populate PROJECTION blocks for their layers. They will be able to just set PROJECTION to AUTO.

The pluggable rendering upgrade is mostly of interest to programmers, but because it will clean up the plumbing in drawing maps, it will allow new features like KML, PDF and SVG output to be added much more easily. In fact, Assefa is currently working on [KML output](http://mapserver.org/development/rfc/ms-rfc-58.html), using the new rendering design.

Keeping to himself quietly, Alan Boudreault is tying the XML Mapfile more tightly into MapServer. In the last revision, XML Mapfiles could be transformed to .map format with a utility. In the next revision, it will be possible to use them directly from the MapServer CGI program.

Over on the Geoserver side, Andrea Aime arrived from Italy last night, and today is adding the WMS GetStyles operation to Geoserver. Andreas Hocevar is working on tying together printing support in Geoserver and GeoExt. The scripting engine crew continues to beaver away on Javascript/Python/Scala scripting in Geoserver.

In PostGIS land, Olivier Courtin has blasted a pile of changes into PostGIS trunk, working on moving GML/KML/SVG support down into the core geometry library, where they will be easier to reuse. On a similar tack, I've been working on writing a new WKT emitter, that is easier to maintain and supports ISO WKT for extended types and dimensions.

Thanks again to our sponsors! In an hour we will be settling in to watch the Canada/USA hockey game on the big screen in the Open Plans penthouse. Go Canada!

<div style="vertical-align:center; text-align:center;" >[<img src="http://farm5.static.flickr.com/4023/4398161023_8b37ecdd58_o.png" alt="Azavea" border="0" />](http://www.azavea.com/)  [<img src="http://farm5.static.flickr.com/4037/4363909195_a73ab7d789_o.jpg" alt="LizardTech" border="0"  />](http://www.lizardtech.com/) [<img src="http://farm5.static.flickr.com/4003/4364650774_9561cfe97a_o.jpg" alt="Coordinate Solutions" border="0" />](http://www.coordinatesolutions.com/) <br/>[<img src="http://farm5.static.flickr.com/4072/4364650828_9b0562e902_o.jpg" alt="OpenGeo" border="0"  />](http://opengeo.org/) [<img src="http://farm5.static.flickr.com/4012/4363909295_d1e4391317_o.jpg" alt="qPublic.net" border="0" />](http://www.qpublic.net/) [<img src="http://farm3.static.flickr.com/2690/4364650934_2305ed4739_o.jpg" alt="Farallon" border="0" />](http://www.fargeo.com/) </div>

**Update:** Canada disappoints! I blame Brodeur.

