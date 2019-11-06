---
layout: post
title: 'GZip in PostgreSQL'
date: '2019-11-06T00:00:00-08:00'
author: Paul Ramsey
category: technology
tags:
- postgis
- postgresql
- gzip
comments: True
image: "2019/gzip-sm.png"
---

I love PostgreSQL [extensions](https://www.postgresql.org/docs/current/sql-createextension.html). 

Extensions are the truest expression of the second principle of the original "[design of Postgres](https://sfu-db.github.io/dbsystems/Papers/postgres.pdf)" vision, to

> provide user extendibility for data types, operators and access methods.

Extensions allow users to do more with PostgreSQL than just basic storage and retrieval. PostgreSQL is a full-on integration environment, like Python or Perl, and you can build very complete data manipulation pipelines very close to the metal using native and extension features of PostgreSQL.

Even though I'm a contributor to one of the [largest PostgreSQL extensions](http://postgis.net), I have particularly come to love **small** extensions, that do one simple thing, particularly one simple thing we maybe take for granted in other environments.

My old [HTTP extension](https://github.com/pramsey/pgsql-http/) is just a binding of [libcurl](https://curl.haxx.se/libcurl/) to a SQL interface, so users can do web queries inside the SQL environment.

And today I've finished up a [GZIP extension](https://github.com/pramsey/pgsql-gzip/), that is just a binding of [zlib](https://www.zlib.net/) to SQL, so that users can... compress and decompress things.

It's not a lot, but it's a little.

The GZIP entension came about because of [an email](https://lists.osgeo.org/pipermail/postgis-devel/2019-November/028276.html) on the PostGIS development list, where [Yuri](https://twitter.com/nyuriks) noted

> The amazing ST_AsMVT() has two common usage patterns:  copy resulting MVTs to
a tile cache (e.g. .mbtiles file or a materialized view), or serve MVT to
the users (direct SQL->browser approach).  Both patterns still require one
additional data processing step -- gziping.

Huh. And this use case also applies to people generating [GeoJSON](http://geojson.io/) directly [in the database](/2019/08/postgis-3-geojson.html) and sending it out to web clients.

The PostgreSQL core has generally frowned on compression functions at the SQL level, because the database already does compression of over-sized tuples as necessary. The last thing we want is people **manually** applying compression to column values, and then stuffing them into rows where the database will then to **re-compress** them internally. From the perspective of **storage efficiency**, just standing back and letting PostgreSQL do its work is preferable.

But from the perspective of an **integration environment**, where an application might be expected to **emit** or **consume** compressed data, having a tool in SQL to pack and unpack that data is potentially quite useful. 

So I did the tiny binding to [zlib](https://www.zlib.net/) and packed it up in an [extension](https://github.com/pramsey/pgsql-gzip/).

I hope lots of people find it useful.

