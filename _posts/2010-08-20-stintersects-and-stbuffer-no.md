---
layout: post
title: 'ST_Intersects and ST_Buffer: No'
date: '2010-08-20T16:28:00.001-07:00'
author: Paul Ramsey
tags: 
modified_time: '2010-08-20T16:30:26.568-07:00'
blogger_id: tag:blogger.com,1999:blog-14903426.post-8314527770532707174
blogger_orig_url: http://blog.cleverelephant.ca/2010/08/stintersects-and-stbuffer-no.html
comments: True
---

If you find yourself writing a query like this:

<code>... WHERE ST_Intersects(ST_Buffer(g1, r), g2)</code>

Stop. Take a cleansing breath. Do this:

<code>... WHERE ST_DWithin(g1, g2, r)</code>

With the carbon emissions you save doing it the efficient way, you can afford to drive to the ice cream store for a well-deserved reward.

