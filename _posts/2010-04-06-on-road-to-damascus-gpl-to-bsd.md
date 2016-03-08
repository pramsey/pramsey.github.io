---
layout: post
title: On the road to Damascus... GPL to BSD
date: '2010-04-06T21:29:00.000-07:00'
author: Paul Ramsey
tags: 
modified_time: '2010-04-07T08:21:39.934-07:00'
blogger_id: tag:blogger.com,1999:blog-14903426.post-1946518912696024087
blogger_orig_url: http://blog.cleverelephant.ca/2010/04/on-road-to-damascus-gpl-to-bsd.html
comments: True
---

In response to [a Twitter comment](http://twitter.com/pwramsey/status/11445182899) I made about my change in attitude towards the BSD and GPL open source licenses, Martin Daly [asks](http://twitter.com/mpdaly/status/11474844507):

<blockquote>Blog post on the [Damascene](http://en.wikipedia.org/wiki/Conversion_of_Paul) (or otherwise) conversion from GPL-ish to BSD-ish please. In your own time.</blockquote>

The reason I was even mentioning the license issue is because I was watching [a panel discussion at Where 2.0](http://en.oreilly.com/where2010/public/schedule/detail/12725), in which Steve Coast, in defending the [GPL-ish license used for OpenStreetMap](http://wiki.openstreetmap.org/wiki/OpenStreetMap_License), said (paraphrase) that the rationale was keeping a third party from taking the open data, closing it, and working from there. And that rationale pretty closely mirrors [how we were thinking](http://postgis.net/pipermail/postgis-users/2001-August/000203.html) when choosing the [GPL](http://www.opensource.org/licenses/gpl-2.0.php) license for PostGIS, back in 2001. 

I have experienced no spectral presence or flashing lights.

However, over the years, I have spent far too much time talking to various corporate folks about how the PostGIS [GPL](http://www.opensource.org/licenses/gpl-2.0.php) license wouldn't affect their plans to use PostGIS as a database component in their systems. For everyone who came and asked, I am sure many didn't. But in general the license was an impediment to some organizations engaging with the project. So there was a downside to the GPL. And was there an upside? Did the license protect us from privatized forks?

Well, yes, insofar is as it legally prevented them from happening. But it is worth questioning the implicit assumption that such forks are actually harmful to the project.

And here my experience watching the MapServer community (working with the <strike>BSD</strike> [MIT](http://www.opensource.org/licenses/mit-license.php) license) was useful. Because over those same years, I watched the [MapServer](http://mapserver.org/) project chug healthily along, even as some third parties did in fact take the code and work on [closed forks](http://www.mapdotnet.com/) from time to time. 

The lesson I have taken from my observation is that the strength of open source projects resides not in the licenses or the code, but in the communities arrayed about them. Copying the code of MapServer and doing your own thing with it does not stop MapServer developers from working, and in the long run you'll probably be better off working within the community than outside it, to gain from the efforts of others.  Trying to maintain a private parallel branch and patch in the changes from the open development will quickly become more effort than it is worth. At the same time, because the BSD license is so permissive, there are no legal impediments for companies to engage with the community.

Look at any healthy open source project and ask yourself: what is more valuable, the code or the community? You could take all the code **away** from a healthy project, and it would start right up again from scratch and probably do a better job the second time. The value is in the human relationships and the aggregation of cooperating talent.  

The GPL tends to keep corporate actors out of the community (for good reasons or bad, that's a separate discussion, but it does). That slows down the development of the project by reducing size of the development pool. Which, counterintuitively, makes forking or ignoring the open project more attractive. Because a slow moving project is easy to beat. A fast moving project is risky to fork, because it is likely that your (relatively understaffed) fork will be left behind by the open project.

So, back to what originally made me delve into license wankery, the question of OpenStreetMap license: the value of the OSM community and philosophy and infrastructure is way higher than the data at this point. And bringing corporate actors into the OSM community would only increase the relative advantage of the open project over any equivalent closed effort.

But changing licenses is a brutally hard thing to do, and it gets harder the longer a license is in place. PostGIS will never change licenses, for example. There are too many developers who contributed in the past under the GPL, and changing license would require the assent of all of them. 

But if I ever start a new project, it will definitely be under the BSD.

