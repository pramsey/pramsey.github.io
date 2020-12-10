---
layout: post
title: 'Mapbox and Morrison'
date: '2020-12-09T00:00:00-08:00'
author: Paul Ramsey
category: technology
tags:
- mapbox
- open source
- opengl
comments: True
image: ""
---

Yesterday, Mapbox announced that they were moving their [Mapbox GL JS](https://github.com/mapbox/mapbox-gl-js) library from a standard BSD license to a new very much [non-open source license](https://github.com/mapbox/mapbox-gl-js/blob/main/LICENSE.txt).

[Joe Morrison said](https://joemorrison.medium.com/death-of-an-open-source-business-model-62bc227a7e9b) the news "shook" him (and also the readers of the Hacker News front page, well done Joe). It did me as well. Although apparently for completely different reasons.

> Mapbox is the protagonist of a story I’ve told myself and others countless times. It’s a seductive tale about the incredible, counterintuitive concept of the “open core” business model for software companies.
> -- Joe Morrison

There's a couple things wrong with Joe's encomium to Mapbox and "open core": 

* first, Mapbox was **never** an open core business; 
* second, open core is a **pretty ugly model** that has very little to do with the open source ethos of shared intellectual pursuit.

![Open Core]({{ site.images }}/2020/core.jpg)

## Mapbox was never Open Core

From the very start (well, at least from the early middle), Mapbox was built to be a location-based services business. It was to be the Google Maps for people who were unwilling to accept the downsides of Google Maps. 

Google Maps will track you. They will take your data exhaust and ruthlessly monetize it. They will take your data and use it to build a better Google Maps that they will then re-sell to others.

If you value your data at all (if you are, say, a major auto maker), you probably don't want to use Google Maps, because they are going to steal your data while providing you services. Also, Google Maps is increasingly the "only game in town" for location based services, and it seems reasonable to expect price increases ([it has already happened once](https://housesigma.com/blog-en/2018/06/07/google-map-price-hike/)).

![Google is Tracking You]({{ site.images }}/2020/google-location-history.png)

Nobody can compete with Google Maps, can they? Why yes, they can! Mapbox fuses the collaborative goodness of the [OpenStreetMap](https://openstreemap.org) community with clever software that enables the kinds of services that Google sells 
([map tiles](https://docs.mapbox.com/api/maps/#raster-tiles), 
[geocoding](https://docs.mapbox.com/#search), 
[routing](https://docs.mapbox.com/#navigation), 
[elevation services](https://docs.mapbox.com/help/troubleshooting/access-elevation-data/)), and a bunch of services Google doesn't sell (like [custom map authoring](https://www.mapbox.com/mapbox-studio/)) or won't sell (like [automotive vision](https://www.mapbox.com/vision/)). 

But like Google, the value proposition Mapbox sells isn't in the software, so much as the data and the platform underneath. Mapbox has built a unique, scalable platform for handling the huge problem of turning raw OSM data into usable services, and raw location streams into usable services. The sell access to that platform.

Mapbox has never been a software company, they've always been a data and services company.

The last company I worked for, [CARTO](https://carto.com), had a similar model, only moreso. All the parts of their value proposition (PostgreSQL, PostGIS, the CARTO UI, the tile server, the upload, everything) are [open source](https://github.com/cartodb). But they want you to pay them when you load your data into their service and use their software there. How can that be? Well, do you want to assemble all those open source parts into a working system and keep it running? Of course not. You just want to publish a map, or run an analysis, or add a spatial analysis to an existing system. So you pay them money.  
{: .note }

Is Mapbox an "open core" company? No, is there a "Mapbox Community Edition" everyone can have, but an "Enterprise Edition" that is only available under a proprietary license? No. Does Mapbox even sell **any software at all**? No. (Yes, some.) They (mostly) sell services. 

So what's with the re-licensing? I'll come back to that, but first...

## Open Core is a Shitty Model

Actually, no, it seems to be a passable **monetization** model, for some businesses. It's a shitty open source model though.

* MongoDB has an open source core, and sells a bunch of proprietary enterprise add-ons. They've grown very fast and might even reach escape velocity to escape their huge VC valuation (or they still might be sucked into the singularity). 
* Cloudera before them reached huge valuations selling proprietry add-ons around the open Hadoop ecosystem. 
* MySQL flirted with an open core model for many years, but mostly stuck to spreading FUD about the GPL in order to get customers to pay them for proprietary licenses.

Easily the strangest part of the MySQL model was trash-talking the very open source license **they chose** to place their open source software under.
{: .note }

All those companies have been quite succesful along the axes of "getting users" and "making money". Let me tell you why open core is nonetheless a shitty model:

* Tell me about the MongoDB developer community. Where do they work? Oh right, Mongo.
* Tell me about the Cloudary developer community? Where do they work?
* Tell me about the MySQL developer community? Where to they work? Oh right, **Oracle**. (There's a whole other blog post to be written about why sole corporate control of open source projects is a **bad idea**.)

A good open source model is one that promotes heterogeneity of contributors, a sharing of control, and a rising of all boats when the software succeeds. Open core is all about centralizing gain and control to the sponsoring organization. 

This is going to sound precious, but the leaders of open core companies don't "care" about the ethos of open source. The CEOs of open core companies view open source (correctly, from their point of view) as a "sales channel". It's a way for customers to discover their paid offerings, it's not an end in itself.

![Sales Funnel]({{ site.images }}/2020/funnel.png)

> We didn't open source it to get help from the community, to make the product better. We open sourced as a freemium strategy; to drive adoption. 
> -- Dev Ittycheria, CEO, MongoDB

So, yeah, open core is a way to make money but it doesn't "do" anything for open source as a shared proposition for building useful tools anyone can use, for anything they find useful, anytime and anywhere they like.

Check out [Adam Jacob's take](https://www.youtube.com/watch?v=8q5o-4pnxDQ) on the current contradictions in the world of open source ethics; there are no hard and fast answers.
{: .note }

## Mapbox Shook Me Too

I too was a little shook to learn of the [Mapbox GL JS relicensing](https://news.ycombinator.com/item?id=25347310), but perhaps not "surprised". This had happened before, with [Tilemill](https://news.ycombinator.com/item?id=14734589) (open) morphing into [Mapbox Studio](https://www.mapbox.com/mapbox-studio/) (closed).

The change says nothing about "open source" in the large as a model, and everything about "single vendor projects" and whether you should, strategically, believe their licensing. 

![Empty Promises]({{ site.images }}/2020/empty-promise.jpg)

I (and others) took the licensing (incorrectly) of Mapbox GL JS to be a promise, not only for now but the future, and made decisions based on that (incorrect) interpretation. I integrated GL JS into [an open source project](https://github.com/CrunchyData/pg_tileserv/blob/master/assets/preview-table.html) and now I have to revisit that decision.

The license change also says something about the business realities Mapbox is facing going forward. The business of selling location based services is a competitive one, and one that is perhaps not panning out as well as their venture capital valuation ([billions?](https://blog.mapbox.com/softbank-mapbox-series-c-be207b866b27)) would promise. 

No doubt the board meetings are fraught. Managers are casting about for future sources of revenue, for places where more potential customers can be **squeeeeezed** into the sales funnel. 

I had high hopes for Mapbox as a counterweight to Google Maps, a behemoth that seems [likely to consume us all](https://www.justinobeirne.com/google-maps-moat). The signs that the financial vice is begining to close on it, that the promise might not be fulfilled, they shake me.

So, yeah, Joe, this is big news. Shaking news. But it has nothing to do with "open source as a business model".

