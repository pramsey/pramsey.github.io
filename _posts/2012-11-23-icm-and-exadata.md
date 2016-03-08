---
layout: post
title: ICM and ExaData
date: '2012-11-23T10:51:00.000-08:00'
author: Paul Ramsey
tags:
- foi
- siebel
- exadata
- oracle
- bc
- icm
modified_time: '2013-06-10T13:58:27.020-07:00'
blogger_id: tag:blogger.com,1999:blog-14903426.post-6045687418892911952
blogger_orig_url: http://blog.cleverelephant.ca/2012/11/icm-and-exadata.html
comments: True
---

I went to an Oracle Users Group meeting yesterday afternoon, to see a presentation by [Marcin Zaranski](http://dir.gov.bc.ca/gtds.cgi?esearch=&amp;view=detailed&amp;sortBy=name&amp;for=people&amp;attribute=name&amp;matchMethod=is&amp;searchString=Marcin+Zaranski&amp;objectId=121598) on the [Integrated Case Management](/2012/06/more-icm.html) system's use of [Oracle ExaData](http://www.oracle.com/us/products/database/exadata/overview/index.html) hardware. 

Disclosure: I went expecting to be shocked, *shocked* at yet another criminal waste of money on the part of ICM.

ExaData is Oracle's fairly successful attempt to turn the hardware engineering skills they [acquired with Sun Microsystems](http://www.oracle.com/us/corporate/press/018363) into something with unique marketability. I'd say they've succeeded, which is good news for the excellent engineers at Sun. By combining the kinds of hardware database optimizations pioneered at [Netezza](http://www-01.ibm.com/software/data/netezza/) and [Teradata](http://www.teradata.com/) with Sun's overall server engineering prowess and their industry-leading sales and marketing team, Oracle has a winner. It might not be the best, but they are going to sell more of them than anyone else.

ExaData (I'm going to speak in the singular, about the [ExaData Database Machine](http://www.oracle.com/us/products/database/exadata/overview/index.html) even though the "Exa" prefix has now been splashed across a wide range of Oracle "engineered systems") is basically an enterprise appliance. A database in a box, where the "box" is a server rack. It ships with the database pre-installed and configured for the underlying hardware. The underlying hardware not only includes the kind of monitoring, reliability and redundancy that Sun fanboys like myself have come to expect, but also includes custom storage modules that can push portions of SQL queries down to just above the disk heads, dramatically improving query performance, particularly for [OLAP](http://en.wikipedia.org/wiki/Online_analytical_processing) workloads.

It's really clever technology, but the true cleverness is the sales pitch, which Zaranski touched on and Oracle rep [Dev Dhindsa](http://ca.linkedin.com/in/ddhindsa) hammered us over the head with during his talk: because ExaData is basically an appliance, all the coordination costs of getting systems and network administrators to interface with database and application administrators goes away. It's a technology fix for the organizational problem of IT silos, and the pitch to the database and apps departments is simple: "buy this product so you don't have to talk to those f***ers in system admin and networking anymore."

And any pitch to IT that involves talking to people less is a stone cold winner.

So, back to ICM. The justification for ICM buying ExaData was to alleviate performance problems experienced in their phase 1 rollout to about 1800 users before they rolled out to 8000 users in phase 2. The result: success! They didn't have *any complaints* in phase 2... [about performance](http://www.theprovince.com/life/Glitchy+million+computer+system+adds+social+workers+headaches/7495316/story.html). 

After his presentation, I asked Zaranski how much ExaData cost the ICM project, and he would not provide a number, presumably thanks to the magic of "secret contracts" with Oracle (pricing is a "trade secret" and thus protected by FOI, one of the many counterproductive consequences of the "third party confidential" exception in the BC FOI law).

However, later the Oracle hardware rep was nice enough to tell me the **list price** for ExaData: $250K for a "quarter rack". ICM purchased two of those (one for production, one for fail-over), presumably for less than list. It's a lot of money for servers, but within the context of a $200M project I find it hard to get worked up. It makes their system run faster, which makes it less awful for the users. And the cost of the ExaData hardware will look small next to the cost of the Oracle and Siebel software licenses that are going to run on it.

Way before the project was forced to buy top-end hardware to coax reasonable performance out of their application, the clusterf*** that is ICM was already baked in: by the decision to simultaneously integrate so many systems; by the decision to use the "COTS" Seibel solution; and by the decision to outsource to expensive international consultancies.

So, enjoy your cool hardware ICM, it's pretty boss.

**Best moment:** In his presentation, Zaranski repeated the ICM mantra: that one of the big wins is replacing the 30-year-old "legacy" systems previously doing the social services records keeping. "Legacy" is a favourite put-down of all IT presenters. "Legacy" software is crufty old stuff, in the process of being phased out, unlike the cool software **you** work with. So I got a perverse kick when Dev Dhindsa, in praising Oracle's new "cloud enabled" [Fusion Middleware](http://www.oracle.com/us/products/middleware/overview/index.html) contrasted it favorably with their suite of "legacy" applications, such as [PeopleSoft](http://www.oracle.com/us/products/applications/peoplesoft-enterprise/human-capital-management/overview/index.html), [JD Edwards](http://www.oracle.com/us/products/applications/jd-edwards-enterpriseone/overview/index.html), and ... [Siebel](http://www.oracle.com/us/products/applications/siebel/overview/index.html), the software ICM is using to replace the "legacy" social services systems.<br />