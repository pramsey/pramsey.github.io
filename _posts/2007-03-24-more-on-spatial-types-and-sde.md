---
layout: post
title: More on Spatial Types and SDE
date: '2007-03-24T14:33:00.000-07:00'
author: Paul Ramsey
tags: 
modified_time: '2007-03-24T14:59:59.479-07:00'
blogger_id: tag:blogger.com,1999:blog-14903426.post-328876575914837864
blogger_orig_url: http://blog.cleverelephant.ca/2007/03/more-on-spatial-types-and-sde.html
---

In a comment on my [wailing](http://blog.cleverelephant.ca/2007/03/some-good-news-and-some-bad-news.html) regarding ESRI's apparent decision to roll out their own PostgreSQL spatial type alongside general support for PostgreSQL in ArcSDE 9.3, Bruce Bannerman says:

<blockquote>I think that you are reading too much into this.

ESRI provide ArcSDE Geometry Storage options for a number of DBMS. I'm assuming that this will be the same with PostGRES.</blockquote>

No doubt, there are lots of (too many?) geometry options available with ArcSDE already. And a look at how the options are distributed between the various host databases raises some interesting questions:<ul><li>Oracle<ul><li>SDEBINARY (ESRI)<li>SDO_GEOMETRY (Native)<li>ST_GEOMETRY (ESRI)</ul></li><li>DB2<ul><li>SDEBINARY (ESRI)<li>ST_GEOMETRY (Native)</ul></li><li>Informix<ul><li>SDEBINARY (ESRI)<li>ST_GEOMETRY (Native)</ul></li><li>SQL Server<ul><li>SDEBINARY (ESRI)</ul></li><li>PostgreSQL<ul><li>SDEBINARY (ESRI)<li>GEOMETRY (Native)<li>ST_GEOMETRY (ESRI)</ul></ul>Why does ESRI use the native geometry implementations for Informix and DB2 and not provide their own special implementation?  I would posit that the DB2 and Informix implementations, put out by close business partner IBM (and, if I am not misled, implemented in large part by ESRI itself), are perceived as "friendlies". 

Why do they provide a special implementation for Oracle? The Oracle native geometry is controlled by an aggressive corporation with a competitive chip on its shoulder that has been actively hustling to elbow ESRI out of some of its traditional turf.  I had the privilege of being part of a "bake off" a year ago. Me, the local ESRI reps, and an Oracle rep, all gave presentations about the relative merits of our spatial database solutions.  The Oracle presentation was notable in its head-on attack on the many disadvantages of "proprietary middleware" (read, "ArcSDE").  They gave no quarter.  I assume no love is lost on the ESRI side of the fence either.

So, if using the native geometry type is what ESRI does with its friends, and dumping a "special" spatial type in is that they do with their enemies, how is a rational observer to interpret the inclusion of a new PostgreSQL spatial type with the 9.3 ArcSDE PostgreSQL support?

There is no technical reason to do it, that I can see &mdash; PostGIS already supports all the function signatures that the Informix and DB2 spatial implementations do. All that is left is company strategy. Apparently, PostGIS is considered beyond their control and potentially hostile (like Oracle's SDO_GEOMETRY) so they are including a route-around in the form of their own type.

I have contacted the folks at ESRI to try and clear this up, but no response yet. Because PostGIS is open source, there should not be a *need* for a strategic route around us. ESRI can join the community and submit whatever functionality they require, and they don't have to get down on their knees and beg, the way they would with Oracle.