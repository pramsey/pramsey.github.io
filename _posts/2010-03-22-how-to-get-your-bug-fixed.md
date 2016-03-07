---
layout: post
title: How to get Your bug fixed
date: '2010-03-22T09:47:00.000-07:00'
author: Paul Ramsey
tags: 
modified_time: '2010-03-22T21:00:19.476-07:00'
blogger_id: tag:blogger.com,1999:blog-14903426.post-3061670315433943057
blogger_orig_url: http://blog.cleverelephant.ca/2010/03/how-to-get-your-bug-fixed.html
---

Mike Leahy is providing a [textbook demonstration of bug-dogging](https://lists.osgeo.org/pipermail/postgis-users/2010-March/026147.html) on the PostGIS users list this week, and anyone interested in learning how to interact with a development community to get something done would do well to study it.

Some key points:

He does as much of the work in diagnosing the problem as possible, including combing through Google for references, [cutting down the test data](https://lists.osgeo.org/pipermail/postgis-users/2010-March/026171.html) as small as possible, trying to find smaller cases that exercise the issue.

He [responds](https://lists.osgeo.org/pipermail/postgis-users/2010-March/026173.html) [very quickly](https://lists.osgeo.org/pipermail/postgis-users/2010-March/026167.html) (you'll have to read the timestamps) to questions and [suggestions](https://lists.osgeo.org/pipermail/postgis-users/2010-March/026164.html) for gathering more information. Since the problem appears initially to manifest only on his machine, any delay on his part risks disengaging the folks helping him.

He prepares a sample database and query to allow the development team to easily replicate the situation on their machines. 

And he also gets lucky. The problem is replicable, and the discussion [catches the attention](https://lists.osgeo.org/pipermail/postgis-users/2010-March/026175.html) of Greg Stark, who recalls and digs up some changes Tom Lane made to PostgreSQL which in turn [leads me](https://lists.osgeo.org/pipermail/postgis-users/2010-March/026176.html) to find the one-argument-change that can [remove the problem](https://lists.osgeo.org/pipermail/postgis-users/2010-March/026176.html). Very lucky, really, it's unlikely I would have been able to debug it by brute force.

