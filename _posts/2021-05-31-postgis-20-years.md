---
layout: post
title: 'PostGIS at 20, The Beginning'
date: '2021-05-31T00:00:00-08:00'
author: Paul Ramsey
category: technology
tags:
- refractions
- postgresql
- postgis
- history
comments: True
image: "2017/postgis-logo.jpg"
---

Twenty years ago today, the [first email](https://lists.osgeo.org/pipermail/postgis-users/2001-May/000000.html) on the postgis users mailing list (at that time hosted on yahoogroups.com) was sent, announcing the first numbered release of [PostGIS](https://postgis.net).

![Refractions]({{ site.images }}/2021/rri.jpg)

The early history of PostGIS was tightly bound to a consulting company I had started a few years prior, [Refractions Research](https://web.archive.org/web/20010927072731/http://www.refractions.net/). My early contracts ended up being with provincial government managers who, for their own idiosyncratic reasons, did not want to work with [ESRI](https://esri.com) software, and as a result our company accrued skills and experience beyond what most "GIS companies" in the business had. 

We got good at databases, and the [FME](http://www.safe.com). We got good at Perl, and eventually Java. We were the local experts in a locally developed (and now defunct) data analysis tool called [Facet](https://web.archive.org/web/20000610151220/http://www.facet.com/cfm/index.cfm), which was the meat of our business for the first four years or so. 

![Facet]({{ site.images }}/2021/facet.gif)

That Facet tool was a key part of a "watershed analysis atlas" the BC government commissioned from Facet in the late 1990's. We worked as sub-contractors, building the analytical routines that would suck in dozens of environmental layers, chop them up by watershed, and spit out neat tables and maps, one for each watershed. Given the computational power of the era, we had to use multiple Sun workstations to run the final analysis province-wide, and to manage the job queue, and keep track of intermediate results, we placed them all into tables in [PostgreSQL](http://postgresql.org).

Putting the chopped up pieces of spatial data as blobs into PostgreSQL was what inspired PostGIS. It seemed really obvious that we had the makings of an interactive real-time analysis engine, with all this processed data in the database, if we could just do more with the blobs than only stuff them in and pull them out.

## Maybe We Should do Spatial Databases?

Reading about spatial databases circa 2000 you would find that:

* There was the Oracle 8i Spatial Data Option (SDO).
* There was an [OpenGIS Simple Features for SQL](https://portal.ogc.org/files/?artifact_id=829) specification (SFSQL).
* There wasn't much else.

This led to two initiatives on our part, one of which succeeded and the other of which did not.

First, I started exploring whether there was an opportunity in the BC government for a consulting company that had skill with Oracle's spatial features. BC was actually **standardized** on Oracle as the official database for all things governmental. But despite working with the local sales rep and looking for places where spatial might be of interest, we came up dry. 

![Oracle]({{ site.images }}/2021/oracle.png)

The existing big Oracle ministries (Finance, Justice) didn't do spatial, and the heavily spatial natural resource ministries (Forests, Environment) were still deeply embedded in a "GIS is special" head space, and didn't see any use for a "spatial database". This was all probably a good thing, as it turned out.

Our second spatial database initiative was to explore whether any of the spatial models described in the [OpenGIS Simple Features for SQL](https://portal.ogc.org/files/?artifact_id=829) specification were actually practical. In addition to describing the spatial types and functions, the specification described three ways to store the spatial part of a table.

![OpenGIS]({{ site.images }}/2021/opengis.png)

* In a set of side tables (scheme 1a), where each feature was broken down into x's and y's stored in rows and columns in a table of numbers. 
* In a "binary large object" (BLOB) (scheme 1b).
* In a "geometry type" (scheme 2).

Since the watershed work had given us experience with PostgreSQL, we carried out the testing with that database, examining: could we store spatial data in the database and pull it out efficiently enough to make a database-backed spatial viewer.

![JShape]({{ site.images }}/2021/jshape.jpg)

For the viewer part of the equation, we ran all the experiments using a Java applet called [JShape](https://web.archive.org/web/20001110130900/http://www.jshape.com/index0.html). I was quite fond of JShape and had built a few little map viewer web pages for clients using it, so hooking it up to a dynamic data source rather than files was a rather exciting prospect.

All the development was done on the trusty [Sun Ultra 10](https://unixhq.com/systems/sun-ultra-10/) I had taken out a $10,000 loan to purchase when starting up the company. (At the time, we were still making a big chunk of our revenue from programming against the Facet software, which only ran on Sun hardware.)

![Ultra10]({{ site.images }}/2021/ultra10.jpg)

* The first experiment, shredding the data into side tables, and then re-constituting it for display was very disappointing.  It was just too slow to be usable.
* The second experiment, using the PostgreSQL [BLOB](https://www.postgresql.org/docs/current/largeobjects.html) interface to store the objects, was much faster, but still a little disappointing. And there was no obvious way to add an index to the data.

## Breakthrough

At this point we almost stopped: we'd tried all the stuff explained in the user-level documentation for PostgreSQL. But our most sophisticated developer, [Dave Blasby](https://github.com/dblasby), who had actually **studied computer science** (most of us had mathematics and physics degrees), and was unafraid of low-level languages, looked through the PostgreSQL code and contrib section and said he could probably do a custom type, given some time.

So he took several days and gave it a try. He succeeded!

When Dave had a working prototype, we hooked it up to our little applet and the thing **sang**. It was wonderfully quick, even when we loaded up quite large tables, zooming around the spatial data and drawing our maps. This is something we'd only seen on fancy XWindows displays on UNIX workstations and now were were doing it in an applet on ordinary PC. It was quite amazing.

We had gotten a lot of very good use out of the PostgreSQL database, but there was no commercial ecosystem for PostgreSQL extensions, so it seemed like the best business use of PostGIS was to put it "out there" as open source and see if it generated some in-bound customer traffic.

At the time, Refractions had perhaps 6 staff (it's hard to remember precisely) and many of them contributed, both to the initial release and over time.

* Dave Blasby continued polishing the code, adding some extra functions that seemed to make sense.
* Jeff Lounsbury, the only other staffer who could write C, took up the task of a utility to convert [Shape files](https://support.esri.com/en/white-paper/279) into SQL, to make loading spatial data easier.
* I took on the work of setting up a Makefile for the code, moving it into a CVS repository, writing the documentation, and getting things ready for open sourcing.
* Graeme Leeming and Phil Kayal, my business partners, put up with this apparently non-commercial distraction. Chris Hodgson, an extremely clever developer, must have been busy elsewhere or perhaps had not joined us just yet, but he shows up in later commit logs.

## Release

Finally, on May 31, Dave sent out the [initial release announcement](https://lists.osgeo.org/pipermail/postgis-users/2001-May/000000.html). It was PostGIS 0.1, and you can still [download it](http://download.osgeo.org/postgis/source/postgis-0.1.tar.gz), if you like. This first release had a "geometry" type, a spatial index using the PostgreSQL GIST API, and these functions:

* npoints(GEOMETRY)
* nrings(GEOMETRY)
* mem_size(GEOMETRY)
* numb_sub_objs(GEOMETRY)
* summary(GEOMETRY)
* length3d(GEOMETRY)
* length2d(GEOMETRY)
* area2d(GEOMETRY)
* perimeter3d(GEOMETRY)
* perimeter2d(GEOMETRY)
* truly_inside(GEOMETRY, GEOMETRY)

The only analytical function, "truly_inside()" just tested if a point was inside a polygon.  (For a history of how PostGIS got many of the other analytical functions it now has, see [History of JTS and GEOS](http://lin-ear-th-inking.blogspot.com/2007/06/history-of-jts-and-geos.html) on Martin Davis' blog.)

Reading through those early [mailing list posts](https://lists.osgeo.org/pipermail/postgis-users/) from 2001, it's amazing how **fast** PostGIS integrated into the wider open source geospatial ecosystem. There are posts from Frank Warmerdam of [GDAL](https://gdal.org) and Daniel Morissette of [MapServer](https://mapserver.org) within the first month of release. Developers from the Java GeoTools/GeoServer ecosystem show up early on as well. 

There was a huge demand for an open source spatial database, and we just happened to show up at the right time.

## Where are they Now?

* Graeme, Phil, Jeff and Chris are still doing geospatial consulting at [Refractions Research](http://refractions.net/).
* Dave maintained and improved PostGIS for the first couple years. He left Refractions for other work, but still works in open source geospatial from time to time, mostly in the world of [GeoServer](https://geoserver.org) and other Java projects.
* I found participating in the growth of PostGIS very exciting, and much of my consulting work... less exciting. In 2008, I left Refractions and learned enough C to join the PostGIS development community as a contributor, which I've been doing ever since, currently as a [Executive Geospatial Engineer](https://www.linkedin.com/in/paul-ramsey-717134/) at [Crunchy Data](https://www.crunchydata.com/).


