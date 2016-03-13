---
layout: post
title: 'MySQL Snark #2'
date: '2009-06-12T16:57:00.000-07:00'
author: Paul Ramsey
tags: 
modified_time: '2009-06-12T17:15:14.937-07:00'
blogger_id: tag:blogger.com,1999:blog-14903426.post-7498172526521930161
blogger_orig_url: http://blog.cleverelephant.ca/2009/06/mysql-snark-2.html
comments: True
---

I am doing a little benchmarking as a learning experience with [JMeter](http://jakarta.apache.org/jmeter/) and I will publish the throughput numbers in a few days, after I run the full suite I have developed on the various combinations of concurrency and insert/select ratios.

Because MySQL has so few functions that actually do anything (see the [note here](http://dev.mysql.com/doc/refman/5.1/en/functions-that-test-spatial-relationships-between-geometries.html)) there's not a great deal to test beyond raw performance. The early throughput results seem to indicate it's comparable for simple CRUD on one table, but for anything non-trivial it falls down. 

Here's a basic spatial join: pull 23 roads from a 3.4M row line table and spatially join to a 66K row tract polygons table, calculating the sum of the areas of tract polygons found. There are spatial indexes on both tables.

    mysql> select sum(area(t.geom)) 
    from tiger_roads_texas r, tiger_tracts t 
    where 
      mbrintersects(r.geom, GeomFromText('LINESTRING(453084 -1650742,452384 -1650442)')) 
    and 
      mbrintersects(r.geom,t.geom);

    +-------------------+
    | sum(area(t.geom)) |
    +-------------------+
    |  1260394420.00453 | 
    +-------------------+
    1 row in set (9.43 sec)

And in PostGIS:

    tiger=# select sum(area(t.geom)) 
    from tiger_roads_texas r, tiger_tracts t 
    where r.geom && GeomFromText('LINESTRING(453084 -1650742,452384 -1650442)',2163) 
    and r.geom && t.geom;
    
           sum        
    ------------------
     1260394420.00684
    (1 row)
    
    Time: 5.574 ms</pre>

Those are both "hot cache" results, after running them a couple times each.

