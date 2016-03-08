---
layout: post
title: 'Attention Neotards: Your GPS Sucks!'
date: '2008-02-18T09:51:00.000-08:00'
author: Paul Ramsey
tags: 
modified_time: '2008-02-18T11:22:04.855-08:00'
blogger_id: tag:blogger.com,1999:blog-14903426.post-7931112814315775995
blogger_orig_url: http://blog.cleverelephant.ca/2008/02/attention-neotards-your-gps-sucks.html
comments: True
---

Reading through an [update](http://www.linux.com/feature/125344) from Open Street Map (incredibly, it has taken them mere months to load TIGER into their futuristic system) I came across this little gem regarding aerial photography:

> Since the TIGER map data was produced from aerial photography, and was originally intended to assist Census Bureau officials in the field, such problems [misalignment of roads] are bound to occur and are unlikely to have undergone official correction.

I'm not sure what to mock first, the leap to the conclusion that TIGER data problems are a result of aerial photography, or the related conclusion that GPS tracing is somehow superior to aerial photography. They are of course, closely related in the mind of the neotard: "Hmm, TIGER is old; aerial photography is old; TIGER sucks; aerial photography is old and expensive (so it sucks); therefore, the reason TIGER sucks is because aerial photography sucks!"

(Admission, I don't know *why* TIGER positions are so bad in places. The answer may well be the source, but it cannot be hung off of aerial photography. Much of TIGER is sourced from lower levels of government then stitched in, so it is probably a pastiche of capture methods. I wouldn't be surprised if some of it was digitized off of paper road maps. Or if some of it has not been positionally updated in 25 years.)

<img src="http://pictures.directnews.co.uk/liveimages/Neanderthal+man_579_17669584_0_0_10940_300.jpg" style="float:right;border-width:0" alt="Paleotard" />

Oh, pity the poor paleotards, who don't know any better, wasting good money flying about taking error prone "photographs", instead of doing the smart thing and walking around with a Garmin. (Is that a Garmin in your pocket, or are you just happy to see me?)

I admit, I suffered from "GPS is magic" syndrome for quite a while, but I had the fortune to be exposed to people whose job it is to make base maps, who have to ensure that the lines they place on the map (in the database) are as close to "true" location as possible, given the technology available.  That exposure taught me some useful things about source data collection, and one thing it taught me is that GPS traces are extremely hard to quality control.

The GPS has a very hard job to do. It has to read in multiple signals from satellites and calculate its location based on *very, very, very* small time differences. What happens when the signals intermittently drop because of trees overhead blocking the signal? Or bounce off of a nearby structure?  The unit makes errors.  Which would be fine, except it's hard to isolate which observations are good, and which ones are bad.  Too often, GPS track gathering falls back on heuristics that delete "zingers" (really obviously bad readings, determined visually or with a simple algorithm) and assume every other observation is "good".  If you delete zingers and take enough repeated traces, you can slowly get averaged lines that converge towards meter-level accuracy.  However, the need for multiple traces radically increases the manpower/cost of gathering decent data, and the accuracy level does max out after a while.

The answer to getting good positional information over a large area is to tie together the strengths of GPS systems and the strength of remote sensing (aerial, satellite) systems.  

* Take a picture from above (or better, borrow one, from the [USDA](www.apfo.usda.gov), or USGS, that has already been "[orthocorrected](http://en.wikipedia.org/wiki/Orthophoto)").  This provides a very good source of relative measurement information: you can determine very precisely the distance and bearing between any points A and B.  But it has no absolute positioning: how do I know the longitude/latitude of A and B?
* Find several points at the edges of your photograph that are clearly visible from above and identifiable from the ground. Take your GPS to those points, and take long, long, long collections of readings (a hour is good) at each one.  Take those readings home, and [post-process them](http://www.geod.nrcan.gc.ca/products-produits/ppp_e.php) to remove even more error.  Average your corrected readings for each point, you now have "ground control points".  
* Use those control points to fit your aerial picture to the ground in some nice planar projection (like UTM).  Digitize all the rest of your locations directly off the picture.

Take a deep breath. You are now a paleotard, but a happy, contented paleotard with very well located data. 

This posting derives from a [very interesting discussion](http://lists.burri.to/pipermail/geowanking/2007-August/004299.html) on [Geowanking](http://lists.burri.to/mailman/listinfo/geowanking) from some months back.  The question was "how do I map my two acre property at very high accuracy?", and while the initial guess of the poster involved using a variation on GPS tracing, the best final answer was a hybrid solution.
{: .note }
