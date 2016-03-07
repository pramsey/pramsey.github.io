---
layout: post
title: PostgreSQL 8.3.5 - Important Upgrade
date: '2008-11-12T17:01:00.000-08:00'
author: Paul Ramsey
tags: 
modified_time: '2008-11-13T12:12:35.274-08:00'
blogger_id: tag:blogger.com,1999:blog-14903426.post-5642434271917362805
blogger_orig_url: http://blog.cleverelephant.ca/2008/11/postgresql-835-important-upgrade.html
---

Normally, minor releases just sail by... the bugs fixed are tiny things that don't apply to your neck of the woods, but for 8.3.5 you will find this entry in the [release notes](http://www.postgresql.org/docs/8.3/static/release-8-3-5.html):

<blockquote>Fix GiST index corruption due to marking the wrong index entry "dead" after a deletion (Teodor) This would result in index searches failing to find rows they should have found.</blockquote>

The PostGIS spatial index is built on top of GiST, so for any production table where entries are being deleted or updated, this bug could **actually cause errors to crop up**. Data would not be lost, but it would occasionally not be found in index-enabled searches.

**If you are using PostGIS on PostgreSQL 8.3, upgrade to 8.3.5 as soon as possible.**  This bug has been seen in the wild, one of my clients just ran into it, it could affect you too.

**Update:** From Mark Cave-Ayland, the bug was only introduced during the last set of point releases, and was backpatched all the way to 8.1. So the complete list of affected PostgreSQL releases is: 8.1.14, 8.2.10 and 8.3.4. If your version is not one of those, you're safe.

