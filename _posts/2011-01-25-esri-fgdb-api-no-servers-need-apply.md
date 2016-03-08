---
layout: post
title: 'ESRI FGDB API: No Servers need Apply'
date: '2011-01-25T14:58:00.000-08:00'
author: Paul Ramsey
tags: 
modified_time: '2011-01-27T09:58:14.614-08:00'
blogger_id: tag:blogger.com,1999:blog-14903426.post-2367954204533013485
blogger_orig_url: http://blog.cleverelephant.ca/2011/01/esri-fgdb-api-no-servers-need-apply.html
comments: True
---

<img src="http://resources.arcgis.com/sites/default/files/images/fileAPI2.png" style="float:right; width:150px; padding: 5px;"/>When downloading the ESRI [file-based geodatabase API](http://resources.arcgis.com/content/geodatabases/10.0/file-gdb-api) you are required to accept a license agreement which includes this lovely clause in the section about acceptabe uses of the API:<br />

> "Single Use License." Licensee may permit a single authorized end user to install and use the Software, Data, and Documentation on a single computer for use by that end user on the computer on which the Software is installed. Remote access is not permitted. Licensee may permit the single authorized end user to make a second copy for end user's exclusive use on a portable computer as long as only one (1) copy of the Software, Data, and Documentation is in use at any one (1) time. No other end user may use the Software, Data, or Documentation under the same license at the same time for any other purpose.

Note, only **one user** may use the software, and **remote access is not permitted**. That is, you can't run a mapping server on top of this API, because then multiple users would be using it, remotely.  Impressive.  Point to Redlands.  I will console myself in the usual way: "better than nothing."

**Update:** Martin Daly asked me to take a second look, and someone Twittered asking if the clause was boilerplate. On second examination, it could simply be boilerplate used for other desktop-oriented software that has been used without thought as to how it muddies the uses for non-desktop systems. The [full text is here](http://resources.arcgis.com/node/agreement/3193) for those with ESRI logins. Never attribute to malice what you can attribute to accident, another good rule to live by (but how empty I would be without my little conspiracy theories!). The precautionary principle would dictate not web-serving with it until/unless it is clarified, but in the meanwhile bulk loaders and translators could certainly be put together.

**Update 2:** Though the I find the license language somewhat unclear, [the intent appears to be to allow any application](http://forums.arcgis.com/threads/22027-FGDB-licensing-for-servers?p=71967) to sit on top of the API. Crisis averted, situation normal.

**Update 3:** Just got off the plane and the ESRI folks have left me a nice voice mail explaining that the intent of the clause is with respect to developers downloading it (once, for one person) not for uses of derived products. The moral of the story is that ESRI people are pretty darn nice, and I am not so very nice. Something for me to work on in the new year.

**Update 4:** Received email from ESRI confirming that the final license will be reviewed to ensure there are no ambiguities and that it reflects their intent that the API be usable by **any** application in **any** application category and the derived product freely redistributable and royalty free. So to the extent that the current license has any ambiguity it shouldn't be considered a red flag that the final one will.

