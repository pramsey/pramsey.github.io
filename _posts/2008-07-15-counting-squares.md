---
layout: post
title: Counting Squares
date: '2008-07-15T13:28:00.000-07:00'
author: Paul Ramsey
tags: 
modified_time: '2008-07-15T14:23:17.942-07:00'
blogger_id: tag:blogger.com,1999:blog-14903426.post-5396931323803601355
blogger_orig_url: http://blog.cleverelephant.ca/2008/07/counting-squares.html
---

[<img src="http://www.refractions.net/expertise/casestudies/2007-01-hectares-bc/habc_logo_sm.gif" style="float:right; padding:10px; border-width:0px;"/>](http://www.hectaresbc.org)One of the last projects I had a substantial hand in formulating and designing while at [Refractions](http://www.refractions.net/) was a project for providing provincial-level environmental summaries, using the best possible high resolution data. The goal is to be able to answer questions like:

* What is volume of old-growth pine in BC? By timber supply area? In caribou habitat?
* What young forest areas on on south facing slopes of less than 10%, within 200 meters of water?
* What is the volume of fir in areas affected by mountain pine beetle?
* How much bear habitat is more than 5km from a road but not in an existing protected area? Where is it?

This is all standard GIS stuff, but we wanted to make answering these questions the matter of a few mouse gestures, with no data preparation required, so that a suitably motivated environmental scientist or forester could figure out how to do the analysis with almost no training.

Getting there involves solving two problems: what kind of engine can generate fairly complicated summaries based on arbitrary summary areas, and; how do you make that engine maximally usable with minimal interface complexity.

The solution to the engine was double-barreled. 

First, to enable arbitrary summary areas, move from vector analysis units to a province-wide raster grid. For simplicity, we chose one hectare (100m x 100m), which means about 90M cells for all the non-ocean area in the jurisdiction. Second, to enable a roll-up engine on those cells, put all the information into a database, in our case PostgreSQL. Data entering the system is pre-processed, rasterized onto the hectare grid, and then saved in a master table that has one row for each hectare.  At this point, each hectare in the province has over 100 variables associated with it in the system.

<img src="http://www.hectaresbc.org/trac/attachment/wiki/WikiStart/gehabcgrid.jpg?format=raw" alt="An example of the 1-hectare grid">

To provide a usable interface on the engine, we took the best of breed everywhere we could: [Google Web Toolkit](http://code.google.com/webtoolkit/) as the overall UI framework; [OpenLayers](http://www.openlayers.org) as a mapping component; server-side Java and Tomcat for all the application logic. The summary concept was very similar to [OLAP](http://en.wikipedia.org/wiki/Online_analytical_processing) query building, so we stole the ideas for the working of that tab from the SQL Server OLAP query interface.

The final result is [Hectares BC](http://www.hectaresbc.org/), which is one of the cooler things I have been involved in, going from a coffee shop "wouldn't this be useful" discussion to a prototype, to a funding proposal, to the completed pilot in about 24 months.

