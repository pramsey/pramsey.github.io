---
layout: post
title: Must SDIs Fail?
date: '2006-10-18T16:44:00.000-07:00'
author: Paul Ramsey
tags: 
modified_time: '2006-10-21T11:22:58.183-07:00'
blogger_id: tag:blogger.com,1999:blog-14903426.post-116121580102166212
blogger_orig_url: http://blog.cleverelephant.ca/2006/10/must-sdis-fail.html
comments: True
---

Did I say "tomorrow"? I meant "next month".

**Making Technology Work**

Good news about the larger SDI vision is hard to come by.  The larger vision includes a central catalogue, clients that search the catalogue, find services, and then consume the services.  Portions of the vision are still "in progress" from a technological point of view -- standardized searching of catalogues for services is still a topic of discussion, not a fully settled issue, so it will be a while before the problem can be delegated to the political realm of getting folks on board.

The good news is that the various **parts** of the vision are coming together.<ul><li>The WMS specification is fully proven, and now widely implemented.  Most importantly, it is implemented in proprietary desktop tools with wide user bases.  When you think about the product development and release cycles involved, getting a new standard into a product is a pretty complex dance.<li>The WFS specification is on "phase one" of widespread adoption -- a number of vendors have implemented half-assed attempts at WFS clients.  The next round of attempts will probably be much better and useful, which will in turn charge up the relevance of the technology.</ul>Note that I am talking about **client** implementations primarily when talking about the maturity of the standards.  This is because the clients have always lagged behind the servers, perhaps because providing a good user experience of a complex technology is difficult.  For example, imagine how much traction the HTTP/HTML server standard would have without a good HTTP/HTML client application (like the one you're using to read this page).  

(As an aside, keep the HTTP/HTML example in mind the next time someone says "The standard has been around for 3 years, and you can buy a server that supports it from 4 different vendors".  The answer is "Yeah, but are there any clients for the server that do not suck rocks? Toy web implementations from the server vendors don't count.")

So, back to good news: key client/server standards are moving from the "conceptual" stage to the "works for me" stage.  Also, people are getting better at setting up the servers to not be disastrously slow -- and as they garner more users, they will get more complaints when they do a bad job, which will self-reinforce the whole system to higher quality.  (The NASA WMS administrators may hate what the Worldwind client has done in terms of creating load, but I am sure they would admit that the experience of figuring out how to solve the problem has made their services better.)

**Getting Data Online**

There are some good examples of organizations getting data online, and some bad examples.  The bad ones usually consist of central organizations saying "For the love of Pete, put some data online! If you put data online, I'll give you a cookie!"

The good ones are more directed, recognize the operational/analytical divide, and work to bridge that divide with face-to-face communication and assistance.

My favorite example is an SDI effort out of North Carolina, [NCOneMap](http://www.nconemap.net).  With very little funding from the state government, NCOneMap is stitching together an SDI built on data served up from the county level.  By all rights, this should be a colossal failure (herding poorly resourced, highly operational-minded counties into an SDI), but they are making it work, by:<ul><li>**Being focussed on what they really need.**  Yeah, it would be nice to get absolutely everything the county as online, to just say "put it all online", but what the state really needs is what they don't have, primarily a regularly updated street map, and a regularly updated parcel map.  So that is what they focus on.  Just getting each county to publish those two layers via WMS.<li>**Being helpful making it happen.** NCOneMap does not have a big budget, but they do have a few dedicated staff.  The staff has written very detailed directions about configuring ArcIMS as a WMS server.  They give workshops on setting up WMS and writing FGDC standard metadata.  They go to the counties and help them one-on-one.  In general, they recognize that a low-priority activity like publishing data online is going to require some lubrication to get moving, and are willing to apply it.<li>**Establishing exactly what they want.** They want a WMS with a couple layers, with certain metadata filled in a certain way, and they will train you in exactly how to make it, and even help you make it if you can't.  The bar is just about as low as it can go.</ul>(I have often thought that the best way to get the bar on the floor would be to actually **give** a WMS server to each organization you want to publish data, with a filesystem share available through one network interface and another network interface for the internet connections, and have people just copy their files into a directory tree on the server.  The server could automatically read the tree and convert it into a WMS/WFS server, and push that information up to the central SDI registry.  Given the cost of hardware today and the availability of open source, open standard software, such an idea is inherently achievable.)

**Creating an Example**

One of the upsides of the technological maturity of the WMS standard (and upcoming maturity of the WFS standard) is that it is possible for SDI seed organizations to "set a good example" by publishing their large data holdings.  Nothing hammers home the virtuous benefits of sharing more than sharing yourself, as St Francis of Assisi demonstrated.  

One of the great instances of this concept is the "[GeoBase](http://www.geobase.ca)" portion of the Canadian "[GeoConnections](http://www.geoconnections.org)" program.  Unlike most national SDI programs, GeoConnections has actually has some non-trivial funding attached to it, and some of that money is put towards to creation of the GeoBase layers.  One of the earliest big layers to be made available is a complete [Landsat](http://landsat.gsfc.nasa.gov/) coverage of Canada, compiled from 2000-2005 and published via WMS. 

By putting their money where their mouth is, national SDI promoters can simultaneously prove their commitment to the concept while demonstrating the effectiveness of web services.  Note that it is important that the service provided be a very good example: the first time I tried to GeoBase Landsat WMS service it was very, very slow, and that initial impression has been lingering ever since.

**Summary**

We're doomed! Doomed!

Unfortunately, the good news all adheres to various components of the SDI fabric, but the fabric itself continues to be torn apart by the lack of incentives to "good behavior" on the part of potential SDI participants.<ul><li>The NCOneMap experience shows that careful nurturing and love can bring out better behavior from potential SDI participants, but even then 100% participation is not guaranteed.  And maps with holes in them really suck.<li>The technological basis of SDI is continuing to mature, and some of it is particularly workable, but there is still some immaturity in core components of the fabric (like catalogues).<li>National agencies are trying to create good examples, by seeding the field with their own data, but so far the spirit of sharing has not been seeping much lower down the jurisdictional food chain.</ul>It seems to me that failure is not guaranteed, but the equation of SDI participation still needs some fine tuning.  Given that people have a low incentive to participate ("it makes me a better person"), what is required is a dramatic lowering of the bar to participation ("it takes longer to blow my nose than to participate in the SDI").

For a parallel, look at the world of P2P music sharing.  I have no incentive to share my music, I only really want to consume **other people's** music.  But when I pull music from others, the music sharing software automatically shares everything I pull down.  Also, sharing my music is as easy as dragging files and dropping them into the application window.  A GeoNapster could dramatically improve data sharing, by making the process very very very easy.

*(Anyone want to hire us to build GeoNapster? I have the specifications all ready, and sitting in my brain. :)*