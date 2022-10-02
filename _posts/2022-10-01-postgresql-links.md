---
layout: post
title: 'PostgreSQL Internals Resources'
date: '2022-10-01T00:00:00-08:00'
author: Paul Ramsey
category: technology
tags:
- postgres
- hacking
comments: True
image: "2022/machine.jpg"
---

I had coffee with an IT colleague here in Victoria last week, and he was interested in getting into core PostgreSQL programming. "What resources would you recommend I look at?"

That's... a hard question!

PostgreSQL is a **huge** code base with a **multi-decade** history. I've been poking around the edges for almost 10 years and feel comfortable with the extension APIs, foreign data wrappers, access methods APIs, some system catalogue stuff... maybe 5% of the surface area of the beast?

![complex]({{ site.images }}/2022/machine.jpg)

So, what advice for someone who wants to dive much much deeper than that?

**First**, start with the vision, and read "[The Design of Postgres](https://dsf.berkeley.edu/papers/ERL-M85-95.pdf)" (Stonebraker & Rowe, 1985) to get a sense of what distinguished Postgres from its predecessors: complex objects; user extensibility; and active database facilities; all while retaining relational concepts.

**Second**, take a run through the Bruce Momjain's ["internals" presentations](https://momjian.us/main/presentations/internals.html). These tend to be a little older, Bruce hasn't been doing deep core work for a while, but he's an expert teacher and explainer, so they are useful to get a feel for the shape of things. In a similar (and more recent) vein, my colleague Stephen Frost [walks through the code base](https://www.youtube.com/watch?v=51yez5gBFmI) in this 2018 talk about adding a new feature to PostgreSQL.

**Third**, consider spending some time with "[The Internals of PostgreSQL](http://www.interdb.jp/pg/)". This is a very detailed look at PostgreSQL subsystems, including header structures and data flow. As with any book, it may have already drifted a bit from the particulars of current PostgreSQL, but there is **no other** resource I know that even **attempts** to explain internals at this granularity.

**Fourth**, the source code itself is an amazing resource, and the commentary in header files and function descriptions is very good. The incredibly detailed and stringent source code review process of the PostgreSQL community not only expects good code, but also good **documentation of what the code does**. I'm not sure how much this can be traced back to the influence of [Tom Lane](https://en.wikipedia.org/wiki/Tom_Lane_%28computer_scientist%29) (whose comments are frequently complete technical manuals) but regardless the culture of good internal documentation is in place, and makes the code as "approachable" as a system of this complexity could hope to be.

Now things get harder. 

![conferences]({{ site.images }}/2022/conferences.jpg)

Conference talks are a moving target, because they tend to focus on the leading edge of things, but there are some community members who regularly give talks about their work on core topics, that must necessarily explain **how things work** in order to contextualize things.

Unfortunately, PostgreSQL conferences have a habit of ... not making recordings! So there's relatively little online. I have seen some amazing talks (the multi-session query planner master class [Tom Lane gave at PgCon 2011](https://www.pgcon.org/2011/schedule/events/350.en.html) sticks out) but most of them are lost to the ages. 

The best conference to go to for core technical content is undoubtedly [PgCon](https://www.pgcon.org/). (I will see you there this spring!)

COVID robbed us of many things, but it did cause PgCon to [record and publish](https://www.youtube.com/c/PgconOrg/videos) a number of standout technical talks that might otherwise have never been available.

Here's the presenters I always mark down in my program and rush to get a seat for:

* Andres Freund, who while hammering out incredibly hard technical work still makes time to explain what he is up to. 
  * [Asynchronous IO](https://www.youtube.com/watch?v=CD0w3gWBF7s)
  * [Plugable Table Storage](https://www.youtube.com/watch?v=mTfvA9EQIz8)
  * [Postgres JIT 2018](https://www.youtube.com/watch?v=-rpsboLc8wU)
  * [Postgres JIT 2017](https://www.youtube.com/watch?v=v3NAJOFi2jU)
* Robert Haas, who keeps pushing really important things from his perch as EDB CTO
  * [Concurrent DDL](https://www.youtube.com/watch?v=kbtkKh9B7eo)
  * [What's in a Plan](https://www.youtube.com/watch?v=YH0zRk7NSfE)
* Amit Kapila, who is quietly banging out impressive work every release
  * [Hash Indexes](https://www.youtube.com/watch?v=SCaBmBbLTPQ)
* Melanie Plageman, who creates jaw droppingly good explanations of really hard topics (the query planner talk blew my mind)
  * [Intro to Postgres Planner](https://www.youtube.com/watch?v=j7UPVU5UCV4)
  * [work_mem](https://www.youtube.com/watch?v=mA8ODr4mAwo)
* Peter Geoghegan, who goes right to the foundations and builds things up (unfortunately the btree talk he gave, which was a tour de force, is not online, perhaps this nbtree talk is an acceptable substitute)
  * [nbtree](https://www.youtube.com/watch?v=p5RaATILoiE)

I would also go to any talk Tom Lane felt like giving. And Thomas Vondra, and Thomas Munro, and Oleg Bartunov. 

![hike]({{ site.images }}/2022/hike.jpg)

Learning the PostgreSQL code base is a journey of a million steps, that's for sure. One thing that all my effective personal learning has had in common is a **practical need**. My learning has been in support of some **actual work** that needed to be done for my employer of the moment. It had **motivation**, a **start** point and an **end** point. That was really helpful.

Best of luck in your PostgreSQL journeys!

