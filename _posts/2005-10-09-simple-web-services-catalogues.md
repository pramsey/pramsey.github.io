---
layout: post
title: Simple Web Services Catalogues
date: '2005-10-09T09:37:00.000-07:00'
author: Paul Ramsey
tags: 
modified_time: '2006-10-21T11:22:57.501-07:00'
blogger_id: tag:blogger.com,1999:blog-14903426.post-112887613347300606
blogger_orig_url: http://blog.cleverelephant.ca/2005/10/simple-web-services-catalogues.html
---

Web services are a "big deal" these days, garnering lots and lots of column inches in mainstream [IT magazines](http://www.infoworld.com/article/05/05/06/HNfinalsoapanel_1.html).  The geospatial world is no exception: after years of stagnation the number of number of [Open Geospatial Consortium](http://www.opengeospatial.org/) (OGC) web services publicly available on the internet is starting to really explode, going from around 200 to 1000 over the last nine months.

Great news! Except... now we have to find the services so we can use them in clients. The web services mantra is "publish, find, bind". "Publish" is going great guns, "bind" is working well with good [servers](http://mapserver.gis.umn.edu/) and [clients](http://udig.refractions.net/), but "find"... now that is another story.

The OGC has a specification for a "[Catalogue Services for the Web](http://portal.opengeospatial.org/files/?artifact_id=5929&version=1)" (CSW), which is supposed to fill in the "find" part, but:<br /><p></p> <ul><li>It is 180 pages long;<br /></li><li>You also need a "[profile](https://portal.opengeospatial.org/files/?artifact_id=7048)" for services, another 40 pages; and,<br /></li><li>The profile catalogues information at a "service" level, rather than at a "layer" level.</li></ul>The OGC specification is designed to handle a large number of use cases, most of which are irrelevant to spatial web services clients currently in action. By designing for the future, they may have foreclosed on the present, because there are **much easier** ways to get at catalogue information than via CSW.

For example, if you want a quick raw listing of spatial web services, try this link:

[http://www.google.ca/search?q=inurl:request=getcapabilities](http://www.google.ca/search?q=inurl%3Arequest%3Dgetcapabilities)

Instant gratification, and you did not have to read a single page of the CSW standard!

With a little [Perl](http://www.perl.org/), some [PostgreSQL](http://www.postgresql.org/) and [PostGIS](http://postgis.refractions.net/) you can turn the results of the above into a neat layer-by-layer database and allow people to query it with a very simple URL-based API:

[http://udig.refractions.net/search/google-xml.php<br />?keywords=robin<br />&amp;xmin=-180<br />&ymin=-90<br />&amp;xmax=180<br />&ymax=90](http://udig.refractions.net/search/google-xml.php?keywords=robin&xmin=-180&amp;ymin=-90&xmax=180&amp;ymax=90)

This kind of simple catalogue access became a clear necessity while we were building [uDig](http://udig.refractions.net/) -- there were no CSW servers available with a population of publicly available services, and in any event the CSW profiles did not allow us to search for information *by layer*, the fundamental unit of interactive mapping.

By using this simple API and properly populated catalogue, we turned [uDig](http://udig.refractions.net/) into a client that implemented all the elements of the publish-find-bind paradigm, and exposed them with a drag-and-drop user interface. A user types a keyword into the [uDig](http://udig.refractions.net/) search panel, selects a result from the return list, and drags it into the map panel, where it automatically loads.

<a onblur="try {parent.deselectBloggerImageGracefully();} catch(e) {}" href="http://photos1.blogger.com/blogger/8171/1363/1600/screenshot_011.jpg"><img style="margin: 0px auto 10px; display: block; text-align: center; cursor: pointer;" src="http://photos1.blogger.com/blogger/8171/1363/400/screenshot_01.jpg" alt="" border="0" /></a><br />So where does this leave the OGC catalogue effort? Still waiting for clients. There are server implementions from the vendors who sponsored the profile effort, but the client implementations are the usual web-based show'n'tell clients, not clients cleanly integrated into actual GIS software. All web services standardization efforts have a chicken-and-egg quality to them, as the network effects of the standard do not become apparent until a critical mass of deployed clients can hit a critical mass of populated servers. Both halves of the equation are required: useful clients, and useful servers.