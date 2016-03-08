---
layout: post
title: An open source GIS on every Desktop?
date: '2006-08-23T10:25:00.000-07:00'
author: Paul Ramsey
tags: 
modified_time: '2006-10-21T11:22:57.999-07:00'
blogger_id: tag:blogger.com,1999:blog-14903426.post-115635432940202844
blogger_orig_url: http://blog.cleverelephant.ca/2006/08/open-source-gis-on-every-desktop.html
comments: True
---

Steven Citron-Pousty has a [good posting](http://thesteve0.wordpress.com/2006/08/22/the-gis-user-is-stuck-in-the-middle/) about why he cannot move his shop to an open source basis in the near term.  He took a look at [uDig](http://udig.refractions.net) (thanks!) but, unsurprisingly, finds that it ain't [ArcGIS](http://www.esri.com/arcgis) quite yet.  His prescription is not for the faint of heart.

> If you want people to switch you need to make the transition as painless as possible. Firefox got people to switch to IE by
> 
> * Making better software
> * Not making user learn a new UI for interacting with the web
> * importing all their IE favorites
> * THEN building in cool new features that keep people around

So, all we have to do is make something better than ArcGIS, but not so much better that it is not familiar to the existing user base, that works transparently with all their existing data and presumably their .mxd files too.  And give it away for free.  

"Just be like [Firefox](http://www.mozilla.org)."  There are a couple of problems with this idea. 

* The first problem is the idea that garnering users is "the goal". It is not. The misunderstanding is reasonable, because for proprietary companies it **is** the goal -- more users implies more licensing dollars. For open source projects, more users just means somewhat more download bandwidth and slightly higher number of beginner questions on the mailing lists. What open source projects want to attract is not users -- it is developers.  Developers will make the project stronger, add features, fix bugs, do all the things that end users want, but cannot do for themselves.
* The second problem is that Firefox is not a normal open source project.  The [Mozilla Foundation](http://www.mozilla.org/foundation/) has a lot of employees, most of them working on development, and [a deal](http://news.zdnet.co.uk/0,39020330,39189475,00.htm) with [Google](http://www.google.com) that nets them [millions of dollars](http://www.scroogle.org/mozilla.html) each year.  They can afford to be end user focused, because they have a paid pool of developers already in house.

It seems like all of the "user" success stories in the open source world (Firefox, [Open Office](http://www.openoffice.org), some of the "[desktop Linux](http://www.novell.com/products/desktop/)" efforts) have at their core one common feature -- a large and ongoing firehose of money.  Absent the firehose, it is hard to aggregate enough continuous effort to create desktop applications that include both the number of features and quality of finish necessary to entice the otherwise unmotivated "user".

uDig has enough features and stability to be useful right now to a narrow pool of developers creating custom applications with specific toolsets.  Hopefully in the future it will have more features and stability, and the pool will be less narrow.  But I predict it will still be dominated by developers.  

And that's fine with me.   

If Steven adopted uDig and [PostGIS](http://postgis.refractions.net) for his shop, it would not do a thing for my bottom line.  But if he built an application around it, he would either add a little functionality (which would help me with my clients) or maybe hire us to add a little functionality (which would help the bottom line directly).

Open source is not about users, it is about developers. It is only about users in so far as users become sufficiently engaged in the project that they either become developers themselves, or support developers through careful bug finding or documentation.

The correct models are not Firefox or Open Office (unless someone wants to point a money firehose at me... I won't object) those projects are aberations.  The correct models are [Linux](http://www.linux.org), [Apache](http://www.apache.org), [Perl](http://www.perl.org), [PostgreSQL](http://www.postgresql.org) -- not user-friendly, but still **very useful**.