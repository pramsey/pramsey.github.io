---
layout: post
title: PostGIS Apologia
date: '2012-08-13T10:52:00.001-07:00'
author: Paul Ramsey
tags:
- postgis
modified_time: '2012-08-13T11:55:10.290-07:00'
blogger_id: tag:blogger.com,1999:blog-14903426.post-633759275368142471
blogger_orig_url: http://blog.cleverelephant.ca/2012/08/postgis-apologia.html
comments: True
---

Nathaniel Kelso [has provided feedback](http://kelsocartography.com/blog/?p=4240) from an (occasionally disgruntled) users point-of-view about ways to make PostGIS friendlier.  I encourage you to read the full post, since it includes explanatory material that I'm going to trim away here to explain the whys and wherefores of how we got to where we are.

TL;DR: philosophical reasons for doing things; historical reasons for doing things; not my problem; just never got around to that.<br />

<blockquote>**Request 1a:** Core FOSS4G projects should be stable and registered with official, maintained APT Ubuntu package list.

**Request 1b:** The APT package distribution of core FOSS4G projects should work with the last 2 versions (equivalent to 2 years) of Ubuntu LTS support releases, not just the most recent cutting edge dot release.</blockquote>

Spoken like an Ubuntu user! I would put the list of "platforms that have enough users to require packaging support" at: Windows, OSX, Centos (RHEL), Fedora, Ubuntu, Debian, SUSE. Multiply by 2 for 32/64 bit support, and add a few variants for things like multiple OSX package platforms (MacPorts, HomeBrew, etc). Reality: the PostGIS team doesn't have the bandwidth to do this, people who want support for their favourite platform have to do it themselves. 

The only exception to this rule is Windows, which Regina Obe supports, but that's because she's actually a dual category person: a PostGIS developer who also really wants her platform supported.

The best Linux support is for Red Hat variants, provided by Devrim Gunduz in the PostgreSQL Yum repositories. I think Devrim's example is actually the best one, since it takes a PostgreSQL packager to do a really bang up job of packaging a PostgreSQL add-on like PostGIS. Unfortunately the [Ubuntu PostgreSQL packager](https://launchpad.net/~pitti) doesn't do PostGIS as well (yet?).<br />

<blockquote>**Request 1c:** Backport key bug fixes to the prior release series</blockquote>

This is actually done as a matter of course. If you know of a fix that is not backported [ticket it](http://trac.osgeo.org/postgis/). In general, if you put your tickets against the earliest milestone they apply to, the odds of a fix hitting all extant versions goes up, since the developer doesn't have to go back and confirm the bug is historical rather than new to the development version. The only fixes that might not get done are ones that can't be done without major code re-structuring, since that kind of thing tends to introduce as many problems as it solves.<br />

<blockquote>**Request 2.1a:** Include a default PostGIS spatial database as part of the basic install, called “default_postgis_db” or something similar.</blockquote>

This is a packaging issue, and some packagers (Windows in particular, but also the OpenGeo Suite) include a *template_postgis* database, since it makes it easier to create new spatial databases (<code>create database foo template template_postgis</code>).

Anyways, as a packaging issue unless the PostGIS team took on all packaging there would be no way to ensure this happened in a uniform way everywhere, which is what one would need to do to have it makes things easier (for it to become general knowledge so that "oh, just use the ______ database" became global advice).

More on creating spatial databases below.<br />

<blockquote>**Request 2.1b:** Include a default PostGIS Postgres user as part of the basic install, called “postgis_user” or something similar.</blockquote>

I'm not sure I see the utility of this. From a data management point of view, you already have the PostgreSQL super user, postgres, around as a guaranteed-to-exist default user.<br />

<blockquote>**Request 2.1c:** If I name a spatially enabled database in shp2pgsql that doesn’t yet exist, make one for me</blockquote>

Unless you have superuser credentials I can't do this. So, maybe?<br />

<blockquote>**Request 2.1d:** It’s too hard to manually setup a spatial database, with around a printed page of instructions that vary with install. It mystifies Postgres pros as well as novices.</blockquote>

Indeed it is! I will hide behind the usual defence, of course, "it's not our fault!" It's just the way PostgreSQL deals with extensions, including their own (load *pgcrypto*, for example, or *fuzzystring*). The best hack we have is the packaging hack that pre-creates a template_postgis, which works pretty well.

Fortunately, as of PostgreSQL 9.1+ and PostGIS 2.0+ we have the "CREATE EXTENSION" feature, so from here on in spatializing (and unspatializing (and upgrading)) a spatial database will be blissfully easy, just <code>CREATE EXTENSION postgis</code> (and <code>DROP EXTENSION postgis</code> (and <code>ALTER EXTENSION postgis UPDTAE TO 2.1.0</code>)).<br />

<blockquote>**Request 2.1e:** Default destination table names in shp2pgsql.</blockquote>

We have this, I just checked (1.5 and 2.0). The usage line indicates it, and it actually happens. I'm pretty sure it's worked this way for a long time too, it's not a new thing.<br />

<blockquote>**Request 2.1f:** Automatically pipe the output to actually put the raw SQL results into PostGIS.</blockquote>

I'll plead historical legacy on this one. The first version (c. 2001) of the loader was just a loader, no dumper, so adding in a database connection would have been needless complexity: just pipe it to psql, right?

Then we got a dumper, so now we had database connection logic lying around, but the loader had existing semantics and users. Also the code was crufty and it would have had to be re-written to get a direct load.

Then we got a GUI (1.5), and that required re-writing the core of the loader to actually do a direct database load. But we wanted to keep the commandline version working the same as before so our existing user base wouldn't get a surprise change. So at this point doing a direct database loader is actually trivial, but we deliberately did not, to avoid tossing a change at our 10 years of legacy users.

So this is very doable, the question is whether we want to make a change like this to a utility that has been unaltered for years.

Incidentally, from an easy-to-use-for-newbies point of view the GUI is obviously way better than the command line. Why not use that? It's what I use in all my PostGIS courses now.<br />

<blockquote>**Request 2.1g:** If my shapefile has a PRJ associated with it (as most do), auto populate the -s <srid> option.</blockquote>

You have no idea how long I've wanted to do this. A very long time. It is, however, very hard to do. PRJ files don't come (except the ones generated by GeoTools) with EPSG numbers in them. You have to figure out the numbers by (loosely) comparing the values in the file to the values in the full EPSG database. (That's what the [http://prj2epsg.org](http://prj2epsg.org) web site does.)

Now that we've added GDAL as a dependency in 2.0 we do at least have access to an existing PRJ WKT parser. However, I don't think the OGR API provides enough hooks though to do something like load up all the WKT definitions in spatial_ref_sys (which is what we'll have to do regardless) and search through them with sufficient looseness.

So this remains an area of active research. Sadly, probably not something that anyone will ever fund, which means given the level of effort necessary to make it happen, probably won't happen.<br />

<blockquote>**Related 2.1h** Projection on the fly: If you still can’t reproject data on the fly, something is wrong. If table X is in projection 1 (eg web merc) and table Y is in projection 2 (eg geographic), PostGIS ought to “just work”, without me resorting to a bunch of ST_Transform commands that include those flags. The SRID bits in those functions should be optional, not required.</blockquote>

Theoretically possible, but it has some potentially awful consequences for performance. You can only do index-assisted things with objects that share an SRS (SRID), since the indexes are built in one SRS space. So picking a side of an argument and pushing it into the same SRS as the other argument could cause you to miss out on an index opportunity.  It's worth perhaps thinking more about, though, since people with heterogenous SRID situations will be stuck in low performing situations whether we auto-transform or not.

The downside of all such "automagic" is that it leads people into non-optimal set-ups very naturally (and completely silently) so they end up wondering why PostGIS sucks for performance when actually it is their data setup that sucks. <br />

<blockquote>**Request 2.1i:** Reasonable defaults in shp2pgsql import flags.</blockquote>

Agree 100%. Again, we're just not changing historical defaults fast enough. The GUI has better defaults, but it wouldn't hurt for the commandline to have them too.<br />

<blockquote>**Request 2.1j:** Easier creation of point features from csv or dbf.</blockquote>

A rat-hole of unknowable depth (csv handling, etc) but agreed, a really very common and useful utility it would be. I just write a new perl script every time :)<br />

<blockquote>**Request 2.3a:** Forward compatible pgdumps. Dumps from older PostGIS & Postgres combinations should always import into newer combinations of PostGIS and Postgres.</blockquote>

Upgrade has been ugly for a long time, and again it's "not our fault", in that until PostgreSQL 9.1, pg_dump always included our functions in the dump files. If you strip out the PostGIS function signature stuff (which is what the utils/postgis_restore.pl script does), it's easy to get a clean and quiet restore into new versions, since we happily read old dumped PostGIS data and always have.

If you don't mind a noisy restore it's also always been possible to just drop a dump onto a new database and ignore the errors as function signatures collide and get a good restore.

With "CREATE EXTENSION" in PostgreSQL 9.1, we will now finally be able to pg_dump clean dumps that don't include the function information, so this story more or less goes away.<br />

<blockquote>**Request 2.3b:** Offer an option to skip PostGIS simple feature topology checks when importing a pgdump.</blockquote>

It's important to note that there are two levels of validity checking in PostGIS. One level is "dumbass validity checking", which can happen at parse time. Do rings close? Do linestrings have more than one point? That kind of thing. For a brief period in PostGIS history we have had some ugly situations where it was possible to create or ingest dumbass geometry through one code path and impossible to output it or ingest it through others. This was bad and wrong. It's hopefully mostly gone. We should now mostly ingest and output dumbass things, because those things do happen. We hope you'll clean or remove them though at a later time.

Be thankful we aren't ArcSDE, which not only doesn't accept dumbass things, it doesn't accept anything that fails any rule of their whole validity model.<br />

<blockquote>**Request 3a:** Topology should only be enforced as an optional add on, even for simple Polygon geoms. OGC’s view of polygon topology for simple polygons is wrong (or at the very least too robust).

**Request 3b:** Teach PostGIS the same winding rule that allows graphics software to fill complex polygons regarding self-intersections. Use that for simple point in polygon tests, etc. Only force me to clean the geometry for complicated map algebra.

**Request 3c:** Teach OGC a new trick about “less” simple features.

**Request 3d:** Beyond the simple polygon gripe, I’d love it if GEOS / PostGIS could become a little more sophisticated. Adobe Illustrator for several versions now allows users to build shapes using their ShapeBuilder tool where there are loops, gaps, overshoots, and other geometry burrs. It just works. Wouldn’t that be amazing? And it would be even better that ArcGIS.</blockquote>

We don't enforce validity, we just don't work very well if it's not present.

Most of these complaints stem presumably from working with Natural Earth data which, since it exists, is definitionally "real world" data, but also includes some of the most unbelievably degenerate geometry I have ever experienced.

Rather than build special cases to handle degeneracy into every geometry function in the system, the right approach, IMO, is to build two functions that convert degenerate data into structured data that captures the "intent" of the original. 

One function, *ST_MakeValid*, has already made an appearance in PostGIS 2.0. It isn't 100% perfect, but it makes a good attempt and fixes many common invalidities that previously we had no answer for beyond "you're SOL". *ST_MakeValid* tries to fix invalidity without changing the input vertices at all.

The second function, ST_MakeClean, does not exist yet. ST_MakeClean would do everything ST_MakeValid does, but would also include a tolerance factor to use in tossing out unimportant structures (little spikes, tiny loops, minor ring crossings) that aren't part of the "intent" of the feature.

**Summary**

I wish we had better packaging or the ability to do all the packaging ourselves so we could create a 100% consistent user experience across every platform, but that's not possible. Please beg your favorite PostgreSQL packager to package PostGIS too.

The upgrade and install stories are going to get better with EXTENSIONS. So, just hang in there and things will improves.

The geometry validity story will get better with cleaning functions, and any extra dollars folks can invest in continuing to improve GEOS and fix obscure issues in the overlay code. The "ultimate fix", if anyone wants to fund that, is to complete "snap rounding" code in JTS, and port that to GEOS, to support a fixed-precision overlay system. That should remove all overlay failures (which actually show up in intersections, unions and buffers, really all constructive geometry operations) once and for all.<br />&nbsp;