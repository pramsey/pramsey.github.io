---
layout: post
title: ESRI "Free" Web Services
date: '2009-06-02T11:47:00.000-07:00'
author: Paul Ramsey
tags: 
modified_time: '2009-06-08T16:33:34.776-07:00'
thumbnail: http://farm3.static.flickr.com/2167/2509085987_bc9272e8a9_t.jpg
blogger_id: tag:blogger.com,1999:blog-14903426.post-8339726704075631043
blogger_orig_url: http://blog.cleverelephant.ca/2009/06/esri-free-web-services.html
comments: True
---

I'm a nice guy, I often raise ESRI's web services (formerly [ArcWeb Services](http://www1.arcwebservices.com/), now [ArcGIS Online](http://resources.esri.com/arcgisonlineservices/)) when talking to clients about options for things like map services, geocodes and routes. It's my way of rooting for the scrappy underdog, the old paleogeographic home team, going up against the Google and <strike>Microsoft</strike> Bing behemoths.

<img src="http://farm3.static.flickr.com/2167/2509085987_bc9272e8a9.jpg"/>

But someone, please, tap the Redlands team with the clue stick... check out the fabulous new "free" services ESRI is offering to lure developers to their ecosystem!

[Free geocoding](http://www.esri.com/software/arcgis/arcgisonline/world_geocoding.html)! Yes! Free! And as many as **1000 geocodes per year**. You read that right, kids, per **year**. [Also routing](http://www.esri.com/software/arcgis/arcgisonline/world_routing.html)! 5000 per year!

Compare with Yahoo!'s (aside, something about putting an apostrophe after an exclamation mark feels wrong) free API, which offers 5000 geocodes [per day](http://developer.yahoo.com/maps/rest/V1/geocode.html) (Google offers [15000](http://code.google.com/apis/maps/faq.html#geocoder_limit)).

There's a punch-line in here somewhere, but I'm not sure where.

**Update:** Ray from ESRI notes in the comments that "... the limit of 1,000 geocodes is for geocodes done in BATCH MODE (ie: a request involving more than one address at a time). Place-finding, single address geocoding and single address reverse geocoding are not limited."  I may have had it completely backwards, ESRI is not being too stingy, they are being too generous. I'm pretty sure there's lots of people who can script their computers into running lots of sequential individual geocoding requests ... in a "batch", as it were.

**Update 2:** Ray from ESRI further clarifies the meaning of "batch": "Batch geocoding really means that you are storing the results of your request locally, so you can use them again." So the "batchness" of your request is not governed by the size of the request, but by what you do with the request. (Wait, I've heard that somewhere before...) Comparing to the Yahoo! [terms of use](Batch geocoding really means that you are storing the results of your request locally, so you can use them again.) we find a similar restriction, which means the ESRI offering is the-same-only-better (fewer restrictions on non-"batch" requests). Better put away the clue-stick, nothing to see here, move along, move along.

