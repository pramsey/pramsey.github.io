---
layout: post
title: Technocuffs
date: '2014-07-30T09:52:00.001-07:00'
author: Paul Ramsey
category: politics
tags:
- bc
- COTS
- enterprise IT
- icm
modified_time: '2014-07-30T10:02:13.967-07:00'
blogger_id: tag:blogger.com,1999:blog-14903426.post-8008612413950449017
blogger_orig_url: http://blog.cleverelephant.ca/2014/07/technocuffs.html
comments: True
---

<img src="http://upload.wikimedia.org/wikipedia/commons/e/e3/Police_handcuffs_alt.jpg" width="220" style="float:right; padding:7px;" />

Bill Dollins wrote an [excellent paean to the positive aspects of vendor lock-in](http://blog.geomusings.com/2014/07/24/lock-in/), which is worth a few minutes of your time:
    
> Lock-in is a real thing. Lock-in can also be a responsible thing. The organizations I have worked with that make the most effective use of their technology choices are the ones that jump in with both feet and never look back. They develop workflows around their systems; they develop customizations and automation tools to streamline repetitive tasks and embed these in their technology platforms; they send their staff to beginning and advanced training from the vendor; and they document their custom tools well and train their staff on them as well. In short, they lock themselves in.

I think locking yourself into a **good** technology could have all the positive knock-on effects Bill lists. But, we never quite know what we're getting, good or bad, until we've spent some time with it. Which to me means being carefully modular and standards-oriented in design (which is to say, the opposite of how most vendors will architect a solution).

The BC Integrated Case Management (ICM) project yet again provides an excellent example of the negative aspects of vendor worship. In this case, ICM chose their software vendor first (way back in the single-digit 2000's they chose [Seibel](http://www.destinationcrm.com/Articles/Columns-Departments/Customer-Centricity/The-Siebel-Effect-And-Its-Survivors-68077.aspx)) and then chose their system integrator (Deloitte) and finally began to get the first major phases of delivery a [couple years ago](http://www.newsroom.gov.bc.ca/2012/03/province-launches-phase-2-of-integrated-case-management.html). One result of this slow motion train wreck is that the Seibel software is dragging other aspects of the Ministry's technology base down to its level. 

For example, [among the limitations (scroll to the bottom)](http://docs.openinfo.gov.bc.ca/D41428714A_Response_Package_CTZ-2014-00130.PDF) ICM (Seibel) imposes are:

* "Using any version of IE other than IE 8 may result in unexpected behavior". So no IE 9, 10, or 11. Also, no Windows 8 support, since IE 8 only works on Windows 7 or less. Also no browser other than IE.
* "The 32-bit ActiveX Seibel plug-in does not work with 64-bit IE". So all sorts of potential collisions between 64-bit/32-bit libraries. (The sysadmins weep.)

Only a few years after launch, ICM is already locking the Ministry to desktop technology that is several versions out of date, which will in turn restrict flexibility for doing more modern work in the future. This is one of the the downsides of lock-in.