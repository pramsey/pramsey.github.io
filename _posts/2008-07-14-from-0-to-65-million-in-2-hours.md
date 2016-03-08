---
layout: post
title: From 0 to 65 Million in 2 Hours
date: '2008-07-14T11:56:00.000-07:00'
author: Paul Ramsey
tags: 
modified_time: '2008-07-14T12:36:23.722-07:00'
blogger_id: tag:blogger.com,1999:blog-14903426.post-901222144332124079
blogger_orig_url: http://blog.cleverelephant.ca/2008/07/from-0-to-65-million-in-2-hours.html
comments: True
---

I'm doing some performance benchmarking for a client this week, so getting a big, real test database is a priority.  The USGS TIGER data is one of the largest uniform data sets around, so I've started with that.

I just loaded all the edges, 64,830,691 of them, and it took just under 2 hours!  Fortunately, the 2007 data comes in shape files, and the schemas are identical for each file, so the load script is as simple as this controller:

    find . -name "fe*_edges.zip" -exec ./append_edges.sh {} ';'

And this runner (append_edges.sh):

    unzip $1
    shp2pgsql -W WINDOWS-1252 -D -a -s 4269 \`basename $1 .zip\`.shp fe_edges | psql tiger
    rm fe*edges.*

Note the use of the `-W` parameter, to ensure that the high-bit &ldquo;char&agrave;ct&eacute;rs&rdquo; are handled correctly, and the `-a` parameter, to append the file contents to the table.

