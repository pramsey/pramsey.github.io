---
layout: post
title: (Who will be) Americas Next Big Mapping Company?
date: '2019-06-10T06:00:00.00-07:00'
author: Paul Ramsey
category: technology
tags:
- google
- google maps
- mapping
comments: True
image: "2019/curtain.jpg"
---

When talking to government audiences, I like to point out that the largest national mapping agency in the world resides in a building decorated like a hypertrophic kindergarten, in Mountain View, California. This generally gets their attention.

The second most important year in my career in geospatial was 2005<sup><a href='#1'>1</a></sup>, the year that Google Maps debuted, and began the migration of "maps on computers" from a niche market dominated by government customers to the central pivot of multiple consumer-facing applications. 

The echoes of 2005 lasted for several years.

* Microsoft quickly realized it was dramatically behind in the space, "MapPoint" being its spatial product, and went on an [axquisition](https://www.vexcel-imaging.com/company/) [and](https://www.gim-international.com/content/news/microsoft-corporation-acquires-geotango) [R&D](https://en.wikipedia.org/wiki/Photosynth) spree. 
* Esri started moving much more quickly into web technology, aping  Google product direction (spinny globes?! yes! JSON on the wire!? yes! tiled basemaps?!? oh yes!) in what must have been an embarassing turn for the "industry leader" in GIS. 
* Navteq and Teleatlas transitioned quickly from industry darlings (selling data to Google!) to providers of last resort, as more nimble data gatherers took up the previously-unimagineable challenge of mapping the whole world from scratch.
* Open source did its usual fast follower thing, churning out a large number of Javascript-and-map-tiles web components, and pivoting existing rendering engines into tile generators.

A funny thing happened in the shake out, though. Nobody ever caught up to Google. Or even came very close. While Google has abandoned [Maps Engine](https://mapsengine.google.com/about/index.html), their foray into "real GIS", their commitment to core location data, knowing where everything is and what everything is, all the time and in real time, remains solid and far in advance of all competitors.

Probably even before they rolled out the iPhone in 2007 Apple knew they had a "maps problem". Once they added a GPS chip (a development that was only awaiting a little more battery oomph) they would be beholden to Google for all the directions and maps that made the chip actually *useful* to phone users.

And so we eventually got the [Apple maps debacle](https://www.businessinsider.com/the-apple-maps-debacle-2012-9) in 2012. It turns out, building a global basemap that is accurate and includes all the relevant details that users have come to expect is really really really hard.

In an [excellent article](https://www.justinobeirne.com/google-maps-moat) on the differences between Google and Apple's maps, JustinO'Beirne posited:

> Google has gathered so much data, in so many areas, that it’s now crunching it together and creating features that Apple can’t make—surrounding Google Maps with a moat of time.

Even the most well-funded and motivated competitors cannot keep up. Microsoft came the closest early on with Bing Maps, but seems to have taken their foot of the gas, in acknowledgement of the fact that they cannot achieve parity, let alone get ahead.

And so what? So what if Google has established Google Maps as a source of location data so good and so unassailable that it's not worth competing?

Well, it sets up an interesting future dynamic, because the competitive advantage those maps provide is too large to leave unchallenged.

**Apple** cannot afford to have their location based devices beholden to Google--now a direct competitor with [Android](https://www.lifewire.com/iphone-vs-android-best-smartphone-2000309)--so they have continued to invest heavily in maps. They've been a lot quieter about it after the debacle, but they haven't given up.

**Amazon AWS** is the unchallenged leader in cloud computing, but Google wants a bigger piece of the cloud computing pie, and they are using Google Maps as a wedge to pull customers into the Google Cloud ecosystem. I have heard of multiple customers who have been wooed via combined Maps + Cloud deals that offer discounted Cloud pricing on top of Maps contracts. Why not put it all in one data centre?

**Salesforce** [has just purchased Tableau](https://techcrunch.com/2019/06/10/salesforce-is-buying-data-visualization-company-tableau-for-15-7b-in-all-stock-deal/), pulling one of the largest BI companies into the largest enterprise cloud company. Analytics has a lower need for precise location data, but Salesforce customers will include folks who do logistics and other spatial problems requiring accurate real-time data.

Someone is going to take another run at Google, they have to. **My prediction is that it will be AWS**, either through acquisition (Esri? Mapbox?) or just building from scratch. There is no doubt Amazon already has some spatial smarts, since they have to solve huge logistical problems in moving goods around for the retail side, problems that require spatial quality data to solve. And there is no doubt that they do not want to let Google continue to leverage Maps against them in Cloud sales. They need a "good enough" response to help keep AWS customers on the reservation.

How will we know it's happening? It might be hard to tell from outside the Silicon Valley bubble. Most of the prominent contributors to the *New Mapping Hegemony* live behind the NDA walls of organizations like Google and Apple, but they are the kinds of folks Amazon will look to poach, in addition to members of Microsoft's Bing team (more conveniently already HQ'ed in Seattle).

I think we're due for another mapping space race, and I'm looking forward to watching it take shape.


