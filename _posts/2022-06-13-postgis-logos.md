---
layout: post
title: 'Who are the Biggest PostGIS Users?'
date: '2022-06-04T00:00:00-08:00'
author: Paul Ramsey
category: technology
tags:
- postgis
comments: True
image: "2022/elemap.jpg"
---

The question of "who uses PostGIS" or "how big is PostGIS" or "how real is PostGIS" is one that we have been wrestling with literally since the first public release back in 2001.

<a href="https://twitter.com/hareldan/status/1536269406505996288?s=21"><img src="{{ site.images }}/2022/postgis_tweet.png" style="border: 1px solid lightgray;" /></a>

There is no doubt that institutional acceptance is the currency of ... more institutional acceptance. 

![Oroboros]({{ site.images }}/2022/oroboros.png)

So naturally, we would love to have a page of logos of our major users, but unfortunately those users do not self-identify.

As an open source project PostGIS has a very tenuous grasp at best on who the institutional users are, and things have actually gotten worse over time.

Originally, we were a source-only project and the source was hosted on one web server we controlled, so we could literally read the logs and see institutional users.  At the time mailing lists were the only source of project communication, so we could look at the list participants, and get a feel from that.

All that's gone now. Most users get their PostGIS pre-installed by their cloud provider, or pre-built from a package repository. 

So what do we know?


## IGN

In the early days, I collected use cases from users I identified on the mailing list. My favourite was our first major institutional adopter, the [Institut G&eacute;ographique National](https://ign.fr/), the national mapping agency of France. 

![IGN]({{ site.images }}/2022/ign.png)

In 2005, they decided to move from a desktop GIS paradigm for their nation-wide basemap (of 150M features), to a database-centric architecture. They ran a bake-off of Oracle, DB2 and PostgreSQL (I wonder who got PostgreSQL into the list) and determined that all the options were similar in performance and functionality for their uses. So they chose the open source one. To my knowledge IGN is to this day a major user of PostgreSQL / PostGIS.


## GlobeXplorer

Though long-gone as a brand, it's possible the image management system that was built by GlobeXplorer in the early 2000's is still spinning away in the bowels of [Maxar](https://www.maxar.com/).

![MAXAR]({{ site.images }}/2022/maxar.png)

GlobeXplorer was both one of the first major throughput use cases we learned about, and also the first one where we knew we'd displaced a proprietary incumbant. GlobeXplorer was one of the earliest companies explicitly serving satellite imagery to the web and via web APIs. They used a spatial database to manage their catalogue of images and prepared product. Initially it was built around DB2, but DB2 was a poor scaling choice. PostGIS was both physically faster and (more importantly) massively cheaper as scale went up.


## RedFin

RedFin was a rarity, a use case found in the wild that we didn't have to track down ourselves. 

![RedFin]({{ site.images }}/2022/redfin.png)

They described in some detail their path from [MySQL to PostgreSQL](https://www.redfin.com/news/elephant_versus_dolphin_which_is_faster_which_is_smarter/), including the advantages of having PostGIS. 

>  Using PostGIS, we could create an index on centroid_col, price, and num_bedrooms. These indexes turned many of our “killer” queries into pussycats.


## Google

Google is not that big on promoting any technology they haven't built in house, but we have heard individual Google developers confirm that they use core open source geospatial libraries in their work, and that PostGIS is included in the mix.

![Google]({{ site.images }}/2022/google.jpg)

The biggest validation Google ever gave PostGIS was in a [press release](https://cloud.google.com/blog/products/gcp/bridging-the-gap-between-data-and-insights) that recognized that the set of "users of spatial SQL" was basically the same as the set of "PostGIS users".

> Our new functions and data types follow the SQL/MM Spatial standard and will be familiar to PostGIS users and anyone already doing geospatial analysis in SQL. This makes workload migrations to BigQuery easier. We also support WKT and GeoJSON, so getting data in and out to your other GIS tools will be easy.

They didn't address their new release to "Esri users" or "Oracle users" or "MySQL users", they addressed it to the relevant population: PostGIS users.


## More!

Getting permission to post logos is hard. Really hard. I've watched marketing staff slave over it. I've slaved over it myself.

Major automaker? Check. Major agricultural company? Check. Major defence contractor? Check, check, check. National government? Check. State, local, regional? Check, check, check. Financial services? Check. Management consulting? Check. 

Yes, PostGIS is real.

At some point, for a project with a $0 price point, you just stop. If a user can't be bothered to do the due diligence on the software themselves, to reap all the advantages we offer, for free, I'm not going to buy them a steak dinner, or spoon feed them references.

That said! If you work for a major government or corporate institution and you are allowed to publicize your use of PostGIS, I would love to write up a short description of your use, for the web site and our presentation materials.

[Email me!](mailto:pramsey@cleverelephant.ca)





