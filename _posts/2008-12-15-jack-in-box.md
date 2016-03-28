---
layout: post
title: Jack in the Box
date: '2008-12-15T10:53:00.001-08:00'
author: Paul Ramsey
tags: 
modified_time: '2008-12-15T12:05:52.771-08:00'
blogger_id: tag:blogger.com,1999:blog-14903426.post-3266623017111535673
blogger_orig_url: http://blog.cleverelephant.ca/2008/12/jack-in-box.html
comments: True
---

Wow, some very interesting new data points on how ESRI is positioning itself in the marketplace relative to open source in a [new interview of ESRI monarch Jack Dangermond](http://enterpriseapplications.cbronline.com/news/qa_esri_founder_jack_dangermond_151208) at CRBonline.

> **Q. What is your attitude towards open source?**<br/>
> A. ESRI is philosophically very supportive of the open source movement and we have engineered our tools so they live inside an open source sandwich. They run on Linux and other open source systems. We have some significant components of our tools that are open source such as Spatial Statistics, which we purposefully kept in Python open source environments.

<img src="http://blogs.commercialappeal.com/blake/homer_2.gif">

First, some interpretation. What is this "open source sandwich" and where can I get one, I'm feeling hungry! I assume the reference is to a deployment architecture where the base layers of operating system (Linux) and database (PostgreSQL) are open source, the middle tier application server (ESRI ArcServer) is not, and the user interface layer (Openlayers? ExtJS?) is open source.

The subtext is that ESRI is not so interested in controlling the whole stack, soup-to-nuts, anymore, which of course is not all true.  ArcMap still really requires ArcServer (n&eacute;e ArcSDE) for direct database editing -- even if you "direct connect" to your Oracle Spatial or PostGIS you need the ArcServer license.  For many ArcMap customers, "what works with ArcMap" is still the first and only question driving purchasing decisions, and the answer to the question remains "another product from ESRI".  However, in places where they don't have their customers' balls in a vice (server-side, web services), ESRI is being forced to integrate better with third party software.  Thank you, market discipline.

> **Q. Do you face much competition from open source?**<br/>
> A. I don’t think we do. It’s a political movement as well as a technical effort. People who buy our products don’t typically want to buy open source because they want to acquire total integrated support for their mission critical applications. Do we want ambulance dispatch running on a system that’s not as well supported? Arguably a commercial product can bring about better support these days, maybe that won’t be the case in the future. But at this point our general philosophy is that we like the open source movement, we not challenging it, or challenged by it, and we welcome it into the geospatial community because it’s a hotbed of open research that we benefit from and like to contribute to.

Shades of Microsoft, an enjoyable icing of [FUD](http://en.wikipedia.org/wiki/Fear,_uncertainty_and_doubt), and a roadmap for open source competitors, should they be willing to follow it.

<div style="margin:4px;float:right;text-align:center;"><img width="187" height="300" src="http://www.oreillynet.com/oscon2002/graphics/jc5_01.jpg"><br/><small>Would you buy software<br/>from this man?</small></div>

We start with "it's a political movement", almost a non-sequitur, but the point is to tie open source in readers' minds to very political folks like [Richard Stallman](http://en.wikipedia.org/wiki/Richard_Stallman), the Barry Goldwater ("extremism in the defense of liberty is no vice") of open source.  This is much in the tradition of Microsoft's early positioning against open source, which was to highlight the [GPL](http://www.gnu.org/copyleft/gpl.html) and [Free Software Foundation](http://www.fsf.org/) as much as possible -- pick the face most objectionable to mainstream customers, point and say "that there is open source, you really want some of that?!"

Having intimated that open source is anarchist basement hackers (incidentally, our own tendency to speak about an "open source *movement*" plays into this harmful connotative framework), Jack moves to the meat of his argument, that ESRI provides "total integrated support" and open source does not.  Attempting to rub salt in the wounds, he tosses in an ambulance dispatch example (Jack, I want my ambulance dispatch running on a system that, first and foremost, **works**).  

Of course, to believe that ESRI has an advantage in the realm of "total integrated support", you have to first believe that the support available from ESRI [is worth paying money for](http://www.spatiallyadjusted.com/2005/12/14/yea-im-looking-at-mapserver-enterprise/).

Most important, Jack is ceding arguments about technical superiority here. It's not about software anymore, it's about support. And the gauntlet is thrown down -- if your company can create a credible open source [whole product](http://en.wikipedia.org/wiki/Whole_product) you can play with the big boys.  Mind you, a good deal of the psychological comfort decision makers draw from things like "support contracts" comes from enterprise size, and there's a serious chicken-and-egg problem to be dealt with there for open source enterprises.

