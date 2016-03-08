---
layout: post
title: The Tyranny of Environment
date: '2014-12-02T13:22:00.001-08:00'
author: Paul Ramsey
category: technology
tags:
- postgis
- environment
modified_time: '2014-12-02T13:22:26.114-08:00'
blogger_id: tag:blogger.com,1999:blog-14903426.post-6133333700312407616
blogger_orig_url: http://blog.cleverelephant.ca/2014/12/the-tyranny-of-environment.html
comments: True
---

<img src="http://i.technet.microsoft.com/cc162526.fig01(en-us).gif" style="float: right; padding: 10px"/>

Most users of PostGIS are safely ensconsed in the world of Linux, and their build/deploy environments are pretty similar to the ones used by the developers, so any problems they might experience are quickly found and removed early in development.

Some users are on Windows, but they are our most numerous user base, so we at least test that platform preemptively before release and make sure it is as good as we can make it.

And then there's the rest. We've had a passel of FreeBSD bugs lately, and I've found myself doing Solaris builds for customers, and don't get me started on the poor buggers running AIX. One of the annoyances of trying to fix a problem for a "weird platform" user is just getting the platform setup and running in the first place.

So, having recently learned a bit about [vagrant](https://www.vagrantup.com/), and seeing that some of the "weird" platforms have boxes already, I thought I would whip off a couple vagrant configurations so it's easy in the future to throw up a Solaris or FreeBSD box, or even a quick Centos box for debugging purposes.

I've just been setting up my [Solaris Vagrantfile](https://github.com/pramsey/postgis-vagrant/blob/master/solaris/Vagrantfile) and using my favourite Solaris crutch: the [OpenCSW](http://opencsw.org/) software repository. But as I use it, I'm not just adding the "things I need", I'm implicitly **choosing an environment**:

* my `libxml2` is from OpenCSV
* so is my `gcc`, which is version 4, not version 3
* so is my `postgres`

This is convenient for me, but what are the chances that it'll be the environment used by someone on Solaris having problems? They might be compiling against libraries from `/usr/sfw/bin`, or using the Solaris `gcc-3` package, or any number of other variants. At the end of the day, when testing on such a Solaris environment, will I be testing against a real situation, or a fantasyland of my own making?

For platforms like Ubuntu (apt) or Red Hat (yum) or FreeBSD (port) where there is One True Way to get software, the difficulties are less, but even then there is no easy way to get a "standard environment", or to quickly replicate the combinations of versions a user might have run into that is causing problems (`libjson` is a current source of pain). [DLL hell](http://en.wikipedia.org/wiki/DLL_Hell) has never really gone away, it has just found new ways to express itself.

(I will send a psychic wedgie to anyone who says "docker", I'm not kidding.)