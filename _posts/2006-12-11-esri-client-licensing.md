---
layout: post
title: ESRI Client Licensing
date: '2006-12-11T09:09:00.000-08:00'
author: Paul Ramsey
tags: 
modified_time: '2006-12-11T09:20:41.264-08:00'
blogger_id: tag:blogger.com,1999:blog-14903426.post-8194097872917372085
blogger_orig_url: http://blog.cleverelephant.ca/2006/12/esri-client-licensing.html
comments: True
---

Having talked about Oracle's client licensing which is "freely redistributable within the bounds of certain definitions of the word 'free'", I wondered about ESRI's client licensing.

The ESRI SDE client Java libraries are not publicly downloadable, at least not explicitly.  You can physically get your hands on them by [downloading a service pack](http://support.esri.com/index.cfm?fa=downloads.patchesServicePacks.viewPatch&PID=19&MetaID=1198) and pulling them out of there.  For whatever reason, there is no click through license and no license included in the service packs, so those who live by the letter of the law might feel fine just using them as found.

Those of us living by the spirit of the law need to go one level deeper.  We have an ESRI Developer Network package, so I pulled out the SDE developer kit disk and installed the Java clients.  The license I had to agree to in that process did not say anything specific about the client libraries, so I assume they are covered in the general license, which is pretty explicit:

<blockquote>Licensee shall not redistribute the Software, in whole or in part, including, but not limited to, extensions, components, or DLLs without the prior written approval of ESRI as set forth in an appropriate redistribution license agreement.</blockquote>

Looks like black-letter law to me.

Like Oracle, ESRI is missing out on an opportunity to grow an ecosystem of dependent open source client applications.  As Howard Butler [points out in a comment](/2006/12/not-so-free-client-libraries.html), proprietary companies like LizardTech let open source projects ship their SDK clients with their builds.  It's called market building.