---
layout: post
title: 'Boston Code Sprint: PostGIS'
date: '2013-03-26T07:56:00.000-07:00'
author: Paul Ramsey
tags:
- postgis
- osgeo
- opengeo
- sprint
modified_time: '2013-03-28T15:13:24.004-07:00'
blogger_id: tag:blogger.com,1999:blog-14903426.post-5860776525763295711
blogger_orig_url: http://blog.cleverelephant.ca/2013/03/boston-code-sprint-postgis.html
comments: True
---

Rather than try and do a day-by-day take on the sprint, this year I'll try to outline project-by-project what folks are hoping to accomplish and who is attending.

This year we have the largest contingent of PostGIS folks ever, and work is being done on old-school PostGIS as well as the raster and geocoding portions that I usually look in with a bit of fear and trembling.

[Azavea](http://www.azavea.com/) has sent four staff to the sprint. David Zwarg has worked on PostGIS raster at previous sprints and is continuing the tradition this year, focussing on building raster overviews inside the database.  Justin Walgran is updating GDAL to do EPSG code determination for arbitrary WKT strings. Adam Hinz is returning 1.5 semantics to some OGC geometry functions, and exploring SP-GiST implementation for PostGIS. And Kenny Shepard is adding geometry validity checking and policy enforcement to the shape loader utilities. **Update:** And, Rob Emanuele, who worked on QGIS support for PostGIS raster and the GDAL QGIS plug-in. Thank him, QGIS users!

Regina Obe has been working with Steven Woodbridge on an upgrade to the TIGER GeoCoder, integrating a C module for address normalization and a flatter scheme for storing address information. Early tests have shown this new approach to be much faster than the old PL/PgSQL code, which should make all the bulk geocoders out there very happy.

Stephen Mather is working on polygon skeletonization, to convert lakes and roads to linear equivalent features.

[Oslandia](http://www.azavea.com/) has sent two representatives. Olivier Courtin and Hugo Mercier are working on SFCGAL, a C library wrapper around the C++ CGAL computational geometry library. SFCGAL will bridge PostGIS to use the CGAL 3D geometry algorithms, as well as algorithms like line voronoi generation, which will be useful for Stephen's skeleton project.

The two heavyweights of the PostGIS raster world, Pierre Racine and Bborie Park are here. Bborie is improving the performance of expression-based map algebra functions.  Always pushing the leading edge, Pierre Racine is coordinating the raster work, and collecting up new functional routines in PL/PgSQL into a library of utilities.

I'm spending time fixing my bugs in the 2.1 milestone, completing distance calculation for curved geometry types, and on the new [pointcloud](https://github.com/pramsey/pointcloud) extension for LIDAR storage in PostgreSQL.

