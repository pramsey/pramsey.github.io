---
layout: post
title: Everybody Loves Metadata
date: '2007-04-23T13:07:00.000-07:00'
author: Paul Ramsey
tags: 
modified_time: '2007-04-23T13:28:39.194-07:00'
blogger_id: tag:blogger.com,1999:blog-14903426.post-5403418659207894450
blogger_orig_url: http://blog.cleverelephant.ca/2007/04/everyone-loves-metadata.html
comments: True
---

Or, more precisely, everybody loves &lt;Metadata&gt;.

Hardly is [KML](http://earth.google.com/kml/) into the [OGC](http://www.opengeospatial.org/) standards process and already folks are getting ready to standardize what goes into the anonymous &lt;Metadata&gt; block.

[Ron Lake](http://www.galdosinc.com/archives/category/media-center/blog) thinks that ... wait for it ... wait for it ... [GML would be an "ideal" encoding](http://www.galdosinc.com/archives/308) to use in &lt;Metadata&gt;. 

Chris Goad at [Platial](http://platial.com/) thinks that we should be [doing content attribution](http://platial.typepad.com/news/2007/04/best_practices_.html) (who made this, who owns this) in &lt;Metadata&gt;.

Even Google is [getting into the game](http://code.google.com/support/bin/answer.py?answer=65628). The explanations of how to integrate your application schema for &lt;Metadata&gt; extensions into the KML schema are a nice reminder of the sort of eye-glazing details that have made life so hard for GML. Doing things right is hard. 

It is particularly delicious that the very thing that makes adding information to &lt;Metadata&gt; fiddly is the preparation of schemas: you need metadata about the metadata you are adding to &lt;Metadata&gt;.

Where will this all end? I think it will end with the Google Team picking one or a few &lt;Metadata&gt; encodings to expose in their user interfaces (Earth and Maps). At that point all content will converge rapidly on that encoding, and the flexibility of &lt;Metadata&gt; will be rapidly ignored.