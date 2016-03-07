---
layout: post
title: FastCGI Hint
date: '2009-03-04T16:56:00.000-08:00'
author: Paul Ramsey
tags: 
modified_time: '2009-03-04T17:02:12.973-08:00'
blogger_id: tag:blogger.com,1999:blog-14903426.post-3010336674004349610
blogger_orig_url: http://blog.cleverelephant.ca/2009/03/fastcgi-hint.html
---

I'm preparing to benchmark / profile Mapserver and PostGIS for the upcoming [code sprint in Toronto](http://wiki.osgeo.org/wiki/Toronto_Code_Sprint_2009), and setting up Mapserver as a FastCGI is a requirement to get good profiling results.  The JMeter bench marks run multiple threads of load, so having multiple Mapservers running makes things faster.  

However, trying to get "FastCgiConfig" to dynamically spawn the required instances was a real pain. Setting the "updateInterval" nice and low made extra Mapserver processes come online a little faster, but in a kind of chunky way. It seemed to kill the existing process before flipping on the new ones.  The config line looked like this:

<code>FastCgiConfig -appConnTimeout 60 -idle-timeout 60 -init-start-delay 0 -minProcesses 2 -maxClassProcesses 6 -startDelay 5 -restart-delay 1 -killInterval 30 -singleThreshold 5 -updateInterval 1</code>

In the end, I opted to just statically start the number of processes that made sense for my dual core system (4, in my estimation) using the "FastCgiServer" directive. The config line is a blissfully simple:

<code>FastCgiServer /Users/pramsey/Sites/cgi-bin/mapserv.fcgi -processes 4</code>

Throughput for simple tests (style-free roads from PostGIS, 4 threads of execution) is running as high as 48 maps per second.

