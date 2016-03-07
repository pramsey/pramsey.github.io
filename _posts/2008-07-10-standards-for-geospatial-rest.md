---
layout: post
title: Standards for Geospatial REST?
date: '2008-07-10T21:40:00.000-07:00'
author: Paul Ramsey
tags: 
modified_time: '2008-07-10T22:28:14.171-07:00'
blogger_id: tag:blogger.com,1999:blog-14903426.post-8045921262872356104
blogger_orig_url: http://blog.cleverelephant.ca/2008/07/standards-for-geospatial-rest.html
---

One of the things that has been powerful about the open source geospatial community has been the care with which open standards have been implemented.  <img src="http://www.jlab.org/news/releases/2004/atom_nucleon.jpg" width="286" height="284" style="float:right;padding:10px"/>Frequently the best early implementations of the OGC standards have open source ones.  It [would be nice](http://zcologia.com/news/778/rest-on-the-conference-circuit-2008/) if the open source community could start providing REST APIs to the great core rendering and data access services that underly products like Mapserver, Geoserver, and so on.

However, it's bad enough that Google, Microsoft, ESRI, all invent their own addressing schemes for data and services. Do we want the open source community to create another forest of different schemes, one for each project?  Also, inventing a scheme takes time and lots of email wanking in any community with more than a handful of members.  Replicating that effort for each community will waste a lot of time.

No matter how much we (me) might bitch about [OGC](http://www.opengeospatial.org) standards, they have a huge advantage over DIY, in that they provide a source of truth. You want an answer to how that works?  Check the standard.

There's been enough test bedding of REST and some nice [working implementations](http://www.featureserver.org/), perhaps it is time to document some of that knowledge and get into the playing field of the OGC to create a source of truth to guide the large community of implementors.

A lot of the work is done, in that most of the the potential representations have been documented: [GML](http://www.opengeospatial.org/standards/gml), [KML](http://www.opengeospatial.org/standards/kml), [GeoRSS](http://georss.org/), [GeoJSON](http://geojson.org/), [WKT](http://www.opengeospatial.org/standards/sfs).  Perhaps there is little more to be done: writing up how to apply [APP](http://bitworking.org/projects/atom/draft-ietf-atompub-protocol-06.html) to feature management.

