---
layout: post
title: 'Boston Code Sprint: MapServer'
date: '2013-03-28T08:40:00.002-07:00'
author: Paul Ramsey
tags:
- mapserver
- design
- code
- rfc
modified_time: '2013-03-28T08:41:15.313-07:00'
blogger_id: tag:blogger.com,1999:blog-14903426.post-8207234059299181951
blogger_orig_url: http://blog.cleverelephant.ca/2013/03/boston-code-sprint-mapserver.html
comments: True
---

There is a good crowd of MapServer developers here in Boston, too!

Jeff McKenna, Jonas Lund Nielsen, and Sarah Ward have been working hard on the documentation tree. Since the last release "MapServer" hasn't been just MapServer anymore: it also includes MapCache and TinyOWS. The documentation is being reorganized to make the parts of the system clearer, and to make the web site look less like a documentation page.

MapServer *eminance grise* Daniel Morissette spent the first part of the sprint getting familiar with the [new GitHub workflow](https://github.com/mapserver) for working with MapServer. "Overcoming his GitHub fear" in his words.

Thomas Bonfort, the force behind MapServer's migration to git last year, is making another big infrastructural change this year, [migrating the build system from autotools to CMake](http://mapserver.org/development/rfc/ms-rfc-92.html). This should make multi-platform build support a little more transparent.

Steve Lime, the father of MapServer has been writing up [designs for improved expression handling](http://mapserver.org/development/rfc/ms-rfc-91.html), pushing logical expressions all the way down into the database drivers. This will make rendering more efficient, particularly for things like WFS requests, which often include expressions that could be more efficiently evaluated by databases. Steve is also working on a design to [support UTFGrid as an output format](http://mapserver.org/development/rfc/ms-rfc-93.html).

Alan Boudreault has been very busy: adding support for the "DDS" format to GDAL, which means that MapServer can now serve textures directly to [NASA WorldWind](http://worldwind.arc.nasa.gov/features.html); completing support for [on-the-fly generation of contour lines](http://mapserver.org/development/rfc/ms-rfc-85.html) from DEM files; and completing a [design for on-the-fly line smoothing](http://mapserver.org/development/rfc/ms-rfc-94.html).

Stephan Meissl worked on resolving some outstanding bugs with dateline wrapping, and has been tracking down issues related to getting MapServer "officially" certified as an OGC compliant server for WFS, WMS and WCS.

Note that much of the work done by the MapServer crew at the "code sprint" has actually been design work, not code. I think this is really the best way to make use of face-to-face time in projects. Online, design discussions can take weeks and consume 100s of e-mails. Face-to-face, ideas can be hashed out much more effectively, getting to agreed designs in just a few hours.
