---
layout: post
title: Stop Mapping the World
date: '2008-06-15T22:31:00.000-07:00'
author: Paul Ramsey
tags: 
modified_time: '2008-06-15T22:45:29.163-07:00'
thumbnail: http://bp1.blogger.com/_yECf1Q0GlOk/SFWxi79HUvI/AAAAAAAABns/JPdPLQBzJmE/s72-c/3Dworks1.png
blogger_id: tag:blogger.com,1999:blog-14903426.post-2202423428041204557
blogger_orig_url: http://blog.cleverelephant.ca/2008/06/stop-mapping-world.html
comments: True
---

The [Thematic Mapping Blog](http://blog.thematicmapping.org/) has been on a 3D chloropleth jag lately, exploring all the ways to display global variables on a map of the world.  The technical achievements are all very nice, but the actual display of the useful numbers, is as usual totally screwed by the intractable fact that countries **are radically different sizes**!

The trouble with chloropleth maps, is that you're trying to display numerical data visually, but one of the most visually arresting features of your display is a variable that you **do not care about**, the size of the regions.

<img src="http://bp1.blogger.com/_yECf1Q0GlOk/SFWxi79HUvI/AAAAAAAABns/JPdPLQBzJmE/s400/3Dworks1.png" />

What do I get out of the global map display of world data, that I don't get out of a simple rank-ordered table?  A and B are high, and A and B are on the same continent. That could be done by coloring the rank order table by continent.  A and B are high, and A and B are adjacent. That's harder.

I've really become fond of the cartogram approach, as a partial solution to this problem, but it has it's own problems.

<img src="http://infosthetics.com/archives/cartogram.jpg" />

We're in for a whole slew of this kind of stuff, with the US election offing, since the Republicans uniformly win the large less dense counties, every chloropleth map visually overstates the results in one direction, no matter what the cartographers do. How do you show San Francisco County on a map of the continental USA? Does it get 1/2 a pixel even?

