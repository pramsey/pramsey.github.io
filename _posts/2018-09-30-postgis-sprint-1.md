---
layout: post
title: 'PostGIS Code Sprint 2018 #1'
date: '2018-09-30T00:00:00-08:00'
author: Paul Ramsey
category: technology
tags:
- opensource
- postgis
- postgresql
comments: True
image: "2018/sprint1.jpg"
---

When I tell people I am heading to an open source "code sprint", which I try to do at least once a year, they ask me "what do you do there?" 

When I tell them, "talk, mostly", they are usually disappointed. There's a picture, which is not unearned, of programmers bent over their laptops, quietly tapping away. And that happens, but the real value, even when there is lots of tapping, is in the high-bandwidth, face-to-face communication.

<img src="{{ site.images }}{{ page.image }}" alt="{{ page.title }}" />

So, inevitably I will be asked what I coded, this week at the [PostGIS Code Sprint](https://wiki.osgeo.org/wiki/OSGeo_Code_Sprint_2018) and I will answer... "uhhhhh". I did a branch of PostgreSQL that will do partial decompression of compressed tuples, but didn't get around to testing it. I tested some work that others had done. But mostly, we talked.

## PostGIS 3

Why move to PostGIS 3 for the next release? Not necessarily because we will have any earth-shattering features, but to carry out a number of larger changes. Unlike most PostgreSQL extensions, PostGIS has a lot of legacy from past releases and has added, removed and renamed functions over time. These things are disruptive, and we'd like to do some of the known disruptive things at one time.

### Split Vector and Raster

When we brought raster into PostGIS, we included it in the "postgis" extension, so if you `CREATE EXTENSION postgis` you get both vector and raster features. The rationale was that if we left it optional, packagers wouldn't build it, and thus most people wouldn't have access to the functionality, so it wouldn't get used, so we'd be maintaining unused garbage code.

Even being included in the extension, by and large people haven't used it much, and the demand from packagers and other users to have a "thin" PostGIS with only vector functionality have finally prevailed: when you `ALTER EXTENSION postgis UPDATE TO '3.0.0'` the raster functions will be unbundled from the extension. They can then be re-bundled into a "postgis_raster" dependent package and either dropped or kept around depending on user preference.

### Remove postgis.so Minor Version

For users in production, working with packaged PostgreSQL, in `deb` or `rpm` packages, the packaging system often forces you to have only one version of PostGIS installed at a time. When upgrading PostgreSQL and PostGIS the net effect is to break `pg_upgrade`, meaning PostGIS users are mandated to do a full dump/restore.

Removing the minor version will allow the `pg_upgrade` process to run through, and users can then run the sql `ALTER EXTENSION postgis UPDATE` command to synchronize their SQL functions with the new binary `postgis.so` library.

This is good for most users. It's bad for users who expect to be able to run multiple versions of PostGIS on one server: they won't easily be able to. There will be a switch to make it possible to build with minor versions again, but we expect it will mostly be used by us (developers) for testing and development.

### Serialization

As I [discussed recently](/2018/09/postgis-external-storage.html), the compression of geometries in PostgreSQL can have a very large effect on performance. 

A new serialization could:

* use a more effective compression format for our kind of data, arrays of autocorrelated doubles
* add space for more flag bits for things like
  * encoding a smaller point format
  * flagging empty geometries
  * noting the validity of the object
  * noting the presense of a unique hash code
  * extra version bits
  * optional on-disk internal indexes or summary shapes

It's not clear that a new serialization is a great idea. The only really pressing problem is that we are starting to use up our flag space. 

### Validity Flag

Testing geometry validity is computationally expensive, so for workflows that require validity a lot of time is spent checking and rechecking things that have already been confirmed to be valid. Having a flag on the object would allow the state to be marked once, the first time the check is done.

The downside of a validity flag is that every operation that alters coordinates must then carefully make sure to turn the flag off again, as the object may have been rendered invalid by the processing.

### Exception Policy

A common annoyance for advanced users of PostGIS is when a long running computation stops suddenly and the database announces "TopologyException"!

It would be nice to provide some ways for users to indicate to the database that they are OK losing some data or changing some data, if that will complete the processing for 99% of the data.

We discussed adding some standard parameters to common processing functions:

* `null_on_exception` (true = return null, false = exception)
* `repair_on_exception` (true = makevalid() the inputs, false = do the `null_on_exception` action)

### Modern C

C is not a quickly changing langauge, but since the PostgreSQL project has moved to C99, we will also be moving to C99 as our checked standard language.

### Named Parameters

A lot of our function defintions were written before the advent of default values and named parameters as PostgreSQL function features. We will modernize our SQL extension file so we're using named parameters everywhere. For users this will mean that correct parameter order will not be *required* anymore, it will be optional if you use named parameters.

### M Coordinate

PostGIS supports "4 dimensional" features, with X, Y, Z and M, but while everyone knows what X, Y and Z are, only GIS afficionados know what "M" is. We will document M and also try and bring M support into GEOS so that operations in GEOS are "M preserving".

## Project Actions

### Web Site

The web site is getting a little crufty around content, and the slick styling of 7 years ago is not quite as slick. We agreed that it would be OK to modernize, with particular emphasis on:

* thinking about new user onboarding and the process of learning
* supporting mobile devices with a responsive site style
* using "standard" static site infrastructure (jekyll probably)

### Standard Data

We agreed that having some standard data that was easy to install would make a whole bunch of other tasks much easier:

* writing standard workshops and tutorials, so all the examples lined up
* writing a performance harness that tracked the performance of common queries over time
* having examples in the reference documentation that didn't always have to generate their inputs on the fly

### News File Policy

It's a tiny nit, but for developers back-porting fixes over our 4-5 stable branches, knowing where to note bugs in the NEWS files, and doing it consistently is important. 

* Bug fixes applied to stable branches always listed in NEWS for each branch applied to
* Bug fixes applied to stable **and** trunk should be listed in NEWS for each branch **and** NEWS in trunk
* Bug fixes applied to only trunk can be left out of trunk NEWS (these bugs are development artifacts, not bugs that users in production have reported)

## Next...

We also discussed features and changes to PostgreSQL that would help PostGIS improve, and I'll write about those in the next post.


