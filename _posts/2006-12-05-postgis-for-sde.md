---
layout: post
title: PostGIS for SDE
date: '2006-12-05T11:56:00.000-08:00'
author: Paul Ramsey
tags: 
modified_time: '2006-12-05T12:15:52.313-08:00'
blogger_id: tag:blogger.com,1999:blog-14903426.post-655160632184484746
blogger_orig_url: http://blog.cleverelephant.ca/2006/12/postgis-for-sde.html
comments: True
---

One of the interesting nuggets to come out of the ESRI User Conference this year was the news that ESRI was going to [support ArcSDE on PostgreSQL](http://www.spatiallyadjusted.com/2006/08/03/esri-confirms-postgresql-support-for-arcsde-at-92/) "sometime soon".  Which, to PostGIS people like ourselves suggests the question: "implemented how?"

* One possibility would be basically a cut'n'paste of their existing SQLServer code, with the SQLServer quirks replaced with PostgreSQL quirks, using SDEBINARY as the spatial type.
* Another possibility would be to use the PostGIS spatial objects as the underlying storage mechanism, in the same way ArcSDE supports using SDO_GEOMETRY in Oracle.
* A third possibility would be ESRI implementing their own spatial type in PostgreSQL and then using that.

Sounds strange, doesn't it? Writing a whole new spatial type, when one already exists. Ordinarily I would dismiss the idea -- except that ESRI has **already done it for Oracle!**.

The [ST_GEOMETRY](http://webhelp.esri.com/arcgisdesktop/9.2/index.cfm?TopicName=A_spatial_type_for_Oracle&anchor=ST_Geom) type in ArcSDE 9.1 and up is a native Oracle type (built using the Oracle type-extension mechanism) provided, and recommended, by ESRI for use by ArcSDE.

Why would ESRI do this?  

The cynical explanation (get this out of the way first) is that it helps break the growing Oracle momentum in tools supporting SDO_GEOMETRY, and confuses the marketplace further about what the "right type" to use is in Oracle for spatial work.  

The practical explanation is that ESRI's ST_GEOMETRY for Oracle implements the same semantics and function signatures as the ST_GEOMETRY objects in DB2 and Informix (coincidentally, also implemented in part by ESRI).  This allows ArcSDE to expose a uniform "raw spatial SQL" to clients while still maintaining it's position as the man-in-the-middle of client/server interaction.  Adding ST_GEOMETRY further reinforces the "database neutral" aspect of ArcSDE by allowing spatial SQL without [exposing the differences](http://www.spatialdbadvisor.com/source_code) between the SDO_GEOMETRY function signatures and the ST_GEOMETRY ones.

So where does that leave PostGIS?  *Removing the practical excuses for not using PostGIS as the underlying geometry type as fast as possible.*  We have looked up the function signatures used by ArcSDE and [implemented them](http://lists.osgeo.org/pipermail/postgis-devel/2006-December/002391.html) for the 1.1.7 release.

If anyone on the ArcSDE team reads this and wants to talk about what else is needed to make PostGIS the default geometry type for ArcSDE-on-PostgreSQL, get in touch. We aim to please.