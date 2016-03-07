---
layout: post
title: MySQL Snark
date: '2009-06-12T16:41:00.000-07:00'
author: Paul Ramsey
tags: 
modified_time: '2009-06-12T17:17:10.008-07:00'
blogger_id: tag:blogger.com,1999:blog-14903426.post-3155358604779502534
blogger_orig_url: http://blog.cleverelephant.ca/2009/06/mysql-snark.html
---

OK, this one I have to share. Here's two queries, the first with a syntax error in the WKT (oops!) and the second one correct. 

First, as processed by MySQL:

<pre>mysql> select count(*) from tiger_roads_texas <br />  where mbrintersects(geom, <br />    GeomFromText('LINESTRING(452284 -1651542, 452484 -1651342'));<br />+----------+<br />| count(*) |<br />+----------+<br />|        0 | <br />+----------+<br />1 row in set (0.00 sec)

mysql> select count(*) from tiger_roads_texas <br />  where mbrintersects(geom, <br />    GeomFromText('LINESTRING(452284 -1651542, 452484 -1651342)'));<br />+----------+<br />| count(*) |<br />+----------+<br />|        1 | <br />+----------+<br />1 row in set (0.06 sec)</pre>

Now as processed by PostGIS:

<pre>tiger=# select count(*) from tiger_roads_texas <br />where geom && <br />  GeomFromText('LINESTRING(452284 -1651542, 452484 -1651342',2163);<br />ERROR:  parse error - invalid geometry<br />HINT:  "...RING(452284 -1651542, 452484 -1651342" <-- parse error at position 43 within geometry<br />CONTEXT:  SQL function "geomfromtext" statement 1

tiger=# select count(*) from tiger_roads_texas <br />  where geom && <br />    GeomFromText('LINESTRING(452284 -1651542, 452484 -1651342)',2163);<br /> count <br />-------<br />     1<br />(1 row)</pre>

Can you spot the difference? Snark! Another one for [the list](http://sql-info.de/mysql/gotchas.html).

