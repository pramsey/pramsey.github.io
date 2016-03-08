---
layout: post
title: 'Timmy''s Telethon #6'
date: '2008-02-21T15:43:00.000-08:00'
author: Paul Ramsey
tags: 
modified_time: '2008-02-22T12:36:46.136-08:00'
blogger_id: tag:blogger.com,1999:blog-14903426.post-7476086190684948945
blogger_orig_url: http://blog.cleverelephant.ca/2008/02/timmys-telethon-6.html
comments: True
---

And *finalement*:

> 6. Third party business applications: It could be argued that an enterprise GIS exist to support business requirements which often call for a third party client solution. Are vendors building COTs apps against these third party solutions?

I think the wording is a little off here, and it should be "are vendors building third party COTS solutions against these open source apps?"

And the answer is "sure!"  Not as many as against the ESRI stack, but that is to be expected: [ISV](http://en.wikipedia.org/wiki/Independent_software_vendor)s support things where there is demand for support, and the market leader obviously drives a lot more demand.  However, the amount of ISV support for open source is greater than zero, and growing. On the PostGIS side, for example:

* Safe Software's FME supports it
* Mapguide supports it
* Ionic Red Spider supports it
* ESRI's Interoperability Extension supports it
* Manifold supports it (!!!)
* CadCorp SIS supports it
* ArcSDE 9.3 supports it
* MapDotNet Server supports it
    
Most of the web-services side of things are supported via open standards, so Mapserver slots into all kinds of infrastructures and third party tools via the WMS standard, for example.  I imagine if the WMS standard did not exist, more software would talk directly to Mapserver via it's own CGI dialect, but WMS made that redundant.

And on the client side, I found this nugget from Bill Dollins' ESRI Fed UC [review](http://geobabble.wordpress.com/2008/02/20/more-from-the-feduc-plenary/) intriguing:

> So the take away was “we’ve got the server to crunch your data and give you good analysis results, display it any way you want.” There was no OpenLayers demo but it was mentioned several times and something that should be able to leverage new APIs.

In the open source world, OpenLayers is already the "default map component" for web apps, it is interesting to see it already banging on the doors to the proprietary world as well.