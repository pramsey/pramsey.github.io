---
layout: post
title: Give in, to the power of the Client Side...
date: '2014-12-30T11:34:00.000-08:00'
author: Paul Ramsey
category: technology
tags:
- client
- gis
- javascript
- server
modified_time: '2014-12-30T11:34:18.498-08:00'
blogger_id: tag:blogger.com,1999:blog-14903426.post-5842503071306732004
blogger_orig_url: http://blog.cleverelephant.ca/2014/12/give-in-to-power-of-client-side.html
---

<img src="http://ecx.images-amazon.com/images/I/41IoEyPgbVL._SY300_.jpg" style="float:right; padding:10px" />Brian Timoney [called out](http://mapbrief.com/2014/12/29/geo-in-the-browser-less-it-means-this-time-its-different/) this [Tom Macwright](http://www.macwright.org/) quote, and he's right, it deserves a little more discussion:

> …the client side will eat more of the server side stack.

To understand what "more" there is left to eat, it's worth enumerating what's already been **eaten** (or, which is being consumed right now, as we watch):

* **Interaction:** OK, so this was always on the client side, but it's worth noting that the impulse towards using a heavy-weight plug-in for interaction is now pretty much dead. The detritus of plug-in based solutions will be around for a long while, inching towards end-of-life, but not many new ones are being built. (I bet some are, though, in the bowels of organizations where IE remains an unbreakable corporate standard.
* **Single-Layer Rendering:** Go back almost 10 years and you'll find OpenLayers doing client-side rendering, though using some pretty gnarly hacks at the time. Given the restrictions in rendering performance, a common way to break down an app was a static, tiled base map with a single vector layer of interest on top. (Or, for the truly performance oriented, a single raster layer on top, only switching to vector for editing purposes.) With modern browser technology, and good implementations, rendering very large numbers of features on the client has become commonplace, to the extent that the new bottleneck is no longer the CPU, it's the network.
* **All-the-layers Rendering:** Already shown in-principle by Google Maps, tiled vector rendering is moving over the last 12 months rapidly from wow-wizzy-demo to oh-no-not-that-again status. Rather than rendering to raster on the server side, send a simplified version to the client for rendering there. For base maps there's not a *lot* of benefit over pre-rendered raster, but there's some: dynamic labelling means orientation is completely flexible, and also allows for multiple options for labelling; also, simplified vector tiles can serve a wider range of zoom levels while remaining attractively rendered, so the all-important network bandwidth issues can be addressed for mobile devices.
* **"GIS" operations:** While large scale analysis is not going to happen on a web page, a lot of visual effects that were otherwise hard to achieve can now be pushed to the client. Some of the GIS operations are actually in support of getting attractive client-side rendering: voronoi diagrams can be a great aid to label placement; buffers come in handy for cartography all the time.
* **Persistence:** Not really designed for long-term storage, but since any mobile application on a modern platform now has access to a storage area of pretty large size, there's nothing stopping these new "client" applications from wandering far and completely untethered from the server/cloud for long periods of time.

Uh, what's left?
    
* Long term storage and coordination remain. If people are going to work together on data, they need a common place to store and access their information from.
* Large scale data handling and analysis remain, thanks to those pesky narrow network pipes, for now.
* Coordination between devices requires a central authority still. Although, not for long, with web sockets I'm sure some JavaScript wizard has already cooked up a browser-to-browser peer-to-peer scheme, so the age of fully distributed open street map will catch up to us eventually.

Have I missed any?

Once all applications are written in 100% JavaScript we will have finally achieved the vision promised to me [back in 1995](http://en.wikipedia.org/wiki/Java_(software_platform)#History), a write-once, run-anywhere application development language, where applications are not installed but are downloaded as needed over the network (because "[the network is the computer](http://en.wikipedia.org/wiki/John_Gage)"). Just turns out it took 20 years longer and the language and virtual machine are different (and there's this strange "document" cruft floating around, a [coccyx](http://en.wikipedia.org/wiki/Coccyx)-like evolutionary remnant people will be wondering about for years).