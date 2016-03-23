---
layout: post
title: Proprietary Companies and Open Source
date: '2007-09-19T16:05:00.000-07:00'
author: Paul Ramsey
tags: 
modified_time: '2007-09-19T16:16:20.782-07:00'
blogger_id: tag:blogger.com,1999:blog-14903426.post-2490126507870690259
blogger_orig_url: http://blog.cleverelephant.ca/2007/09/proprietary-companies-and-open-source.html
comments: True
---

Dale Lutz, the VP R&D of [Safe Software](http://www.safe.com/) has a [very thoughtful piece](http://spatial-etl.blogspot.com/2007/09/looking-forward-to-foss4g-2007.html) on what they are going to be showing at [FOSS4G 2007](http://2007.foss4g.org/), and how Safe fits into the open source world as a company that makes its money selling proprietary software.

I think Safe Software is a great example of how proprietary companies can gain from involvement in open source and from adopting an "open source mentality" of frequent releases and frank and honest conversations with customers about technology (and its occasional drawbacks).

One of the things I find particularly interesting about Safe is that they directly fund development of the [GDAL](http://www.gdal.org/) project, which includes the "OGR" vector file format library.  The [OGR2OGR](http://www.gdal.org/ogr/ogr2ogr.html) tool in that library has core functionality (file format translation) that overlaps what Safe's FME does.  A less self-aware company would feel a great deal of worry about having any involvement with an open source project that contains the seeds of a direct competitor.  But Safe has enough internal self-regard to recognize that the population of people in the market for a polished product like FME does not really intersect with the population of people satisfied with a simple tool like OGR2OGR.  OGR2OGR is only a theoretical competitive threat; in practice it is nothing of the kind.

Full disclosure, Safe has also provided direct funding on two occasions to the development of the [GEOS](http://trac.osgeo.org/geos/) geometry operation library, which now ships (along with GDAL and other open source libraries) in the FME product.