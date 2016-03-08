---
layout: post
title: ArcSDE comes to PostgreSQL?
date: '2006-08-03T11:24:00.000-07:00'
author: Paul Ramsey
tags: 
modified_time: '2006-10-21T11:22:57.890-07:00'
blogger_id: tag:blogger.com,1999:blog-14903426.post-115463112809083476
blogger_orig_url: http://blog.cleverelephant.ca/2006/08/arcsde-comes-to-postgresql.html
comments: True
---

It has long been rumoured that [ESRI](http://www.esri.com) might move their "database neutral" ArcSDE to the ultimate "neutral database", [PostgreSQL](http://www.postgresql.org).  I have heard versions of this idea since around 2003, but I never thought they would come to pass.  So, mea culpa, all the people I told "it will never happen"... [it has](http://events.esri.com/uc/QandA/index.cfm?ConferenceID=DA494555-C04F-A071-2407CB34C9CB9287&fuseaction=Answer&QuestionID=1515)!

> Yes, ESRI is currently in the process of developing support for PostgreSQL.  We have done all the necessary testing to ensure that this will continue to be a viable product in the future.  We plan to release this capability sometime after ArcGIS 9.2.

So, what does this mean for PostGIS?  Same thing it means for Oracle Spatial -- not very much.  ESRI may, or may not, support using PostGIS native spatial geometries as the geometry type in ArcSDE.  For Oracle, the default ESRI position has always been their SDEBINARY performs better than SDO_GEOMETRY, so it does not sound like using native types holds any particular allure for ESRI.

Even if ArcSDE does support PostGIS types, the ArcSDE versioning model means that all changes to the geometries will have to be done through the SDE API, in order to ensure the versioning metadata remains consistent.

Still, from a read-only perspective, if ArcSDE does support PostGIS as a geometry type, then the following architecture becomes possible, which could represent a big opportunity for some jurisdictions:

* (DBMS) PostgreSQL Database
* (ESRI Pound of Flesh) ArcSDE for PostgreSQL using PostGIS geometries
* (Desktop Editing / Cartography) ArcGIS
* (Desktop Viewing) QGIS
* (Analysis Engine) GRASS
* (Web Map Publishing) Mapserver
* (Web Feature Publishing) Geoserver

If, on the other hand, ArcSDE on PostgreSQL only supports SDEBINARY, then this will be a non-event from an open source interoperability point of view.  I look forward to hearing some reports from the ESRI UC -- someone button-hole those ArcSDE developers and find out what the plan is!