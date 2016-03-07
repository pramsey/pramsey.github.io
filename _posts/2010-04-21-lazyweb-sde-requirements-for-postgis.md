---
layout: post
title: 'Lazyweb: SDE requirements for PostGIS'
date: '2010-04-21T08:41:00.000-07:00'
author: Paul Ramsey
tags: 
modified_time: '2010-04-22T10:04:12.700-07:00'
blogger_id: tag:blogger.com,1999:blog-14903426.post-4614297955773861368
blogger_orig_url: http://blog.cleverelephant.ca/2010/04/lazyweb-sde-requirements-for-postgis.html
---

Oh, lazyweb, I beseach thee!

Can you tell me, for each version of ArcSDE, what version(s) of PostGIS is/are supported? I'm at the [Washington GIS](http://www.waurisa.org/conferences/2010_Conference_Index.html) conference, and folks are using SDE on PostGIS, and some of them are using old versions of PostGIS, so I need to know how far back we have to apply patches in order to fully support users who have deployed SDE on PostGIS.

**Update:** The lazyweb responds, with [ArcSDE 10 requirements](http://resources.arcgis.com/content/arcsde-postgresql-database-requirements), [ArcSDE 9.3.x requirements](http://wikis.esri.com/wiki/display/ag93bsr/ArcSDE+PostgreSQL+Database+Requirements) and recap: PostGIS 1.4.0 for ArcSDE 10, PostGIS 1.3.2 for ArcSDE 9.3/9.3.1

Also, from Cort Daniel of Pierce County I hear that minor releases as late as PostGIS 1.3.7 and PostgreSQL 8.3.5 work (unofficially) for ArcSDE 9.3.

**Update2:** Cort also said that while PostgreSQL 8.3.5 worked with ArcSDE 9.3, 8.3.7 did not (date fields stopped working right), which is really really odd. Not sure if anyone else could confirm that.

