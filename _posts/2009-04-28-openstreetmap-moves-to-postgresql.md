---
layout: post
title: OpenStreetMap moves to PostgreSQL
date: '2009-04-28T08:00:00.000-07:00'
author: Paul Ramsey
tags:
- mysql
- rant
- postgresql
modified_time: '2009-04-28T08:00:00.908-07:00'
thumbnail: http://farm4.static.flickr.com/3574/3480456691_06bf196db5_t.jpg
blogger_id: tag:blogger.com,1999:blog-14903426.post-7865857627696012630
blogger_orig_url: http://blog.cleverelephant.ca/2009/04/openstreetmap-moves-to-postgresql.html
comments: True
---

Recently, the [OpenStreetMap](http://openstreetmap.org/) project put out a [very successful call](http://www.opengeodata.org/?p=391) for donations to upgrade their physical database infrastructure, from a [dual-core Athlon with 8Gb of RAM](http://wiki.openstreetmap.org/wiki/Servers/db) and lots (~1Tb) of disk, to a [quad-core Xeon with 32Gb of RAM](http://wiki.openstreetmap.org/wiki/Servers/smaug) and heaps (4Tb) of (15K RPM) disk.

<img src="http://farm4.static.flickr.com/3574/3480456691_06bf196db5_m.jpg" style="float:right;padding:2px;" />The speedy success of the hardware appeal (target reached in less than three days) was pretty impressive, but what really perked my (PostgreSQL fanboi) ears up was the news that the new hardware was going to run PostgreSQL, instead of the MySQL database OSM has used from the start.  As of April 19, OSM is [running their new API](http://lists.openstreetmap.org/pipermail/talk/2009-April/035991.html) live on PostgreSQL.

So, why has OSM abandoned the [worlds most popular open source database](http://www.mysql.com/)? I asked the OSM folks, and this is what Tom Hughes of OSM told me:

> Personally I've been very frustrated with MySQL from when I first got involved with running things. Some of the problem was of our own making in that we had a mix of MyISAM and InnoDB tables (originally everything was in MyISAM) and some tables were using MyISAM features that meant they couldn't be easily moved to InnoDB.
> 
> On top of that it seemed that virtually any non-trivial query would completely defeat MySQL's optimiser.

The comment about a mix of tables really hits home, since so many MySQL features are split across table types. Want transactions? InnoDB! Want full text search? MyISAM! Want spatial? MyISAM! Want spatial or full-text **and** transactions? Tough. The devil is in the details. When asked: does MySQL support spatial, transactions, full-text? the MySQL answer is "yes", "yes", "yes", but the reality in production is not nearly so clear-cut.

Note that OSM is not using PostGIS for the main database at this time (their current data model of nodes and ways wouldn't get much leverage from it) but it is used for other processes like OSM tile generation. And a growing number of people on the PostGIS users list seem to be using [osm2pgsql](http://svn.openstreetmap.org/applications/utils/export/osm2pgsql/) to extract data from the OSM production server for rendering / analysis in PostGIS.

So, welcome OSM, to the PostgreSQL community!