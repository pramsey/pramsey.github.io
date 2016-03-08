---
layout: post
title: Mapserver/PostGIS Performance Tips
date: '2008-10-31T09:12:00.001-07:00'
author: Paul Ramsey
tags: 
modified_time: '2008-10-31T09:22:05.433-07:00'
blogger_id: tag:blogger.com,1999:blog-14903426.post-3816158930164765830
blogger_orig_url: http://blog.cleverelephant.ca/2008/10/mapserverpostgis-performance-tips.html
comments: True
---

I'm working on re-writing the PostGIS driver in Mapserver to clean it up a little and hopefully make it faster, and seeing the flow of control, there are a couple ways users of the existing driver can improve performance with small configuration changes. The simplest syntax for defining a PostGIS layer in Mapserver is just:

    DATA "the_geom from the_table"

Very simple, but: how does Mapserver know what primary key to use in queries? And what SRID to use when creating the bounding box selection for drawing maps? The answer is, it asks the database for that information. With two extra queries. Every time it processes the layer.

However, if you are explicit about your unique key and SRID in configuration, Mapserver can, and does, skip querying the back-end for that information.

    DATA "the_geom from the_table using unique gid using srid=4326"

Also, if you have more than one PostGIS layer in your map file, you should turn on the Mapserver connection pool, even if you're not running in FastCGI mode. That's because the pool will allow all the layers to reuse the same connection. If you have have seven PostGIS layers, at 15ms per connection, that's 90ms saved (you still pay 15ms for the first connection). 

Add this line at the end of each PostGIS layer to tell Mapserver to leave the connection open for future layers:

    PROCESSING "CLOSE_CONNECTION=DEFER"

Go fast, fast, fast!

