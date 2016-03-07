---
layout: post
title: Intel IJG and Image Artefacts
date: '2008-09-22T11:54:00.000-07:00'
author: Paul Ramsey
tags: 
modified_time: '2008-09-22T12:31:43.332-07:00'
blogger_id: tag:blogger.com,1999:blog-14903426.post-9150658269715668614
blogger_orig_url: http://blog.cleverelephant.ca/2008/09/intel-ijg-and-image-artefacts.html
---

I [wrote previously](http://blog.cleverelephant.ca/2008/08/optimize-optimize-optimize.html) about how using the Intel &ldquo;Integrated Performance Primitives&rdquo; ([IPP](http://www.intel.com/cd/software/products/asmo-na/eng/302910.htm)) and the Intel compiler (ICC) helped to improve performance in a Mapserver raster rendering system by about 40%.

I was feeling pretty proud, until the client pointed out that the outputs, while *fast* were, um, sort of wrong:

[<img src="http://www.cleverelephant.ca/ipp_err_gd_sm.jpg">](http://www.cleverelephant.ca/ipp_err_gd.jpg)

What was going on here?!

Well, the problem looked to be in the JPEG writing, and Mapserver writes its JPEG via libgd by default, so I looked at the JPEG code in libgd for clues. There was little to find. LibJPEG is provides a very simple interface to writing out images, and the code in GD (gd_jpeg.c) was identical to the sample image compression code in the Intel IJG code base (cjpeg.c).

I only had two clues to go on: first, the artefacts would go away, if we created the JPEGs in a &ldquo;progressive&rdquo; (interlaced) mode; second, the Intel cjpeg utility could create correct JPEGs in non-interlaced mode. 

After taking a brain-break of a couple days, I found the problem while grepping the code and watching TV. Setting up a JPEG compressor requires that you provide the compressor with a buffer-fill function of your own design, so you can provide input from all kinds of sources. The implementation of the buffer-fill routine in the Intel example code had a switch in it, that checked if the mode was progressive or not!

In the case of non-progressive JPEG, the Intel function would allow the compressor to only partially read the buffer if it wanted. Then it would move the un-read bytes to the front of the buffer, and fill in the rest with new bytes. The standard JPEG library expects the compressor to *always* read the *full* buffer.

Patching GD to use this partial buffer logic, and JPEG compression worked, I was getting what looked like good ouputs! So, I put the patch in place and told the client and, um, there were still problems:

[<img src="http://www.cleverelephant.ca/ipp_err_gdal_sm.jpg">](http://www.cleverelephant.ca/ipp_err_gdal.jpg)

Gah! The artefacts were smaller, but they were still there. However, having my previous solution in hand, it was easy to find this bug. The artefacts were in a nice blocky patterns, just like the internal TIFF tile structure, which pointed to the JPEG *decompressor* having the same buffer behavior as the compressor.

So this time I opened up the GDAL library (that Mapserver uses to read the TIFFs) and found the JPEG reading code in the TIFF driver. Sure enough, the Intel decompressor only partially read the buffer, while the standard decompressor was expected to read the whole thing every time.  

A small patch to the GDAL TIFF driver, and another patch to the GDAL JPEG driver (for completeness) and now we finally had IPP-accellerated JPEG input and output without artefacts.

**Moral of the story:** Although the Intel IJG is API-compatible with the standard libjpeg, the slightly different expected behavior of the <code>empty_output_buffer</code> and <code>fill_input_buffer</code> functions means that most existing code will require slight modifications before it can use the Intel libraries &ndash; they cannot just be dropped into place as a binary-only update.

