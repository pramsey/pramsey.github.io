---
layout: post
title: 'Parallel PostGIS and PgSQL 12'
date: '2019-05-27T08:00:00-08:00'
author: Paul Ramsey
category: technology
tags:
- parallel
- postgis
- postgresql
comments: True
image: "2016/parallel.png"
---

For the last couple years I have been testing out the ever-improving support for parallel query processing in PostgreSQL, particularly in conjunction with the PostGIS spatial extension. Spatial queries tend to be CPU-bound, so applying parallel processing is frequently a big win for us.

<img src="{{ site.images }}{{ page.image }}" alt="{{ page.title }}" width="500" height="270" />

Initially, the results were pretty bad. 

* [With PostgreSQL 10](http://blog.cleverelephant.ca/2016/03/parallel-postgis.html), it was possible to force some parallel queries by jimmying with global cost parameters, but nothing would execute in parallel out of the box.
* [With PostgreSQL 11](http://127.0.0.1:4000/2018/09/parallel-postgis-3.html), we got support for parallel aggregates, and those tended to parallelize in PostGIS right out of the box. However, parallel scans still required some manual alterations to PostGIS function costs, and parallel joins were basically impossible to force no matter what knobs you turned.

With PostgreSQL 12 and PostGIS 3, **all that has changed**. All standard query types now readily parallelize using our default costings. That means parallel execution of:

* Parallel sequence scans,
* Parallel aggregates, and
* Parallel joins!!


## TL;DR:

PostgreSQL 12 and PostGIS 3 have finally cracked the parallel spatial query execution problem, and all major queries execute in parallel without extraordinary interventions.

## What Changed

With PostgreSQL 11, most parallelization worked, but only at much higher function costs than we could apply to PostGIS functions. With higher PostGIS function costs, [other parts of PostGIS stopped working](https://carto.com/blog/postgres-parallel/), so we were stuck in a Catch-22: improve costing and break common queries, or leave things working with non-parallel behaviour.

For PostgreSQL 12, the core team (in particular [Tom Lane](https://en.wikipedia.org/wiki/Tom_Lane_(computer_scientist))) provided us with [a sophisticated new way](https://www.postgresql.org/message-id/flat/15193.1548028093%40sss.pgh.pa.us) to add spatial index functionality to our key functions.  With that improvement in place, we were able to globally increase our function costs without breaking existing queries. That in turn has signalled the parallel query planning algorithms in PostgreSQL to parallelize spatial queries more aggressively.

## Setup

In order to run these tests yourself, you will need:

* PostgreSQL 12
* PostGIS 3.0

You'll also need a multi-core computer to see actual performance changes. I used a 4-core desktop for my tests, so I could expect 4x improvements at best.

The [setup instructions](https://gist.github.com/pramsey/126a5a384c3fca554d6be99328da11aa) show where to download the [Canadian polling division](http://open.canada.ca/data/en/dataset/157fcaf7-e1f7-4f6d-8fc9-564ec925c1ee) data used for the testing:

* `pd` a table of ~70K polygons
* `pts` a table of ~70K points
* `pts_10` a table of ~700K points
* `pts_100` a table of ~7M points

<img src="{{ site.images }}/2017/parallel_4.jpg" alt="PDs" width="600" height="280" />

We will work with the default configuration parameters and just mess with the `max_parallel_workers_per_gather` at run-time to turn parallelism on and off for comparison purposes. 

When `max_parallel_workers_per_gather` is set to 0, parallel plans are not an option.

* `max_parallel_workers_per_gather` sets the maximum number of workers that can be started by a single Gather or Gather Merge node. Setting this value to 0 disables parallel query execution. Default 2. 

Before running tests, make sure you have a handle on what your parameters are set to: I frequently found I accidentally tested with `max_parallel_workers` set to 1, which will result in **two** processes working: the leader process (which does real work when it is not coordinating) and one worker.

{% highlight sql %}
show max_worker_processes;
show max_parallel_workers;
show max_parallel_workers_per_gather;
{% endhighlight %}


## Aggregates

Behaviour for aggregate queries is still good, as seen in PostgreSQL 11 last year.

{% highlight sql %}
SET max_parallel_workers = 8;
SET max_parallel_workers_per_gather = 4;

EXPLAIN ANALYZE 
  SELECT Sum(ST_Area(geom)) 
    FROM pd;
{% endhighlight %}

Boom! We get a 3-worker parallel plan and execution about 3x faster than the sequential plan.


## Scans

The simplest spatial parallel scan adds a spatial function to the target list or filter clause. 

{% highlight sql %}
SET max_parallel_workers = 8;
SET max_parallel_workers_per_gather = 4;

EXPLAIN ANALYZE 
  SELECT ST_Area(geom)
    FROM pd; 
{% endhighlight %}

Boom! We get a 3-worker parallel plan and execution about 3x faster than the sequential plan. This query did not work out-of-the-box with PostgreSQL 11.

```
 Gather  
   (cost=1000.00..27361.20 rows=69534 width=8)
   Workers Planned: 3
   ->  Parallel Seq Scan on pd  
   (cost=0.00..19407.80 rows=22430 width=8)
```


## Joins

Starting with a simple join of all the polygons to the 100 points-per-polygon table, we get:

{% highlight sql %}
SET max_parallel_workers_per_gather = 4;

EXPLAIN  
 SELECT *
  FROM pd 
  JOIN pts_100 pts
  ON ST_Intersects(pd.geom, pts.geom);
{% endhighlight %}

<img src="{{ site.images }}/2017/parallel_3.jpg" alt="PDs &amp; Points" width="600" height="250" />

Right out of the box, we get a parallel plan! No amount of begging and pleading would get a parallel plan in PostgreSQL 11

```
 Gather  
   (cost=1000.28..837378459.28 rows=5322553884 width=2579)
   Workers Planned: 4
   ->  Nested Loop  
       (cost=0.28..305122070.88 rows=1330638471 width=2579)
         ->  Parallel Seq Scan on pts_100 pts  
             (cost=0.00..75328.50 rows=1738350 width=40)
         ->  Index Scan using pd_geom_idx on pd  
             (cost=0.28..175.41 rows=7 width=2539)
               Index Cond: (geom && pts.geom)
               Filter: st_intersects(geom, pts.geom)
```

The only quirk in this plan is that the nested loop join is being driven by the `pts_100` table, which has 10 times the number of records as the `pd` table. 

The plan for a query against the `pt_10` table also returns a parallel plan, but with `pd` as the driving table.

{% highlight sql %}
EXPLAIN  
 SELECT *
  FROM pd 
  JOIN pts_10 pts
  ON ST_Intersects(pd.geom, pts.geom);
{% endhighlight %}

Right out of the box, we still get a parallel plan! No amount of begging and pleading would get a parallel plan in PostgreSQL 11

```
 Gather  
   (cost=1000.28..85251180.90 rows=459202963 width=2579)
   Workers Planned: 3
   ->  Nested Loop  
       (cost=0.29..39329884.60 rows=148129988 width=2579)
         ->  Parallel Seq Scan on pd  
             (cost=0.00..13800.30 rows=22430 width=2539)
         ->  Index Scan using pts_10_gix on pts_10 pts  
             (cost=0.29..1752.13 rows=70 width=40)
               Index Cond: (geom && pd.geom)
               Filter: st_intersects(pd.geom, geom)
```

## Conclusions

* With PostgreSQL 12 and PostGIS 3, most spatial queries that can take advantage of parallel processing should do so automatically.
* !!!!!!!!!!!



