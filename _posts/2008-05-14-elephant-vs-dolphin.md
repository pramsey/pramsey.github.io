---
layout: post
title: Elephant vs Dolphin
date: '2008-05-14T13:40:00.000-07:00'
author: Paul Ramsey
tags: 
modified_time: '2008-05-14T13:50:01.869-07:00'
blogger_id: tag:blogger.com,1999:blog-14903426.post-6754738977899923871
blogger_orig_url: http://blog.cleverelephant.ca/2008/05/elephant-vs-dolphin.html
---

Elephant crushes dolphin, but dolphin drowns elephant?

More folks doing real work needing a real spatial database, this time [RedFin](http://devblog.redfin.com/2007/11/elephant_versus_dolphin_which_is_faster_which_is_smarter.html) a real estate information company.

> Specifically, we were having some major performance problems with queries that were constrained by both spatial and numeric columns, and all of our attempts to squeeze more performance out of MySQL (including hiring expensive outside consultants) had come to naught.

Guys, if you're going to hire expensive outside consultants to help with your spatial database problems, they should be (a) me and (b) conversant in PostGIS! :)

**Update:** It is worth explaining that their main problem, the slow results when the spatial clause was weak, is a direct result of MySQL having an inferior query planner. PostGIS is fast because PostGIS provides good statistics on spatial index selectivity to the planner, and the PgSQL planner is flexible enough to accept selectivity information from extended types. I know this is a big performance problem because before PostGIS had a decent selectivity system, performance bottlenecks like RedFin's happened all the time.

