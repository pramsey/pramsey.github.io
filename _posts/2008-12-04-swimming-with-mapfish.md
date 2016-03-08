---
layout: post
title: Swimming with the MapFish
date: '2008-12-04T10:55:00.001-08:00'
author: Paul Ramsey
tags: 
modified_time: '2008-12-04T11:29:06.026-08:00'
thumbnail: http://farm4.static.flickr.com/3110/3082997992_78d31e4647_t.jpg
blogger_id: tag:blogger.com,1999:blog-14903426.post-699016414617144831
blogger_orig_url: http://blog.cleverelephant.ca/2008/12/swimming-with-mapfish.html
comments: True
---

So, I was at a client site this week, doing a few days of reviewing their application and providing advice on [PostGIS](http://postgis.refractions.net/) design, [Mapserver](http://mapserver.gis.umn.edu) performance, all my favorite things.  And we come to the last day, and they say "you've been talking about how our application would look so good if we used OpenLayers and [ExtJS](http://www.extjs.com) and how great those tools are so... how about you mock up a little data entry application using our data for us this morning, before your flight?"

Glurp!!

I'm not much of a web programmer, but fortunately [OpenLayers](http://www.openlayers.org) and [MapFish](http://www.mapfish.org) have adopted a policy of "documentation by example".  OpenLayers is by far the leader in this, eschewing tutorials in favor of a long list of [tiny example pages](http://openlayers.org/dev/examples/), each one demonstrating a discrete unit of functionality.

Since "mediocre authors borrow, great authors steal", I set about finding something I could steal that would get me closer to my goal.  Fortunately, I quickly found want I wanted in the client code base of [MapFish](http://www.mapfish.org) &ndash; Mapfish is an ExtJs/OpenLayers framework, so it had the components I was yapping about, and it included a simple editing example.

[<img src="http://farm4.static.flickr.com/3110/3082997992_78d31e4647.jpg" width="500" height="358" alt="MapFish Default Editing Example" />](http://www.flickr.com/photos/92995391@N00/3082997992/" title="MapFish Default Editing Example by pwramsey3, on Flickr)

Starting from there, hooking up the client's map services, using the OpenLayers examples to grab some extra layer types, and adding a few buttons, I had the desired proof of concept in plenty of time to make my afternoon flight.  Thanks MapFish and OpenLayers, for making me look so damned good!

