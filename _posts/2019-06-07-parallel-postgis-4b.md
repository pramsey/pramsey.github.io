---
layout: post
title: 'Parallel PostGIS and PgSQL 12 - 2'
date: '2019-06-07T08:00:00-08:00'
author: Paul Ramsey
category: technology
tags:
- parallel
- postgis
- postgresql
comments: True
image: "2016/parallel.png"
---

In my [last post](/2019/05/parallel-postgis-4.html) I demonstrated that PostgreSQL 12 with PostGIS 3 will provide, for the first time, **automagical parallelization of many common spatial queries**. 

This is huge news, as it opens up the possibility of extracting more performance from modern server hardware. Commenters on the post immediately began conjuring images of 32-core machines reducing their query times to miliseconds. 

So, the next question is: **how much more performance** can we expect?

To investigate, I acquired a 16 core machine on AWS ([m5d.4xlarge](https://aws.amazon.com/ec2/instance-types/m5/)), and installed the current development snapshots of PostgreSQL and PostGIS, the code that will become versions 12 and 3 respectively, when released in the fall.

## How Many Workers?

The number of workers assigned to a query is determined by PostgreSQL: the system looks at a given query, and the size of the relations to be processed, and assigns workers [proportional to the log of the relation size](https://github.com/postgres/postgres/blob/8255c7a5eeba8f1a38b7a431c04909bde4f5e67d/src/backend/optimizer/path/allpaths.c#L3609-L3615).

For parallel plans, the "explain" output of PostgreSQL will include a count of the number of workers planned and assigned. That count is **exclusive of the leader process**, and the leader process actually does work outside of its duties in coordinating the query, so the number of CPUs actually working is more than the `num_workers`, but slightly less than `num_workers+1`. For these graphs, we'll assume the leader fully participates in the work, and that the number of CPUs in play is `num_workers+1`.

## Forcing Workers

PostgreSQL's automatic calculation of the number of workers could be a blocker to performing analysis of parallel performance, but fortunately there is a workaround. 

Tables support a "[storage parameter](https://www.postgresql.org/docs/current/sql-createtable.html#SQL-CREATETABLE-STORAGE-PARAMETERS)" called `parallel_workers`. When a relation with `parallel_workers` set participates in a parallel plan, the value of `parallel_workers` over-rides the automatically calculated number of workers.

{% highlight sql %}
ALTER TABLE pd SET ( parallel_workers = 8);
{% endhighlight %}

In order to generate my data, I re-ran my queries, upping the number of `parallel_workers` on my tables for each run.

## Setup

Before running the tests, I set all the global limits on workers high enough to use all the CPUs on my test server.

{% highlight sql %}
SET max_worker_processes = 16;
SET max_parallel_workers = 16;
SET max_parallel_workers_per_gather = 16;
{% endhighlight %}

I also [loaded my data and created indexes as usual](https://gist.github.com/pramsey/126a5a384c3fca554d6be99328da11aa). The tables I used for these tests were:

* `pd` a table of 69,534 polygons
* `pts_10` a table of 695,340 points


## Scan Performance

I tested two kinds of queries: a straight scan query, with only one table in play; and, a spatial join with two tables. I used the usual queries from my annual parallel tests.

{% highlight sql %}
EXPLAIN ANALYZE 
  SELECT Sum(ST_Area(geom)) 
    FROM pd;
{% endhighlight %}

Scan performance improved well at first, but started to flatten out noticably after 8 cores.

| Workers   | 1   | 2   | 4   | 8   | 16  |
|:---------:|:---:|:---:|:---:|:---:|:---:|
| Time (ms) | 318 | 167 | 105 | 62  | 47  |

<img src="https://docs.google.com/spreadsheets/d/e/2PACX-1vT-ZUsOMlgJQL8ioqWrZ8_cYLX1StpUNS3bwaqlCDlWwGvIlL7emPIPc6GOb3p38GsqyzKo_4Kk7g7x/pubchart?oid=1532202207&format=image" />

The default number of CPUs the system wanted to use was 4 (1 leader + 3 workers), which is probably **not a bad choice**, as the expected gains from addition workers shallows out as the core count grows. 

## Join Performance

The join query computes the join of 69K polygons against 695K points. The points are actually generated from the polygons, so there are precisely 10 points in each polygon, so the resulting relation would be 690K records long.

{% highlight sql %}
EXPLAIN ANALYZE
 SELECT *
  FROM pd 
  JOIN pts_10 pts
  ON ST_Intersects(pd.geom, pts.geom);
{% endhighlight %}

For unknown reasons, it was impossible to force out a join plan with only 1 worker (aka 2 CPUs) so that part of our chart/table is empty. 

| Workers   | 1     | 2   | 4    | 8    | 16   |
|:---------:|:-----:|:---:|:----:|:----:|:----:|
| Time (ms) | 26789 | -   | 9371 | 5169 | 4043 |

The default number of workers is again 4 (1 leader + 3 workers) which, again, isn't bad. The join performance shallows out faster than the scan performance, and above 10 CPUs is basically flat.

<img src="https://docs.google.com/spreadsheets/d/e/2PACX-1vT-ZUsOMlgJQL8ioqWrZ8_cYLX1StpUNS3bwaqlCDlWwGvIlL7emPIPc6GOb3p38GsqyzKo_4Kk7g7x/pubchart?oid=578132959&format=image" />


## Conclusions

* There is a limit to how much advantage adding workers to a plan will gain you
* The limit feels intuitively lower than I expected given the CPU-intensity of the workloads
* The planner does a pretty good, slightly conservative, job of picking a realistic number of workers



