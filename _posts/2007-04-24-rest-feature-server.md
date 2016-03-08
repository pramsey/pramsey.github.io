---
layout: post
title: REST Feature Server
date: '2007-04-24T16:32:00.000-07:00'
author: Paul Ramsey
tags: 
modified_time: '2007-04-24T16:41:05.773-07:00'
blogger_id: tag:blogger.com,1999:blog-14903426.post-6857888783162366980
blogger_orig_url: http://blog.cleverelephant.ca/2007/04/rest-feature-server.html
comments: True
---

Piling on this meme! Pile!

Chris Holmes has [taken a stab](http://cholmes.wordpress.com/2007/04/24/rest-feature-service-sketches/) at some of the semantics of a REST feature server, and of course, Chris Schmidt has already [written one](http://featureserver.org). (!!!!!)

I would like to take issue with one of Chris Holmes' design points:

> The results of a query can then just return those urls, which the client may already be caching
> 
> http://sigma.openplans.org/geoserver/major_roads?bbox=0,0,10,10
> 
> returns something like
> 
> &lt;html&gt;<br/>&lt;a href=’http://sigma.openplans.org/geoserver/major_roads/5′&gt;5&lt;/a&gt;<br/>&lt;a href=’http://sigma.openplans.org/geoserver/major_roads/1′&gt;1&lt;/a&gt;<br/>&lt;a href=’http://sigma.openplans.org/geoserver/major_roads/3′&gt;3&lt;/a&gt;<br/>&lt;a href=’http://sigma.openplans.org/geoserver/major_roads/8′&gt;8&lt;/a&gt;<br/>&lt;/html&gt;

Ouch!  Resolving a query that return 100 features would require traversing 100 URLs to pull in the resources. What about if we include the features themselves in the response? Then we are potentially sending the client objects it already has. What is the solution? 

It is already here! Tiling redux! Break the spatial plane up into squares, and assign features to every square they touch. You get nice big chunks of data, that are relatively stable, so they can be cached. Each feature can also be referenced singly by URL, just as Chris suggests, but the tiled access allows you to pull more than one at a time.

What about duplication? Some features will fall in more than one tile. What about it? Given the choice between pulling 1000 features individually, and removing a few edge duplicates as new tiles come in, I know what option I would choose. Because each feature in the tile includes the URL of the feature resource, it is easy to identify dupes and drop them as the tiles are loaded into the local cache.

Tiling on the brain, tiling on the brain...