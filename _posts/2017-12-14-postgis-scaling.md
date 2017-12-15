---
layout: post
title: 'PostGIS Scaling'
date: '2017-12-14T08:00:00-08:00'
author: Paul Ramsey
category: technology
tags:
- postgis
- scaling
- carto
comments: True
image: "2017/elephant-wings.jpg"
---

Earlier this month I got to speak at the [Spatial Data Science Conference](https://carto.com/spatial-data-conference/) hosted by my employer Carto at our funky warehouse offices in Bushwick, Brooklyn. The topic: [PostGIS scaling](http://s3.cleverelephant.ca/2017-cdb-postgis.pdf). 

<a href="http://s3.cleverelephant.ca/2017-cdb-postgis.pdf" border="0"><img src="{{ site.images }}{{ page.image }}" alt="{{ page.title }}" width="600" height="360" /></a>

Now. 

"Make it go faster" is a hard request to respond to in the generic: what is "it", what are you doing with "it", are you sure that your performance isn't already excellent but you're just too damned demanding?

So, the talk covers a number of routes to better performance: changing up query patterns, adding special PostgreSQL extensions, leaning on new features of PostgreSQL, and just plain old waiting for PostgreSQL to get better. Which it does, every release.

