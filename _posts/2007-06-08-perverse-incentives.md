---
layout: post
title: Perverse Incentives
date: '2007-06-08T14:13:00.000-07:00'
author: Paul Ramsey
tags: 
modified_time: '2007-06-08T14:30:30.924-07:00'
blogger_id: tag:blogger.com,1999:blog-14903426.post-6713256241902031104
blogger_orig_url: http://blog.cleverelephant.ca/2007/06/perverse-incentives.html
---

I am sure others have beaten this horse before, but I just have to take a whack at it.

Oracle, ESRI and others license their server-side technology on the basis of dollars-per-processing-unit, usually in the form of <tt>Constant * NumberOfCores * Price</tt>.  For example, the [base price for Oracle Enterprise](http://www.oracle.com/corporate/pricing/technology-price-list.pdf) (which you need to do high-end processing, like, say, computing a buffer (*snort*)) is <tt>0.5 * NumberOfCore * $40,000</tt>.

OK, time for the quiz-show section of our show: Let's say you buy yourself some Oracle, and start using it.  You find a particular use case that is slow, but important to you.  You call up your Oracle representative, what will his answer be: (a) we'll make it faster or (b) you need more processing power.  Remember, this is not a trick question, and he does earn commissions on sales.

Take it up a level.  From a strategic financial point of view, all R&amp;D dollars spent on on performance improvements actually constitute a double cost: the cost of doing the development; and, the cost of lost revenue due to fewer upgrades.  If I am the CEO, do I encourage my managers to spend money on performance tweaks, which will reduce upgrade revenue, or on new features, which will drive new sales?