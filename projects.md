---
layout: page
title: Projects
---

I am a project steering committee member or [BDFL](https://en.wikipedia.org/wiki/Benevolent_dictator_for_life) for the following projects.

## [PostGIS](http://postgis.net)

* PostGIS was started under my direction at Refractions Research in 2001, but I didn't start actively working on it as a developer until 2008. Since then, I've re-written the on-disk format, the statistics gathering system, the WKT and WKB parsers, and many other core components. 
  
## [PgPointCloud](http://github.com/pgpointcloud)

* This PostgreSQL extension allows point cloud data (often collected with LIDAR, but not restricted to it) to be stored and filtered inside the database. The core concept is a compressed "patch" of points, which provide 3x compression using simple techniques, and SQL access to the points within via accessor functions.

## [pgsql-ogr-fdw](http://github.com/pramsey/pgsql-ogr-fdw)

* This PostgreSQL [foreign data wrapper](https://wiki.postgresql.org/wiki/Foreign_data_wrappers) extension allows [OGR](http://gdal.org) data sources (and OGR supports access to dozens of formats) to be accessed directly within the database as a table. This makes integration of data from Oracle, SQL Server, FGDB files, WFS servers, and many more possible directly within the database.

## [pgsql-http](http://github.com/pramsey/pgsql-http)

* This PostgreSQL extension allows direct access to HTTP web services using a simple SQL functional interface. Just call `http_get()` or `http_post()` in your SQL query, and data can be pushed and pulled from web services.

## Other Projects

I am also a committer on a number of other geospatial open source projects.

### [MapServer](http://mapserver.org)

* Over the years, I have worked on the PostGIS drivers and on the GDAL format driver for MapServer, as well as specialty projects like supporting XMP metadata embedding.

### [GDAL](http://gdal.org)

* I have contributed substantial work on the [GeoPackage driver](http://www.gdal.org/drv_geopackage.html) and [ESRI-backed FGDB driver](http://www.gdal.org/drv_filegdb.html) to GDAL. 

### [GEOS](http://trac.osgeo.org/geos)

* I arranged the financial backing that brought the GEOS port of JTS into existence in 2003. I have provided minor patches and general guidance to the project as a community member since then.

