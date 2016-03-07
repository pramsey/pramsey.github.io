---
layout: post
title: Into the Clouds
date: '2008-04-21T15:11:00.000-07:00'
author: Paul Ramsey
tags: 
modified_time: '2008-04-21T16:05:00.986-07:00'
blogger_id: tag:blogger.com,1999:blog-14903426.post-3166812096797693987
blogger_orig_url: http://blog.cleverelephant.ca/2008/04/into-clouds.html
---

One of my favorite software articles ever is Joel Spolsky's "[Law of Leaky Abstractions](http://www.joelonsoftware.com/articles/LeakyAbstractions.html)", which is about the (unavoidable) dangers of building on software abstractions.  Unavoidable, because the whole edifice of programming is built on layer upon layer of abstractions.  Dangerous, because not having an understanding of what is happening below your working abstraction can lead to unintentionally terrible mistakes.

The release of Google's [App Engine](http://code.google.com/appengine/) and earlier releases of various components of [Amazon Web Services](aws.amazon.com/ ) (storage, queueing, database, computing) serve as a reminder that the process of adding abstraction has not come to a stop, but it has migrated for the moment to a new field.  Instead of adding a programming layer, Google and Amazon have added a **deployment** layer of abstraction &ndash; you no longer need to know or care what machine your application is running on, or where that machine is.

<img src="http://www.siskiyous.edu/shasta/env/clouds/jecumm.jpg" style="float:right;padding:10px;" />As with other layers of abstraction, this new deployment abstraction will introduce new (yet to be discovered) programming pitfalls, but it will also liberate developers (and the businesses that hire them) to spend less time (and money) mucking with operating system set-up, database tuning, fail-over and replication systems, and other necessary details of server administration.  The tasks involved in setting up a reliable server farm are both irrelevant to most aspects of application development and highly repetitive &ndash; ripe for being abstracted away, in other words.

As with previous abstractions (microcode, higher level languages, operating systems, object/relational mappings) the "platform as a service" (PaaS) abstraction removes a category of complication and replaces it with a new choice: what web service platform (abstraction) shall I use for my application?

Do I tie myself to Google? Amazon? [Sun](http://lin-ear-th-inking.blogspot.com/2008/04/whos-conspicuously-absent-from-paas.html)? Microsoft?

If all this sounds vaguely familiar, that's because it is exactly the same decision process involved in choosing which implementation of a persistence abstraction (Oracle? MySQL? PostgreSQL?) or process management/filesystem abstraction (Linux? Solaris? Windows?) or O/R abstraction (Hibernate? JPOX?) you are going to use for your application.

And the same trade-offs apply.  Do I like the implementation of this abstraction? Do I trust the vendor (to not screw me, to not go out of business)? Can I afford it?

If there is one thing missing from the PaaS tapestry so far (not counting Microsoft's no-doubt-forthcoming entry to the field), it is a strong "open source" thread.  Unlike open source software, open source PaaS can't be replicated at zero cost (servers must be purchased, plugged in, cooled, etc) but PaaS can go "open sourceish" via: standard service APIs, allowing users to migrate easily from provider to provider; standardization on some open source components that fit the PaaS model (like [Hadoop](http://hadoop.apache.org/core/) and Linux virtualization as already demonstrated by AWS).

Open source tends to be fast-follower, so I expect third-party deployable versions of the App Engine and AWS APIs will come soon enough.  To me, the last couple years feel like 1995 all over again &ndash; just when you think you understand the structures of computing, the core premises are overthrown and everything is fresh again.  In 1995 it was the internet and Linux shaking the foundations of the Windows hegemony; this time it is the cloud, wiping away the last vestiges of local computing context.