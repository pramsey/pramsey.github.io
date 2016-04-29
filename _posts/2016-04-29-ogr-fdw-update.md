---
layout: post
title: 'OGR FDW Update'
date: '2016-04-29T10:00:00-08:00'
modified_time: '2016-04-29T10:00:00-08:00'
author: Paul Ramsey
category: technology
tags:
- gdal
- ogr
- postgis
- postgresql
- join
comments: True
image: "2016/ogrfdwnew.jpg"
---

I've had a productive couple of weeks here, despite the intermittently lovely [weather](http://weather.gc.ca/city/pages/bc-32_metric_e.html) and the beginning of [Little League baseball](http://beaconhilllittleleague.pointstreaksites.com/view/beaconhilllittleleague) season (not coaching, just supporting my pitcher-in-training).

<img src="{{ site.images }}2016/github13.png" alt="13 Days" width="482" height="96" />

The focus of my energies has been a long-awaited (by me) update to the [OGR FDW extension](https://github.com/pramsey/pgsql-ogr-fdw) for PostgreSQL. By binding the multi-format [OGR library](http://gdal.org/1.11/ogr/) into PostgreSQL, we get access to the [many formats supported by OGR](http://www.gdal.org/ogr_formats.html), all with just one piece of extension code.

As usual, the hardest part of the coding was remembering how things worked in the first place! But after getting my head back in the game the new code flowed out and now I can reveal the new improved OGR FDW!

<img src="{{ site.images }}{{ page.image }}" alt="{{ page.title }}" width="502" height="203" />

The new features are:

* Column name mapping between OGR layers and PgSQL tables is now **completely configurable**. The extension will attempt to guess mapping automagically, using names and type consistency, but you can over-ride mappings using the [table-level `column_name` option](https://github.com/pramsey/pgsql-ogr-fdw/blob/85bae98a1e036cc9b46bd2ebd47561d632c8b846/input/file.source#L47-L54).
* Foreign tables are now **updateable**! That means, for OGR sources that support it, you can run `INSERT`, `UPDATE` and `DELETE` commands on your OGR FDW tables and the changes will be applied to the source. 

  * You can control which tables and foreign servers are updateable by setting the `UPDATEABLE` option on the foreign server and foreign table definitions.
  
* **PostgreSQL 9.6** is supported. It's not released yet, but we can now build against it.
* Geometry **type and spatial reference system are propogated** from OGR. If your OGR source defines a geometry type and spatial reference identifier, the FDW tables in PostGIS will now reflect that, for easier integration with your local geometry data.
* **GDAL2 and GDAL1** are supported. Use of GDAL2 syntax has been made the default in the code-base, with mappings back to GDAL1 for compatibility, so the code is now future-ready.
* Regression tests and **continuous integration** are in place, for improved code reliability. Thanks to help from [Even Roualt](https://github.com/rouault), we are now using [Travis-CI](https://travis-ci.org/pramsey/pgsql-ogr-fdw) for integration testing, and I've enabled a growing number of integration tests.

As usual, I'm in debt to [Regina Obe](https://github.com/robe2) for her usual timely feedback and willingness to torture-test very fresh code.

For now, early adopters can get the code by cloning and building the [project master branch](https://github.com/pramsey/pgsql-ogr-fdw), but I will be releasing a numbered version in a week or two when any obvious bugs have been shaken out. 






