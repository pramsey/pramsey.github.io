---
layout: post
title: Benchmarks, Damn Benchmarks and Statistics
date: '2008-03-17T13:24:00.000-07:00'
author: Paul Ramsey
tags: 
modified_time: '2008-03-17T14:08:30.985-07:00'
blogger_id: tag:blogger.com,1999:blog-14903426.post-3411006186594423942
blogger_orig_url: http://blog.cleverelephant.ca/2008/03/benchmarks-damn-benchmarks-and.html
---

Seen on the #mapserver IRC channel:

> "hey guys I have mapserver running fine on a vehicle tracking application, what I want to know is the requirements for mapserver. Let say 100 connections on the same time. I have 2 GB RAM , Dual Core 3GHz procesor, what do you say, Will it be enough?"

Well, enough for what?  At least one variable is missing, and that's the expected response time for each request.  If I am allowed to take a week per response, I can really lower the hardware requirements!

<img src="http://wvs.topleftpixel.com/photos/2007/10/book-of-lies_subway.jpg" width="350" height="263" />

Benchmarking an application is a tricky business, and there are lots of ways to quantify the robustness of an application.  My favorite method is a holistic method that takes into account the fact that most of the time the load generators are human beings.  This won't work for pure "web services", where the requests can be generated automatically by a wide number of different clients.

Step one is to generate a baseline of what human load looks like.  Working through your test plan is one way to achieve this, though you might want to game out in your head what a "typical" session looks like rather than a "complete" session that hits every piece of functionality once.  Call this your "human workload".

1. Empty your web server logs.
2. Sit down and run the "human workload" yourself, at a reasonable speed. You know the application, so you probably click faster than an average user, no matter, it doesn't hurt to bias a little in the fast direction. When you are done with your session note the elapsed time, this is your "human workload time".
3. Now, take your web server logs and run them back against the server using a tool like curl.  This generates all the requests from your human session, but forces the server to execute them as fast as possible.  When it finishes, note the elapsed time, this is your "cpu workload time".
4. Finally, divide your "human workload time" by your "cpu workload time". The result is how many computers like the one you just ran your test on are needed to support each human.  If the answer is 0.2, then you can support 5 humans on your test machine.

Obviously, this is a very simple test metric, but it has the advantage of extreme ease-of-application and a tight binding between what is being measured and what the real world will finally hit the application with.