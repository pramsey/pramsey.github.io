---
layout: post
title: GeoTiff Compression for Dummies
date: '2015-02-19T10:38:00.000-08:00'
author: Paul Ramsey
category: technology
tags:
- gis
- imagery
- jpeg
- geotiff
- gdal
modified_time: '2015-02-19T10:40:45.310-08:00'
thumbnail: http://2.bp.blogspot.com/-ViYOsz3kMUY/VOYqHnXIlDI/AAAAAAAAAdU/0OGl8u9TmMs/s72-c/example_jpg.png
blogger_id: tag:blogger.com,1999:blog-14903426.post-7372174568774204581
blogger_orig_url: http://blog.cleverelephant.ca/2015/02/geotiff-compression-for-dummies.html
comments: True
---

"What's the best image format for map serving?" they ask me, shortly after I tell them not to serve their images from inside a database. 

"Is it MrSid? Or ECW? those are nice and small." Which indeed they are. Unfortunately, outside of proprietary image server software I've never seen them be **fast** and nice and small at the same time. Generally the decode step is incredibly CPU intensive, presumably because of the fancy wavelet math that makes them so small in the first place.

"So, what's the best image format for map serving?".

In my experience, the best format for image serving, using open source rendering engines (MapServer, GeoServer, Mapnik) is: **GeoTIFF, with JPEG compression, internally tiled, in the YCBCR color space, with internal overviews**. Unfortunately, GeoTiffs are almost never delivered this way, as I was reminded today while downloading a sample image from the [City of Kamloops](http://www.kamloops.ca/maps/disclaimer.html) (But nonetheless, thanks for the great free imagery, Kamloops!)

    5255C.zip [593M]

It came in a 593Mb ZIP file. "Hm, that's pretty big, I thought." I unzipped it.

    5255C.tif [515M]

Unzipped it was a 515Mb TIF file. That's right, it was smaller "uncompressed". Why? Because internally it was already compressed, and applying the ZIP compression algorithm to already compressed data generally fluffs it up a little. Whoops.

The default TIFF compression is, unfortunately, "[deflate](http://en.wikipedia.org/wiki/Huffman_coding)", the same as that used for ZIP. This is a lossless encoding, but not very good for imagery. We can make the image a whole lot smaller just by using a more appropriate compression, like JPEG. We'll also tile it internally while we're at it. Internal tiling allows renderers to quickly pick out and decompress just a small portion of the image, which is important once you've applied a more serious compression algorithm like JPEG.

    gdal_translate \
      -co COMPRESS=JPEG \
      -co TILED=YES \
      5255C.tif 5255C_JPEG.tif
      
This is much better, now we have a vastly smaller file.

    5255C_JPEG.tif [67M]

But we can still do better! For reasons that well pass my understanding, the JPEG algorithm is more effective against images that are stored in the [YCBCR](http://en.wikipedia.org/wiki/YCbCr) color space. Mine is not to reason why, though.

    gdal_translate \
      -co COMPRESS=JPEG \
      -co PHOTOMETRIC=YCBCR \
      -co TILED=YES \
      5255C.tif 5255C_JPEG_YCBCR.tif
      
Wow, now we're down to 1/20 the size of the original.

    5255C_JPEG_YCBCR.tif [24M]

But, we've applied a "lossy" algorithm, JPEG, maybe we've ruined the data! Let's have a look.

<table border="0"><tr><td><a href="http://2.bp.blogspot.com/-ViYOsz3kMUY/VOYqHnXIlDI/AAAAAAAAAdU/0OGl8u9TmMs/s1600/example_jpg.png" imageanchor="1" ><img border="0" height="300" src="http://2.bp.blogspot.com/-ViYOsz3kMUY/VOYqHnXIlDI/AAAAAAAAAdU/0OGl8u9TmMs/s1600/example_jpg.png" /></a></td><td><a href="http://4.bp.blogspot.com/-EqVHMQXxWy0/VOYqH15vBaI/AAAAAAAAAdY/XS5ffZl1mME/s1600/example_lzw.png" imageanchor="1" ><img border="0" height="300" src="http://4.bp.blogspot.com/-EqVHMQXxWy0/VOYqH15vBaI/AAAAAAAAAdY/XS5ffZl1mME/s1600/example_lzw.png" /></a></td></tr><tr><th>Original</th><th>After JPEG/YCBCR</th></tr></table>

Can you see the difference? Me neither. Using a JPEG "quality" level of 75%, there are no visible artefacts. In general, JPEG is very good at compressing things so humans "can't see" the lost information. I'd never use it for compressing a DEM or a data raster, but for a visual image, I use JPEG with impunity, and with much lower quality settings too (for more space saved).

Finally, for high speed serving at more zoomed out scales, we need to add overviews to the image. We'll make sure the overviews use the same, high compression options as the base data.

    gdaladdo \
      --config COMPRESS_OVERVIEW JPEG \
      --config PHOTOMETRIC_OVERVIEW YCBCR \
      --config INTERLEAVE_OVERVIEW PIXEL \
      -r average \
      5255C_JPEG_YCBCR.tif \
      2 4 8 16
      
For reasons passing understanding, `gdaladdo` uses a different set of command-line switches to pass the configuration info to the compressor than `gdal_translate` does, but as before, mine is not to reason why.

The final size, now **with** overviews as well as the original data, is still less that 1/10 the size of the original.

    5255C_JPEG_YCBCR.tif [37M]

So, to sum up, your best format for image serving is:

* GeoTiff, so you can avoid proprietary image formats and nonsense, with
* JPEG compression, for visually fine results with much space savings, and
* YCBCR color, for even smaller size, and
* internal tiling, for fast access of random squares of data, and
* overviews, for fast access of zoomed out views of the data.

Go forth and compress!