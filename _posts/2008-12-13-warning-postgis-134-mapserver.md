---
layout: post
title: 'Warning: PostGIS 1.3.4 + Mapserver'
date: '2008-12-13T11:52:00.001-08:00'
author: Paul Ramsey
tags: 
modified_time: '2008-12-15T14:44:48.484-08:00'
blogger_id: tag:blogger.com,1999:blog-14903426.post-8793405977156975417
blogger_orig_url: http://blog.cleverelephant.ca/2008/12/warning-postgis-134-mapserver.html
---

<img src="http://www.ent.iastate.edu/images/hemiptera/stinkbug/brown_stink_bug_nymph.jpg" style="height:252px; width:215; float:right;"/>Warning to Mapserver users: There is a bug in PostGIS 1.3.4 which will cause PostgreSQL to crash when used in conjunction with Mapserver and LINE layers. **We should have PostGIS 1.3.5 out this week, which will fix the problem.** In the meantime, reverting to version 1.3.3 will remove the problem.

This bug will affect any PostGIS application that calls the ST_Multi(), Multi(), ST_Force_Collection() and Force_Collection() functions with a LINESTRING as an argument.  Mapserver happens to have a Force_Collection() as part of the main draw routine for PostGIS, so it is very likely to exercise the bug.

If you are seeing crashing behavior in conjunction with LINESTRING types, this bug is probably the source. It was introduced in 1.3.4 when fixing an similar bug for CURVE types. Regina Obe is currently beefing up our regression suite, so that the odds of introducing similar bugs in the future are much lower.

**Update:** PostGIS 1.3.5 has [been released](http://postgis.net/download) to address this bug.

