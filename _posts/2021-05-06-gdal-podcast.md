---
layout: post
title: 'MapScaping Podcast - GDAL'
date: '2021-05-06T00:00:00-08:00'
author: Paul Ramsey
category: technology
tags:
- gdal
- podcast
- open source
comments: True
image: "2020/mic.jpg"
---

Yesterday I talked about all-things-[GDAL](https://gdal.org) (or at least all the things that fit in 30 minutes) with [MapScaping Podcast](https://mapscaping.com/blogs/the-mapscaping-podcast/)'s [Daniel O'Donohue](https://mapscaping.com/pages/about-us). 

* [Apple Podcasts](https://podcasts.apple.com/us/podcast/gdal-geospatial-data-abstraction-library/id1452297085?i=1000520451921)
* [Google Podcasts](https://podcasts.google.com/feed/aHR0cHM6Ly9tYXBzY2FwaW5nLnBvZGJlYW4uY29tL2ZlZWQueG1s/episode/bWFwc2NhcGluZy5wb2RiZWFuLmNvbS84NTZhOTdkMy1mNGRjLTNjZjUtYTgxYi00MWUzYWVmYTFkM2I?sa=X&ved=0CA0QkfYCahcKEwjwoPb8mrXwAhUAAAAAHQAAAAAQAQ)
* [Spotify](https://open.spotify.com/episode/34iPw31bmTe95FjkY5yglD?si=pCL8E38aQB-DCjft0e3kUw)

In the same way that Linux is the under-appreciated substrate of modern computing, GDAL is the under-appreciated substrate of modern geospatial data management. If the compute is running in the cloud, it's probably running on Linux; if the geospatial data are [flowing](https://registry.opendata.aws/landsat-8/) [through](https://www.planet.com/) [the](https://www.maxar.com/) [cloud](https://planetarycomputer.microsoft.com/), they're probably flowing through GDAL.

![GDAL]({{ site.images }}/2021/gdal.png)

At the same time as it has risen to being the number one spatial data processing tool in the world (by volume anyways), GDAL has maintained an economic support model from the last century. One maintainer (currently [Even Rouault](https://github.com/rouault/)), earning a living with new feature development, and doing all the work of code quality, integration, testing, documentation, and promotion as a loss leader. This model burns out [maintainers](https://fwarmerdam.blogspot.com/2011/06/joining-google.html), and it doesn't ask the organizations that gain the most value from GDAL (the ones pushing terrabytes of pixels through the cloud) to contribute commensurate with the value they receive. 

With the new [GDAL sponsor model](https://gdal.org/sponsors/), the organizations who receive the most value are stepping up to do their share. If your organization uses GDAL, and especially if it uses it in volume, consider joining the other sponsors in making sure GDAL remains high quality and cutting edge by sponsoring.

Thanks Daniel, for having me on! 

