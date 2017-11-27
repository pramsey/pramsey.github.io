---
layout: post
title: 'Nested Loop Join with FDW'
date: '2017-11-27T08:00:00-08:00'
author: Paul Ramsey
category: technology
tags:
- fdw
- postgis
- postgresql
comments: True
image: "2017/postgres-fdw.jpg"
---

I have been wondering for a while if Postgres would correctly plan a spatial join over FDW, in which one table was local and one was remote. The specific use case would be "keeping a large pile of data on one side of the link, and joining to it".

Because spatial joins always plan out to a "nested loop" execution, where one table is chosen to drive the loop, and the other to be filtered on the rows from the driver, there's nothing to prevent the kind of remote execution I was looking for.

I set up my favourite spatial join test: BC voting areas against BC electoral districts, with local and remote versions of both tables.

{% highlight sql %}
CREATE EXTENSION postgres_fdw;

-- Loopback foreign server connects back to
-- this same database
CREATE SERVER test
  FOREIGN DATA WRAPPER postgres_fdw
  OPTIONS (
    host '127.0.0.1', 
    dbname 'test', 
    extensions 'postgis'
    );

CREATE USER MAPPING FOR pramsey
        SERVER test
        OPTIONS (user 'pramsey', password '');
        
-- Foreign versions of the local tables        
CREATE FOREIGN TABLE ed_2013_fdw
( 
  gid integer, 
  edname text, 
  edabbr text, 
  geom geometry(MultiPolygon,4326)
) SERVER test 
  OPTIONS (
    table_name 'ed_2013', 
    use_remote_estimate 'true');

CREATE FOREIGN TABLE va_2013_fdw
( 
  gid integer OPTIONS (column_name 'gid'), 
  id text OPTIONS (column_name 'id'),
  vaabbr text OPTIONS (column_name 'vaabbr'), 
  edabbr text OPTIONS (column_name 'edabbr'), 
  geom geometry(MultiPolygon,4326) OPTIONS (column_name 'geom')
) SERVER test 
  OPTIONS (
    table_name 'va_2013', 
    use_remote_estimate 'true');
{% endhighlight %}

The key option here is `use_remote_estimate` set to true. This tells `postgres_fdw` to query the remote server for an estimate of the remote table selectivity, which is then fed into the planner. Without `use_remote_estimate`, PostgreSQL will generate a terrible plan that pulls the contents of the `va_2013_fdw table local before joining. 

With `use_remote_estimate` in place, the plan is just right:

{% highlight sql %}
SELECT count(*), e.edabbr
  FROM ed_2013 e
  JOIN va_2013_fdw v
  ON ST_Intersects(e.geom, v.geom)
  WHERE e.edabbr in ('VTB', 'VTS')
  GROUP BY e.edabbr;
{% endhighlight %}
  
```
GroupAggregate  (cost=241.14..241.21 rows=2 width=12)
 Output: count(*), e.edabbr
 Group Key: e.edabbr
 ->  Sort  (cost=241.14..241.16 rows=6 width=4)
     Output: e.edabbr
     Sort Key: e.edabbr
     ->  Nested Loop  (cost=100.17..241.06 rows=6 width=4)
         Output: e.edabbr
         ->  Seq Scan on public.ed_2013 e  (cost=0.00..22.06 rows=2 width=158496)
             Output: e.gid, e.edname, e.edabbr, e.geom
             Filter: ((e.edabbr)::text = ANY ('{VTB,VTS}'::text[]))
         ->  Foreign Scan on public.va_2013_fdw v  (cost=100.17..109.49 rows=1 width=4236)
             Output: v.gid, v.id, v.vaabbr, v.edabbr, v.geom
             Remote SQL: SELECT geom FROM public.va_2013 WHERE (($1::public.geometry(MultiPolygon,4326) OPERATOR(public.&&) geom)) AND (public._st_intersects($1::public.geometry(MultiPolygon,4326), geom))
```                     

For FDW drivers other than `postgres_fdw` this means there's a benefit to going to the trouble to support the FDW estimation callbacks, though the lack of exposed estimation functions in a lot of back-ends may mean the support will be ugly hacks and hard-coded nonsense. PostgreSQL is pretty unique in exposing fine-grained information about table statistics.

