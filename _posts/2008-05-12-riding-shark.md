---
layout: post
title: Riding the Shark
date: '2008-05-12T15:00:00.000-07:00'
author: Paul Ramsey
tags: 
modified_time: '2008-05-12T15:41:56.124-07:00'
thumbnail: http://farm3.static.flickr.com/2011/2487978676_22e0d89fca_t.jpg
blogger_id: tag:blogger.com,1999:blog-14903426.post-343779547289388432
blogger_orig_url: http://blog.cleverelephant.ca/2008/05/riding-shark.html
comments: True
---

My annoyance at learning that OS/X 10.5 [doesn't really support gprof](http://lists.apple.com/archives/PerfOptimization-dev/2006/Apr/msg00014.html) has turned into ecstasy at finding the wholly superior [Shark](http://developer.apple.com/tools/shark_optimize.html) profiler that comes with XCode.

Unlike gprof, Shark doesn't require that you compile with special profiling flags, it can run on unaltered binaries.  In fact, Shark doesn't even require that you run it against any binary in particular! You can run it against everything on your system, then view the profile of any process post-facto.  

I just did a profile of Mapserver running as a FastCGI process, just by running some load against Mapserver and letting Shark collect statistics on all processes at once. Then I pick the mapserv.fcgi process from the sample data, and voila!

[<img src="http://farm3.static.flickr.com/2011/2487978676_22e0d89fca.jpg" width="500" height="467" alt="screenshot_03" />](http://www.flickr.com/photos/92995391@N00/2487978676/" title="screenshot_03 by pwramsey3, on Flickr)

I can see that the most costly small function is longest_match, from the bottom-up view at the top, and that it is called in the image saving routines, in the top-down view at the bottom. Good news, Mapserver is so efficient that the biggest cost is compressing the output image.

Even cooler, I can flip to chart view and see what the CPUs were doing throughout the sample period. The blue spikes are mapserv.fcgi calls.  

[<img src="http://farm3.static.flickr.com/2298/2487954256_90b11f6529.jpg" width="500" height="369" alt="screenshot_04" />](http://www.flickr.com/photos/92995391@N00/2487954256/" title="screenshot_04 by pwramsey3, on Flickr)

Zoom into one of those, and we can see the CPU ticks through one map draw, including the kernel (the red bit) taking a slice out.  End to end, Mapserver is taking about 15ms to draw this particular map.

[<img src="http://farm3.static.flickr.com/2236/2487162561_4f0e05d4e8.jpg" width="500" height="361" alt="foo_01" />](http://www.flickr.com/photos/92995391@N00/2487162561/" title="foo_01 by pwramsey3, on Flickr)

In addition to the "Time Profile" mode I'm showing here, there's also a "Java Time Profile". I wonder if Java developers can make use of this excellent tool too?