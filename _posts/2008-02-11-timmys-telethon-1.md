---
layout: post
title: 'Timmy''s Telethon #1'
date: '2008-02-11T09:38:00.000-08:00'
author: Paul Ramsey
tags: 
modified_time: '2008-02-11T10:01:39.037-08:00'
blogger_id: tag:blogger.com,1999:blog-14903426.post-6756437144400218510
blogger_orig_url: http://blog.cleverelephant.ca/2008/02/timmys-telethon-1.html
comments: True
---

So, addressing [Timmy's concern](/2008/02/timmys-telethon-0.html)s about open source geospatial:

> 1. Staffing: The specialized skills necessary to build and maintain an open source app are hard to come by. There is a premium on any specialization, is the talent pool to build and support these open source solutions deep enough to maintain continuity in staff skills?

There is, as with any great argument, a kernel of truth in this item, but it is wrapped in a thick, low-calorie, blanket of misdirection, like a corndog at a state fair.

So, should you be concerned about staffing your open source application?  You should, to the extent that:

* the skills required to understand and maintain it take a long time to learn, **and**
* the skills required to understand and maintain it are in short supply.
* Note that you have reason for concern only if **both** conditions occur: the skill must be both difficult to learn **and** in short supply.

Timmy sees that, compared to proprietary toolsets, people with prior experience with open source tool sets are fewer and farther between, and leaps to the conclusion that there is a skills provision risk.

However, the skills necessary to work with open source geospatial applications are either easy to pick up quickly, or transferable from other domains.

* PostGIS: Already worked with Oracle Spatial or ArcSDE's "new" spatial SQL feature? You already know PostGIS.
* Mapserver: Learn the .map file and you are good to go. No harder than picking up enough AXL to be useful. Budget a couple days of learning time.
* OpenLayers: Already worked with Google Maps? You've got the concepts down pat. You'd better know Javascript, but that's a transferable skill and you'll need that for any non-trivial application.
* Geoserver: Point and click through the interface. Do you known enough to deploy a WAR into production? If you installed ArcIMS, you already do.

The slight disadvantage open source has in providing decent tutorial-level guides for new users is offset by the advantage in access to a very helpful user community and direct access to the development community.

Summary: No matter whether you're building on ESRI or open source, if you are building something complex your staff will have to learn a few new skills. Their prior experience with core concepts like programming and IT will serve them well in both domains, and the learning curve will be no worse either way.

Caveat: It's possible Timmy is talking about people who will only learn a new skill if force fed it through a training course, and even then will only retain 50% of what they are taught, who write point-and-click recipes and stick them up on their cubicle walls, who think that "re-boot the server" is a genuine solution. If those are the people whose "skills" he is worrying about, I can only say "go with God, Timmy, peace be unto you, you have larger problems than proprietary vendor lock-in".