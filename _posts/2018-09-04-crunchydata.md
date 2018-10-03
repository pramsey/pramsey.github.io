---
layout: post
title: Moving on to Crunchy Data
date: '2018-09-04T08:00:00.000-08:00'
author: Paul Ramsey
category: technology
tags:
- career
- postgres
- postgis
- carto
comments: True
image: "2018/crunchydata.jpg"
---

Today is my [first day](https://info.crunchydata.com/news/crunchy-data-expands-commitment-to-open-source-geospatial-data-management-and-analytics) with my new employer [Crunchy Data](https://www.crunchydata.com/about/). Haven't heard of them? I'm not surprised: outside of the world of PostgreSQL, they are not particularly well known, yet.

<img src="{{ site.images }}{{ page.image }}" alt="{{ page.title }}" />

I'm leaving behind a pretty awesome gig at [CARTO](https://carto.com), and some fabulous co-workers. Why do such a thing?

While CARTO is turning in constant growth and finding good traction with some core spatial intelligence use cases, the path to success is leading them into solving problems of increasing specificity. Logistics optimization, siting, market evaluation. 

Moving to Crunchy Data means transitioning from being the database guy (boring!) in a geospatial intelligence company, to being the geospatial guy (super cool!) in a database company. Without changing anything about myself, I get to be the most interesting guy in the room! What could be better than that?

Crunchy Data has quietly assembled an exceptionally deep team of PostgreSQL community members: Tom Lane, Stephen Frost, Joe Conway, Peter Geoghegan, Dave Cramer, David Steele, and Jonathan Katz are all names that will be familiar to followers of the PostgreSQL mailing lists.  

They've also quietly assembled expertise in key areas of interest to large enterprises: security deployment details (STIGs, RLS, Common Criteria); Kubernetes and PaaS deployments; and now (ta da!) geospatial.

Why does this matter? Because the database world is at a technological inflection point.

Core enterprise systems change very infrequently, and only under pressure from multiple sources. The last major inflection point was around the early 2000s, when the fleet of enterprise proprietary UNIX systems came under pressure from multiple sources:

* The RISC architecture began to fall noticeably behind x86 and particular x86-64.
* Pricing on RISC systems began to diverge sharply from x86 systems.
* A compatible UNIX operating system (Linux) was available on the alternative architecture.
* A credible support company (Red Hat) was available and speaking the language of the enterprise.

The timeline of the Linux tidal wave was (extremely roughly):

* 90s - Linux becomes the choice of the tech cognoscenti.
* 00s - Linux becomes the choice of everyone for greenfield applications.
* 10s - Linux becomes the choice of everyone for all things.

By my reckoning, PostgreSQL is on the verge of a Linux-like tidal wave that washes away much of the enterprise proprietary database market (aka Oracle DBMS). Bear in mind, these things pan out over 30 year timelines, but:

* Oracle DBMS offers no important feature differentiation for most workloads.
* Oracle DBMS price hikes are driving customers to distraction.
* Server-in-a-cold-room architectures are being replaced with the cloud.
* PostgreSQL in the cloud, deployed as PaaS or otherwise, is mature.
* A credible support industry (including Crunchy Data) is at hand to support migrators.

I'd say we're about half way through the evolution of PostgreSQL from "that cool database" to "the database", but the next decade of change is going to be the one people notice. People didn't notice Linux until it was already running practically everything, from web servers to airplane seatback entertainment systems. The same thing will obtain in database land; people won't recognize the inevitability of PostgreSQL as the "default database" until the game is long over.

Having a chance to be a part of that change, and to promote geospatial as a key technology while it happens, is exciting to me, so I'm looking forward to my new role at Crunchy Data a great deal!

Meanwhile, I'm going to be staying on as a [strategic advisor to CARTO](https://carto.com/team/#advisors) on geospatial and database affairs, so I get to have a front seat on their continued growth too. Thanks to CARTO for three great years, I enjoyed them immensely!
