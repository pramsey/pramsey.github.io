---
layout: post
title: 'Timmy''s Telethon #3'
date: '2008-02-13T14:13:00.000-08:00'
author: Paul Ramsey
tags: 
modified_time: '2008-02-13T14:43:18.237-08:00'
blogger_id: tag:blogger.com,1999:blog-14903426.post-2002241821442734368
blogger_orig_url: http://blog.cleverelephant.ca/2008/02/timmys-telethon-3.html
comments: True
---

Neither rain nor sleet nor dark of night will stop me:

> 3. Sociology / Psychology: There is so much more to pitching a solution to those who control the purse strings than technical logic. Selling open source to the powers that be is… well it’s tough. Are there consultants that can be hired to answer the hard questions and make the decision makers feel comfortable? I would love to see more real world business cases for comprehensive GIS environments that must cater to diverse requirements.

25 years ago, selling anything that wasn't IBM to the powers-that-be was tough. I expect selling open source to remain tough, but get easier and easier over time as people with Internet-centric mindsets percolate up into decision making positions for larger organizations.

Sure, there are consultants, as in any field. Real-world business cases are available, but few and far between. When you [ask people to write their own case studies](http://lists.osgeo.org/pipermail/discuss/2008-February/003105.html), generally the folks with interesting studies are too busy to do it, so you end up with a bunch of academic stuff. And going out to gather the things is a lot of work. And often some of the most compelling studies are found by accident! 

I compile [case studies for PostGIS](http://postgis.refractions.net/documentation/casestudies/), and every 12 months I ask on the [postgis-users](http://postgis.refractions.net/mailman/listinfo/postgis-users) mailing list (1500 subscribers) for folks to volunteer for case studies. I'll do the writing and editing, they just need to talk to me on the phone or on email. I don't get many responses!

When I was at FOSS4G 2006 two years ago, it was mentioned in passing to me that "oh yes, IGN is using PostGIS now". So I asked for a contact name, tracked the guy down, and extracted the story from him. It's a [great case study](http://postgis.refractions.net/documentation/casestudies/ign/)! But getting it required a curious combination of persistence and luck. Same with the [North Dakota](http://postgis.refractions.net/documentation/casestudies/northdakota/) study, which I got via friend-of-a-friend referral.

<img src="http://www.studiodentaire.com/images/dental_extraction_drawing.jpg" style="border:0" />

The request for information about "comprehensive GIS environments" feels like trolling for someone to say "just drop ESRI"! And that would be silly. Open source has lots of solutions that do things that ESRI products do, but there is no comprehensive drop-in replacement solution. Even if there were, the switching costs alone would probably make in uneconomic. 

So here is what to say to the powers-that-be. Don't foam at the mouth, don't wear jams and a backwards baseball cap. Recognize that change is slow, and there are sound financial reasons for that:

> For an organization just getting started with open source, it provides advantages at the margins: not in reworking your existing systems, but giving you flexible options when building *new* ones. The existing systems should be left running until they hit a natural end-of-life, either when they become out of date, or so expensive to run/pay maintenance on that the switching cost actually becomes acceptable. Evaluate the cost of change regularly.  Sometimes not changing is the more expensive option, and it is important to know what that time arrives.

