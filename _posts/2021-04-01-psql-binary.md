---
layout: post
title: 'Dumping a ByteA with psql'
date: '2021-04-01T00:00:00-08:00'
author: Paul Ramsey
category: technology
tags:
- postgis
- postgresql
- psql
comments: True
image: "2021/rastergrid.png"
---

Sometimes you just have to work with binary in your PostgreSQL database, and when you do the [bytea](https://www.postgresql.org/docs/current/datatype-binary.html) type is what you'll be using. There's all kinds of reason to work with `bytea`:

* You're literally storing binary things in columns, like image thumbnails.
* You're creating a binary output, like an image, a song, a protobuf, or a LIDAR file.
* You're using a binary transit format between two types, so they can interoperate without having to link to each others internal format functions. (This is my favourite trick for creating a library with optional PostGIS integration, like [ogr_fdw](https://github.com/pramsey/pgsql-ogr-fdw).)

Today I was doing some debugging on the PostGIS raster code, testing out a new function for interpolating a grid surface from a non-uniform set of points, and I needed to be able to easily see what the raster looked like.

![Interpolated raster surface grid]({{ site.images }}/2021/rastergrid.png)

There's [a function](http://postgis.net/docs/RT_ST_AsGDALRaster.html) to turn a PostGIS raster into a GDAL image format, so I could create image **data** right in the database, but in order to actually **see** the image, I needed to save it out as a file. How to do that without writing a custom program? Easy! (haha)

Basic steps:

* Pipe the query of interest into the database
* Access the image/music/whatever as a `bytea` 
* Convert that bytea to a hex string using `encode()`
* Ensure psql is not wrapping the return in any extra cruft
* Pipe the hex return value into `xxd`
* Redirect into final output file

Here's what it would look like if I was storing PNG thumbnails in my database and wanted to see one:

```
echo "SELECT encode(thumbnail, 'hex') FROM persons WHERE id = 12345" \
  | psql --quiet --tuples-only -d dbname \
  | xxd -r -p \
  > thumbnail.png
```

Any `bytea` output can be pushed through this chain, here's what I was using to debug my `ST_GDALGrid()` function.

```
echo "SELECT encode(ST_AsGDALRaster(ST_GDALGrid('MULTIPOINT(10.5 9.5 1000, 11.5 8.5 1000, 10.5 8.5 500, 11.5 9.5 500)'::geometry, ST_AddBand(ST_MakeEmptyRaster(200, 400, 10, 10, 0.01, -0.005, 0, 0), '16BSI'), 'invdist' ), 'GTiff'), 'hex')" \
  | psql --quiet --tuples-only grid \
  | xxd -r -p \
  > testgrid.tif 
```

