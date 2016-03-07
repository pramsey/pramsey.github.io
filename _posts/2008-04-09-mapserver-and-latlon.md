---
layout: post
title: Mapserver and Lat/Lon
date: '2008-04-09T10:50:00.000-07:00'
author: Paul Ramsey
tags: 
modified_time: '2008-04-09T11:28:05.670-07:00'
blogger_id: tag:blogger.com,1999:blog-14903426.post-5771292007307825940
blogger_orig_url: http://blog.cleverelephant.ca/2008/04/mapserver-and-latlon.html
---

One of the problems with open source is how much interesting stuff hides beneath the surface, only visible to those willing to read the source code... interesting features you do not even know are there!

On the bright side, you can find these Easter Eggs, if you look.

For example, today I found a case where Mapserver [renders projected maps](http://trac.osgeo.org/mapserver/browser/trunk/mapserver/mapserv.c#L395) even when the extents you send in are in lon/lat!

My map file looks like this (note the output projection is defined as Mercator):

    MAP
      SHAPEPATH "/Users/pramsey/Code/mapserver/msworldtest/"
      IMAGETYPE GIF
      PROJECTION
        "proj=merc"
      END
      LAYER
        NAME continent
        PROJECTION
          "init=epsg:4326"
        END
        TYPE POLYGON
        DATA continent
        STATUS DEFAULT
        CLASS
          OUTLINECOLOR 10 10 10
          COLOR 200 200 200
        END
      END 
    END
     
My request URL looks like this (note the mapext coordinates are lon/lat):

`http://localhost/cgi-bin/mapserv?map=~/Code/mapserver/msworldtest/reproj.map&mode=map&layers=continent&mapext=-90+45+0+80&imgsize=500+250`

And the output looks like this:

<img src="http://farm3.static.flickr.com/2103/2401566964_f2e8aaa472_o_d.gif" />

So my request was in geographic coordinates, but my output was still in Mercator.

This is, of course, a brutal bug-in-waiting for someone with a projected coordinate system that happens to include valid requests in the range of (-180,-90 180,90).  Mercator does, but a 180x180 meter patch of the Atlantic ocean will probable never be zoomed in on &ndash; if it is, the user will suddenly see the whole world, to their great surprise.