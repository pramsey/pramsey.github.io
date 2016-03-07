---
layout: post
title: PostGIS Code Re-org
date: '2008-11-03T08:21:00.000-08:00'
author: Paul Ramsey
tags: 
modified_time: '2008-11-03T08:38:44.645-08:00'
blogger_id: tag:blogger.com,1999:blog-14903426.post-6122177202214734891
blogger_orig_url: http://blog.cleverelephant.ca/2008/11/postgis-code-re-org.html
---

Most commit messages are pretty terse affairs ("Fix for issue #142.", "Remove compile warnings.") but this morning, Mark Cave-Ayland posted this novel along with his code changes:

<blockquote>*r3224 /trunk/loader/ (Makefile.in pgsql2shp.c wkb.h)*

Switch pgsql2shp over to using liblwgeom.

There are few commits that can be as satisfying as one which involves the removal of ~1200 lines of code. By using the liblwgeom parser instead of the in-built parser, we have now achieved the following:

i) all parsers within PostGIS, shp2pgsql and pgsql2shp are now the same which means they all follow the same rules. Also extended error reporting information including error text and position information is available.

ii) the complexity of the shp2pgsql/pgsql2shp is considerably reduced.

The slightly unfortunate cost is the overall executable size is larger, since we are linking with liblwgeom. However, from both a consistency and maintainability point of view, this is a big win. Note that while there may be a difference in behaviour in some corner cases, all regression tests pass here. </blockquote>

Some extra explanation is in order. Mark's goal for the 1.4 release of PostGIS is to clean up the underlying code and make it easier to develop on. That has resulted in some major reorganization under the covers. 

The geometry framework (liblwgeom) under PostGIS was written to be separable from the rest of the specific PgSQL code, but historically was managed right alongside it, in the same directory and built chain.  Mark has broken it out into it's own directory with a separate build out to a true library file. 

Now that the geometry framework is a true library, it can be used in other places, not just the back-end.  So hooking the data loader/dumpers into it is a first step, and as he notes, improves the code immensely.

