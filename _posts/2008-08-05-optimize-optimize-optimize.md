---
layout: post
title: Optimize, Optimize, Optimize!
date: '2008-08-05T14:02:00.001-07:00'
author: Paul Ramsey
tags: 
modified_time: '2008-08-05T14:20:14.117-07:00'
blogger_id: tag:blogger.com,1999:blog-14903426.post-7675389459727921047
blogger_orig_url: http://blog.cleverelephant.ca/2008/08/optimize-optimize-optimize.html
comments: True
---

I have been trying to squeeze every last erg of performance into a Mapserver installation for a client. Their workload is very raster-based, pulling from JPEG-compressed, internally-tiled TIFF files. We found one installation mistake, which was good for a big performance boost (do not fill your directories with too many files, or the operating system will spend all its time doing file searching).  But once that was identified, only the raster algorithms themselves were left to be optimized.

Firing up the [Shark](http://developer.apple.com/tools/shark_optimize.html), my new favorite tool, I found that the cycles were being spent about 60% in the JPEG decompression and 30% in the Mapserver average re-sampling.  Decompressing the files did make things faster, but at a 10x file size penalty &ndash; unacceptable.  Removing the average re-sampling did make things faster, but with very visible aesthetic penalty &ndash; unacceptable.

Using two tools from Intel, I have been able to cut about 40% off of the render time, without changing any code at all!

<img src="http://images.apple.com/uk/intel/images/intel_logo20060109.gif" style="padding:10px;float:right;">First, Intel publishes the &ldquo;[Integrated Performance Primitives](http://www.intel.com/cd/software/products/asmo-na/eng/302910.htm)&rdquo;, basically a big catch-all library of multi-media and mathematics routines, built to take maximum advantage of the extended instruction sets in modern CPUs.  Things like [SSE](http://en.wikipedia.org/wiki/Streaming_SIMD_Extensions), [SSE2](http://en.wikipedia.org/wiki/SSE2), [SSE3](http://en.wikipedia.org/wiki/SSE3), [SSE4](http://en.wikipedia.org/wiki/SSE4) and so on.

Ordinarily, this would only be of use if I had a couple weeks to examine the code and fit the primitives into the existing code base. Fortunately for me, one of the example programs Intel ships with IPP is "ijg", a port of the [Independent JPEG Group](http://www.ijg.org/) reference library that uses IPP acceleration wherever possible.  So I could simply compile the "ijg" library and slip it into place instead of the standard "libjpeg".

Second, Intel also publishes their own [C/C++ compiler](http://www.intel.com/cd/software/products/asmo-na/eng/compilers/284132.htm), "icc", which uses a deep understanding of the x86 architecture and the extensions referenced above to produced optimized code.  I used "icc" to compile both Mapserver and GDAL, and saw performance improve noticeably.

So, amazingly, between simply re-compiling the software with "icc" and using the "ijg" replacement library to speed up the JPEG decompression, I've managed to extract about 40% in performance, without touching the code of Mapserver, GDAL, or LibJPEG at all.

