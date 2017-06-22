---
layout: post
title: The Open Source Support Company Trap
date: '2017-06-22T08:00:00-08:00'
author: Paul Ramsey
category: technology
tags:
- open source
- support
comments: True
image: "2017/support.png"
---

[Matt Asay](https://twitter.com/mjasay) asks a question about big data vendors, who are from a business model point-of-view mostly "open source support" companies: HortonWorks as a pure-play and others as open-core and enhanced-oss models.

<blockquote class="twitter-tweet" data-lang="en"><p lang="en" dir="ltr">Is the problem that orgs roll-their-own Spark/etc. (self-support on OSS)? Or maybe most orgs simply aren&#39;t doing much (yet) w/ big data? <a href="https://t.co/9RGZyEUaV4">https://t.co/9RGZyEUaV4</a></p>&mdash; Matt Asay (@mjasay) <a href="https://twitter.com/mjasay/status/877926661399949312">June 22, 2017</a></blockquote>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>

My experience has been that open source support companies fall into a market trap. They are supporting good projects, that are popular and widely deployed. It seems like a good place, but the market keeps constantly screwing them.

## TL;DR

Potential open source support customers are either:

* Small enough to need your expert support, but too small and cheap to supply company-supporting levels of revenue; or,
* Large enough to figure it out for themselves, so either take a quick hit of consulting up front or just ignore you and self-support from the start.


## Small Customers Suck

Small customers lack the technical wherewithal to use the product unassisted, so they need the support, but they are both highly price sensitive while also being a large drain on support hours (because they really need a lot of help). 

You can drop your prices to try and load up a lot of these ("how do we do it? volume!") but
there are rarely enough fish in the pool to actually run the size of business you need to achieve sustainability. 

How large? Large enough that the recurring revenue is enough to support sales, marketing, cost of sales, and a handful of core developers who aren't tied to support contracts. Not huge, but well beyond the scale of a dev-and-friend-in-basement.
{: .note }

If you *do* drop your prices to try and bring in the small customers you immediately run into a problem with big customers, who will want big customer questions answered at your small customer price point.

## Big Customers Suck, Then Leave

Big customers are frequently drawn to the scaling aspects of open source: deploy 1 instance, deploy 100, the capital cost remains the same. 

In theory, there should be room in there for a "one throat to choak" support opportunity for big customers with big deployments, and with competent sales work up front, a good support deal will monetize at least *some* of the complexity inherent in a large deployment. 

In practice, instead of being long term recurring revenue, the big customers end up being short term consulting gigs. A deal is signed, the customer's team learns the ropes, with lots of support hours from top level devs on your team, and the deployment goes live. Then things settle down and there is a quick scaling back of support payments: year one is great, year two is OK, year three they're backing away, year four they're gone.

While there is room to grow a business on this terrain, particularly if the customers are Really Really Big, the constant fade-out of recurring revenue means that the business model is that of a high-end consultancy, not a recurring-revenue support company.

