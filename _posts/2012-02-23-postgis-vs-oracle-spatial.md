---
layout: post
title: PostGIS vs Oracle Spatial
date: '2012-02-23T11:29:00.000-08:00'
author: Paul Ramsey
tags:
- postgis
- benchmark
- oracle
- postgresql
modified_time: '2012-02-23T11:29:30.977-08:00'
blogger_id: tag:blogger.com,1999:blog-14903426.post-2076718726189550079
blogger_orig_url: http://blog.cleverelephant.ca/2012/02/postgis-vs-oracle-spatial.html
comments: True
---

"That's a nice database you have there, but how does it compare to Oracle?"

A fair question. On the one hand we have an open source database, with a core development community of a few dozens and a spatial development community of ... a few! On the other hand we have a multi-billion dollar IT behemoth with a client list of Fortune 100 companies. On our biases alone, one would expect Oracle to perform much better.

And we'd have to go on our biases, because there haven't been any Oracle vs PostGIS comparisons available in the wild. Until now.

The Advanced Research Lab for Geospatial Information Science and Engineering of the prestigious [Indian Institute of Technology](http://en.wikipedia.org/wiki/Indian_Institute_of_Technology_Bombay) has [put a study online](https://web.archive.org/web/20120813184338/http://www.gise.cse.iitb.ac.in/wiki/images/c/c4/Finalreport.pdf), comparing PostGIS to Oracle Spatial across a number of spatial join operations, run in both "cold" (empty cache) and "hot" (pre-seeded cache) modes.

The tests require the database to correctly plan a self-join that includes both spatial and attribute clauses, and then execute. The queries generally seem to require a medium to large quantity of spatial objects to be evaluated in spatial predicate tests. So this is a step up from the usual test of bulk bounding box operations that most benchmarks have gotten bogged down in.

And the results? The authors say:

> From the experimental results that we saw, we can conclude that Postgres performs better than Oracle 11g both in the Cold Phase and Warm Phase. Though in few queries Oracle 11g performed better but on the whole Postgres overpowered Oracle 11g. In the warm phase in 3 out of 4 queries Postgres performed significantly well, from this we can conclude that Postgres has better automatic memory management capabilities and page replacement policies... On the whole it is the open-source that wins the game!

Methodologically there are two obvious issues: one is that the Oracle database was on Windows while the PostGIS database was on Linux; the other is that neither database got any tuning, they were both installed and run with default parameters. However, this is one of the nicer comparisons I have read: concise, focussed and with enough technical detail to evaluate what's going on.

Based on that detail, I can also take a stab at guessing why PostGIS did not win every test: the two slower tests used the touches relationship, which is not optimized in PostGIS using a prepared geometry approach. And the non-optimized predicates in PostGIS are quite inefficient, they calculate far more topological information than is strictly necessary to answer a true/fale question about a single topological relationship. So, more room for improvement!

Thanks to IIT for carrying out and sharing this research, truly invaluable stuff.

