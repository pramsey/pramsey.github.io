---
layout: post
title: Some good news... and some bad news...
date: '2007-03-15T04:44:00.000-07:00'
author: Paul Ramsey
tags: 
modified_time: '2007-03-15T04:55:28.337-07:00'
blogger_id: tag:blogger.com,1999:blog-14903426.post-8204647785512939523
blogger_orig_url: http://blog.cleverelephant.ca/2007/03/some-good-news-and-some-bad-news.html
comments: True
---

Some more details on the upcoming ArcSDE support for PostgreSQL are living in [the Q&A page](http://events.esri.com/uc/QandA/index.cfm?ConferenceID=3B67AFC7-D566-ED85-A18E8EFF9B63B57B) for the upcoming Developers Summits (as pointed out by [James Fee](http://www.spatiallyadjusted.com/2007/03/13/esri-posts-the-developer-summit-qa/)).

First there's the old news:

> ArcGIS Server (ArcSDE technology) will support the PostgreSQL database at the ArcGIS 9.3 release.

Then there's the good news:

> The enterprise geodatabase and all of its standard capabilities will be fully supported. It will be OGC/ISO compliant and the PostGIS geometry type will be supported.

Yay! You can work with PostGIS columns via SDE and then push the data out to other PostGIS enabled tools, like Mapserver or Hibernate or GRASS! And then finally, the bad news:

> In addition, ESRI will also provide its own spatial type for storing geometries in PostgreSQL.

Gah! Ouch! It burns!  There aren't "special" types for Informix or DB2, why for PostgreSQL/PostGIS? Unlike Oracle, we are ready and willing to add the features to PostGIS necessary to fully support ArcSDE's spatial SQL needs. And if you don't trust Refractions, PostGIS is open source, so you could just do it yourselves! Hop in the pool, guys, supporting open source is not just about software, it is about community participation, everyone rowing in the same direction so nobody has to row too hard by themselves.