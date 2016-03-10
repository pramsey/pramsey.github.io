---
layout: post
title: Big Data and Data Science Piss Me Off
date: '2015-08-10T18:47:00.000-07:00'
author: Paul Ramsey
category: technology
tags:
- statistics
- hadoop
- r
- data science
modified_time: '2015-10-28T09:44:04.304-07:00'
thumbnail: http://2.bp.blogspot.com/-1V7vEO_LsZc/VjD7F3ZypDI/AAAAAAAAAjQ/piC2pyiUQ40/s72-c/350px-Normal_Distribution_PDF.svg.png
blogger_id: tag:blogger.com,1999:blog-14903426.post-3161806318875477758
blogger_orig_url: http://blog.cleverelephant.ca/2015/08/big-data-and-data-science-piss-me-off.html
comments: True
---

Get off my lawn!

<blockquote class="twitter-tweet" lang="en"><p lang="en" dir="ltr">.<a href="https://twitter.com/galvanize">@galvanize</a> bringing its 12-week Data Science boot camp to Denver. &#10;&#10;You still stoked about studying for the GRE ? <a href="http://t.co/EMFgUq0OFV">pic.twitter.com/EMFgUq0OFV</a></p>&mdash; Brian Timoney (@briantimoney) <a href="https://twitter.com/briantimoney/status/630906976508121088">August 11, 2015</a></blockquote>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>

I don't talk about this much, but I actually trained in statistics, not in computer science, and I've been getting slowly but progressively weirded out by the whole "big data" / "data science" thing. Because so much of it is bogus, or boys-with-toys or something.

Basically, my objections to the big data thing are the usual: probably your data is not big. It really isn't, and there are some [great](https://www.chrisstucchio.com/blog/2013/hadoop_hatred.html) [blog](https://news.ycombinator.com/item?id=5696451) [posts](https://www.compose.io/articles/you-dont-have-big-data/) all about [that](https://www.chrisstucchio.com/blog/2013/hadoop_hatred.html).

So that's point number one: most people blabbing on about big data can fit their problem onto a big vertical machine and analyze it to their heart's content in R or something.

Point number two is less frequently touched upon: sure, you have 2 trillion records, but why do you need to look at all of them? The whole point of an education in statistics is to learn how to reason about a population using a **random sample**. So why are all these alleged "data scientists" firing up massive compute clusters to summarize **every single record in their collections**?

<img border="0" src="http://2.bp.blogspot.com/-1V7vEO_LsZc/VjD7F3ZypDI/AAAAAAAAAjQ/piC2pyiUQ40/s320/350px-Normal_Distribution_PDF.svg.png" style="float:right;width:320px;height:205px;margin:10px;" />I'm guessing it's the usual reason: because they can. And because the current meme is that they should. They should stand up a 100 node cluster on AWS and bloody well count all 2 trillion of them. Because: CPUs.

But honestly, if you want to know the age distribution of people buying red socks, draw a sample of a couple hundred thousand records, and find out to within a fraction of a percentage point 19-times-out-of-20. After all, you're a freaking "data scientist", right?