---
layout: post
title: COTS uber alles?
date: '2013-01-26T23:25:00.002-08:00'
author: Paul Ramsey
tags:
- bc
- custom
- COTS
- enterprise IT
- icm
modified_time: '2013-01-26T23:25:46.792-08:00'
blogger_id: tag:blogger.com,1999:blog-14903426.post-3792863042745669954
blogger_orig_url: http://blog.cleverelephant.ca/2013/01/cots-uber-alles.html
comments: True
---

<p>I continue to follow the ongoing $180M-and-counting IT debacle of "integrated case management" in British Columbia with interest, perhaps because it's a local catastrophe and not some [far-flung disaster](http://spectrum.ieee.org/computing/software/who-killed-the-virtual-case-file).

The latest tidbit is an [independent consultant's review of ICM](http://www.integratedcasemanagement.gov.bc.ca/documents/icm-mcfd-iar.pdf) from the perspective of the Ministry of Children and Families (MCF). I hadn't previously appreciated the extent to which the hydra-headed nature of ICM as a project of **both** MCF and the Ministry of Social Development (MSD) was contributing to disfunction.

In politic terms, the consultants point out that MCF was the weaker partner in the partnership, and therefore got steamrolled during the design phase. MSD had a stronger team, was better prepared, and got what they wanted. MCF was the red-headed step-child.

Another issue the consultants noted was the way the "COTS" requirement and "no customization" made a bad situation worse. No matter what the clients wanted, there was a arbitrary external rule always in play:</p> 

<blockquote>The ICM solution [should] not be based on a customized system, but as much as possible rely on an “out of the box” product (with necessary configuration to meet the respective needs of MCFD and MSD).</blockquote>

 <p>If you knew the magic incantations, you could sometimes get an exemption, but the MCF team didn't know how to play the game:</p> 

<blockquote>It became clear in our interview process that while the project principles did support exceptions to the “no customization”’ rule where there was a solid business rationale, current MCFD leadership did not recognize they could make this appeal, and so remained fully constrained by the design and implementation of a single instance untailored to MCFD needs.</blockquote>

 <p>And so the final product rolled out was a design disaster for child protection:  

<blockquote>The decision to implement a single instance of the Siebel product required that all users (regardless of ministry or program) share a common set of forms and data attributes, even though they touch on completely different topics and clients, and speak very different practice “languages”. This has also led to many forms being developed with redundant fields and or labels that are meaningless to the majority of users.</blockquote>

 <p>In fact, the "phase 2" rollout was such a disaster that the whole COTS "no customization" rule seems be to up for review! Tucked into the consultant report is this little gem of a status update:</p> 

<blockquote>The ICM/Deloitte Project Team has also been working on the design and development of an external service provider portal which will utilize a custom user interface (i.e. leveraging the information within Siebel but presented through a completely separate web application). While the service provider portal does not have any direct relationship to MCFD’s Child Protection Services, it does demonstrate that the project team can design and develop a solution that builds on the Siebel platform with a customized user interface and significantly improved usability. This approach will be of value as we consider the revised child protection solution and we see it as a very positive step.</blockquote>

 <p>Plan B is now officially under way! The generic Siebel interfaces are being ditched in favour of (*gasp!*) **custom designed user interfaces** fit to purpose. Will the Siebel interfaces all be eventually phased out? That's my prediction.

The only question left is how long MSD and MFC will have to pay Siebel licensing for a system that has been delivered over-budget and with insufficient functionality largely to cater to the [predictable limitations](http://www.destinationcrm.com/Articles/Columns-Departments/Customer-Centricity/The-Siebel-Effect-And-Its-Survivors-68077.aspx) of the Siebel software and the "no customization" COTS philosophy. A long, long time, I fear.</p>