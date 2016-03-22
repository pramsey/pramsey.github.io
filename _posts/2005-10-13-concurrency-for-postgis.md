---
layout: post
title: Concurrency for PostGIS
date: '2005-10-13T20:31:00.000-07:00'
author: Paul Ramsey
tags: 
modified_time: '2006-10-21T11:22:57.559-07:00'
blogger_id: tag:blogger.com,1999:blog-14903426.post-112926115412284030
blogger_orig_url: http://blog.cleverelephant.ca/2005/10/concurrency-for-postgis.html
comments: True
---

I recently had an opportunity to perform an experiment of sorts on an open source community, the [PostGIS](http://postgis.net/) community. The hypothesis was: an open source community would contribute financially to a shared goal, to directly fund development, with multiple members each contributing a little to create a large total contribution. Note that this is different from a single community member funding a development they need (and others might also need but not pay for). This is a number of entities pitching in simultaneously, and really is the preferred way (I think) to share the pain and share the gain.

The story started with a post from Oleg Bartunov on the [PostgresSQL](http://www.postgresql.org/) hackers list:

> I want to inform that we began to work on concurrency and recovery support in GiST on our's own account and hope to be ready before 8.1 code freeze. There was some noise about possible sponsoring of our work, but we didn't get any offering yet, so we're looking for sponsorship! [Full email...](http://archives.postgresql.org/pgsql-hackers/2005-06/msg00294.php)

The original noise about sponsorship had actually come from me, about 18 months earlier, when it became clear that the full table locks in the existing [GiST index code](http://www.sai.msu.su/%7Emegera/postgres/gist/) were going to be a future bottleneck. So, I felt obligated to follow up! Here was a chance to see open source "values" in action: everyone would benefit from this improvement, so surely when given the opportunity to help fund it and ensure it came to fruition, contributors would leap to the fore. I wrote to [postgis-users](http://lists.osgeo.org/pipermail/postgis-users/):

> Oleg and Teodor are ready to attack GiST concurrency, so the time has come for all enterprise PostGIS users to dig deep and help fund this project ... Refractions Research will contribute $2000 towards this development project, and will serve as a central bundling area for all funds contributed towards this project. As such, we will provide invoices that can be provided to accounts payable departments and cash cheques on North American banks to get the money oversees to Oleg and Teodor. No, we will not assess any commissions for this: we want to see this done. [Full email...](http://lists.osgeo.org/pipermail/postgis-users/2005-June/008294.html)

The response was... Underwhelming. There is nothing like a sense of urgency to provoke motion. The problem is analogous to standing in front of a mass of people with an unpleasant task and yelling "any volunteers?" Everyone waits for someone to step else forward. As the silence stretches out, the pressure builds and eventually volunteers step forward. On an email list, though, no one can hear the silence! My second email was an attempt to make the silence palpable:

> Just an update. There are 700 people on this mailing list currently. As of this morning, I have received zero (0) responses on this. [Full email...](http://lists.osgeo.org/pipermail/postgis-users/2005-June/008316.html)

At this point the dam finally broke and multiple companies came forward to contribute. Some contributors were companies that use PostGIS in their operations and could actually anticipate the future need for improved concurrency. This was classic enlightened self-interest, and my only disappointment was that such a relatively small cross-section of the PostGIS user community was capable or interested in seeing the long term benefit of the short term investment.

Other contributors signed on purely because it was the "right thing to do". This was also a form of enlightened self-interest, but one with a **much** broader view of future personal benefit.  The best example of this was [Cadcorp](http://www.cadcorp.com/), a spatial software company from the UK. Cadcorp makes proprietary GIS software. Cadcorp does not even use PostGIS themselves (except for testing). But, their clients do use PostGIS, and their product can act as a PostGIS data viewer and editor. Cadcorp invested in improving PostgreSQL, because it would improve PostGIS, which would improve their clients experience of using their software with PostGIS, which would (in the long view) enhance the value of their software. Now **that** is seeing the big picture.

The final totals were both quite good (about $8000 total contributions, with no individual contribution exceeding $2000) and not so good (only 9 contributing companies given 700+ members on the postgis-users mailing list).

The final technical results were great! Index recovery from system crashes now works transparently, and performance under concurrence read/write does not scale into a brick wall anymore.

I am pleased that this work got done, but I think the experience has taught me a few things about drumming shared contributions out of the community:

* A sense of urgency is required. The work had to be done before the PostgreSQL 8.1 release, or a whole release cycle would go by before we had an opportunity to get this into PostgreSQL again.
* A visible target would help. Having a "United Way thermometer" would probably have been a good thing. Having a fixed funding target would also help.
* A well-written prospectus helps. I did not have one to start, but did one up and it was used by a number of technical community members to get approval from their non-technical managers.
* A thick skin would help (I don't have one). The number of people who will free-ride is very high, and even some very deep pocketed organizations will free-ride. This is deeply annoying when you see individuals and smaller organizations coming to the table generously, but there is nothing to be done about it.

So now we are done, the [press release](http://www.refractions.net/news/index.php?file=20051003.data) is written, and hopefully we will have an article about this on [Newsforge](http://programming.newsforge.com/programming/05/10/12/1815254.shtml) soon!