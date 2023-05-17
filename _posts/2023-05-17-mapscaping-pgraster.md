---
layout: post
title: 'MapScaping Podcast: Rasters and PostGIS'
date: '2023-05-17'
author: Paul Ramsey
category: technology
tags:
- postgis
- raster
comments: True
image: "2023/library.jpg"
---

Last month I got to record a couple podcast episodes with the [MapScaping Podcast](https://mapscaping.com/podcast/rasters-in-a-database/)'s [Daniel O'Donohue](https://mapscaping.com/about-us/). One of them was on the benefits and many pitfalls of putting rasters into a relational database, and it is online now!

* [Rasters In A Database?](https://mapscaping.com/podcast/rasters-in-a-database/)

TL;DR: most people think "put it in a database" is a magic recipe for: faster performance, infinite scalability, and easy management. 

Where the database is replacing a pile of CSV files, this is probably true. 

Where the database is replacing a collection of GeoTIFF imagery files, it is probably false. Raster in the database will be slower, will take up more space, and be very annoying to manage. 

So why do it? Start with a default, "don't!", and then evaluate from there.

For some non-visual raster data, and use cases that involve enriching vectors from raster sources, having the raster co-located with the vectors in the database can make working with it more convenient. It will still be slower than direct access, and it will still be painful to manage, but it allows use of SQL as a query language, which can give you a lot more flexibility to explore the solution space than a purpose built data access script might.

There's some other interesting tweaks around storing the actual raster data outside the database and querying it from within, that I think are the future of "raster in (not really in) the database", [listen to the episode](https://mapscaping.com/podcast/rasters-in-a-database/) to learn more!