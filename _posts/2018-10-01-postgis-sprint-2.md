---
layout: post
title: 'PostGIS Code Sprint 2018 #2'
date: '2018-10-01T00:00:00-08:00'
author: Paul Ramsey
category: technology
tags:
- opensource
- postgis
- postgresql
comments: True
image: "2018/sprint2.jpg"
---

An important topic of conversation this sprint was what kinds of core PostgreSQL features might make PostGIS better in the future? 

<img src="{{ site.images }}{{ page.image }}" alt="{{ page.title }}" />

## Parallel GIST Scan

The PostGIS spatial index is built using the PostgreSQL [GIST index infrastructure](https://www.postgresql.org/docs/11/static/gist.html), so anything that makes GIST scans faster is a win for us. This would be a big win for folks with large tables (and thus deep trees) and who run scans that return a lot of indexed tuples.

## Faster GIST Index Building

B-Tree index builds are accellerated by pre-sorting the inputs; could the same trick be used in building GIST indexes? Again, for large tables, GIST index building is slower than B-Tree and "faster" is the #1 feature all existing users want.

## Multi-Threading in Functions

This isn't a feature request, so much as a request for clarification and assurance: PostGIS calls out to other libraries, like GEOS, and it's possible we could make some of our algorithms there faster via parallel processing. If we do our parallel processing within a function call, so the PostgreSQL thread of execution isn't doing anything until we return, is it OK for us to do threading? We use pthreads, or maybe OpenMP.

## Compressed Datum Slicing

"Detoast datum slice" doesn't actually get around to the slicing step until after the datum is decompressed, which can make [some queries quite slow](/2018/09/postgis-external-storage.html). We already try to read boxes from the headers of our objects, and for large objects that means decompressing the whole thing: it would be nice to only decompress the first few bytes. I have an [ugly patch](https://github.com/pramsey/postgres/pull/2/files) I will be testing to try and get committed.

##  Forced Inlining

A problem we have with PostgreSQL right now is that we cannot effectively cost our functions due to the [current inlining behaviour on our wrapper functions](/2018/09/parallel-postgis-3.html) like `ST_Intersects()`. When raised on the list, the hackers came to a tentative conclusion that [improving the value caching behaviour](https://www.postgresql.org/message-id/20171116182208.kcvf75nfaldv36uh%40alap3.anarazel.de) would be a good way to avoid having inlining in incorrect places. It sounded like subtle and difficult work, and nobody jumped to it.

We propose leaving the current inlining logic unchanged, but adding an option to SQL language functions to force inlining for those functions. That way there is no ambiguity: we always want our wrapper functions inlined; always, always, always. If we could use an `INLINE` option on our wrapper function definitions all the current careful logic can remain in place for more dynamic use cases.

## Extension Version Dependency

PostGIS is growing a small forest of dependent extensions

* some inside the project, like `postgis_topology` and now `postgis_raster`
* some outside the project, like [PgRouting](https://pgrouting.org/) and [pgpointcloud](https://github.com/pgpointcloud/pointcloud)

When a new version of PostGIS is installed, we want **all** the PostGIS extensions to be updated. When a third party extension is installed, it may require features from a **particular** recent version of PostGIS. 

The extension framework supports dependency, but for safety, as the ecosystem grows, version dependencies are going to be required eventually.

## Global Upgrade Paths

Right now extension upgrade paths have to explicitly state the start and end version of the path. So an upgrade file might be named `postgis--2.3.4--2.3.5.sql`. That's great if you have four or five versions. We have way more than that. The number of upgrade files we have keeps on growing and growing. 

Unlike upgrade files for smaller projects, we drop and recreate all the functions in our upgrade files. That means that actually our current version upgrade file is capable of upgrading **any prior** version. Nonetheless, we have to make a copy, or a symlink, many many version combinations.

If there was a global "version", we could use our master upgrade script, and only ship one script for each new version: `postgis--ANY--2.3.5.sql`

## Size Based Costing in the Planner

Right now costing in the planner is based heavily on the "number of rows" a given execution path might generate at each stage. This is fine when the cost of processing each tuple is fairly uniform.

For us, the cost of processing a tuple can vary wildly: calculating the area of a 4 point polygon is far cheaper than calculating the area of a 40000 point polygon. Pulling a large feature out of TOAST tuples is more expensive than pulling it from main storage.

Having function `COST` taken into more consideration in plans, and having that `COST` scale with the average size of tuples would make for better plans for PostGIS. It would also make for better plans for PostgreSQL types that can get very large, like `text` and `tsvector`.

The analysis hooks might have to be enriched to also ask for stats on average tuple size for a query key, in addition to selectivity, so a query that pulled a moderate number of huge objects might have a higher cost than one that pulled quite a few small objects.

## We Are Not Unreasonable People

We just want our due, you know?

Thanks, PostgreSQL team!

