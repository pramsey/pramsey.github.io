---
layout: post
title: 'NYC Sprint: Day 1'
date: '2010-02-20T11:24:00.000-08:00'
author: Paul Ramsey
tags:
- osgeo
- sprint
modified_time: '2010-03-01T09:16:36.724-08:00'
blogger_id: tag:blogger.com,1999:blog-14903426.post-6399884612652825192
blogger_orig_url: http://blog.cleverelephant.ca/2010/02/nyc-sprint-day-1.html
comments: True
---

On a bright day in NYC, we all convened in the sunny Open Plans event room for the first day. As in last years sprint, the morning was spent in planning and discussions, and the afternoon folks began digging in.

The MapServer team talked about release plans for 6.0, and came up with [an ambitious release plan](http://trac.osgeo.org/mapserver/wiki/60ReleasePlan). They recognize that not every item on the plan will make the final cut, but hope that most will find either funded or community effort to bring about. Among the highlights (to me):

**Pluggable renderer** would allow a much cleaner rendering chain, and new renderers for new formats to be more easily added. **filterObj** to enhance the power of MapServer querying and support OGC Filter fully (and incidentally leverage the power of databases like PostGIS more fully). **Named styles** to allow re-use of style objects through a map file, instead of repeating the definitions over and over.

I also talked with Steve Lime and Jim Klassen about [a bug](http://trac.osgeo.org/mapserver/ticket/3305) in the one-pass rendering code that is making complex WFS queries fail. We think we have a solution and Assefa is doing the final tests.

The PostGIS discussions were about our [2.0 roadmap](http://trac.osgeo.org/postgis/wiki/DevelopmentDiscussion) and what the implications of various changes are. Unfortunately, most of my proposed/desired changes are predicated are a large change to the underlying data serialization, so going forward requires a good deal of bravery &ndash; I have to burn down the village in order to save it. Olivier Courtin is working on more tractable new features: a polyhedral surface, suitable for storing 3D buildings and other objects that have grown increasingly common.

David Zwarg and Jeff Adams from Avencia joined the PostGIS group, and are working hard already: David on WKTRaster and Jeff on a geographic coordinates formatting routine. Don't tell Jeff, but if he gets the output formatter working, I'm just going to ask him to try and write an ingester.

Justin Deoliveira and Tim Schaub began working on improving the scripting extensions to Geoserver, Tim working on the server-side JavaScript and Justin working on the Python (and David Winslow working on Scala!). Andreas Hocevar has begun a Google Maps V3 API layer for OpenLayers, which will allow Google layers without API keys in OpenLayers (yay!).

As usual, the team had to be driven into the night bodily at the end of the day &ndash; it is hard to pry nerds from their code.

Thanks to our 2010 sprint sponsors, for keeping us well supplied with food, drinks and coffee throughout this busy week!

**Postscript:** At the end of the day, Olivier and I settled on an order-of-operations to move towards the new database serialization in PostGIS. Step one, remove the current places in the code where the serialization pokes up into function code and get it completely isolated underneath a serialize/deserialize layer.

