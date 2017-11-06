---
layout: post
title: 'Parallel PostGIS IIA'
date: '2017-11-06T12:00:00-08:00'
author: Paul Ramsey
category: technology
tags:
- parallel
- postgis
- postgresql
comments: True
image: "2016/parallel.png"
---

One of the core complaints in my [review](/2017/10/parallel-postgis-2.html) of PostgreSQL parallelism, was that **the cost of functions executed on rows returned by queries do not get included in evaluations of the cost of a plan**.

So for example, the planner appeared to consider these two queries equivalent:

{% highlight sql %}
SELECT *
FROM pd;

SELECT ST_Area(geom)
FROM pd;
{% endhighlight %}

They both retrieve the same number of rows and both have no filter on them, but the second one includes a fairly expensive function evaluation. No amount of changing the cost of the `ST_Area()` function would cause a parallel plan to materialize. Only changing the size of the table (making it bigger) would flip the plan into parallel mode.

Fortunately, when I [raised this issue](https://www.postgresql.org/message-id/CACowWR2Qy-7rODmnjnu-jzwjtz4WRtPf9f1fKCB9vDEJE23FhQ%40mail.gmail.com) on *pgsql-hackers*, it turned out to have been reported and discussed last month, and [Amit Kapila](https://www.enterprisedb.com/amit-kapila) had already prepared a patch, which [he kindly rebased for me](https://www.postgresql.org/message-id/CAA4eK1%2B1H5Urm0_Wp-n5XszdLX1YXBqS_zW0f-vvWKwdh3eCJA%40mail.gmail.com).

With the patch in place, I now see rational behavior from the planner. Using the default PostGIS function costs, a simple area calculation on my 60K row polling division table is sequential:

{% highlight sql %}
EXPLAIN
SELECT ST_Area(geom)
FROM pd;
{% endhighlight %}

    Seq Scan on pd  
    (cost=0.00..14445.17 rows=69534 width=8)

However, if the `ST_Area()` function is costed a little more realistically, the plan shifts.

{% highlight sql %}
ALTER FUNCTION ST_Area(geometry) COST 100;

EXPLAIN
SELECT ST_Area(geom)
FROM pd;
{% endhighlight %}

     Gather  
     (cost=1000.00..27361.20 rows=69534 width=8)
       Workers Planned: 3
       ->  Parallel Seq Scan on pd  
           (cost=0.00..19407.80 rows=22430 width=8)

Perfect!

While not every query receives what I consider a "perfect plan", it now appears that we at least have some reasonable levers available to get better plans via applying some sensible (higher) costs across the PostGIS code base.

