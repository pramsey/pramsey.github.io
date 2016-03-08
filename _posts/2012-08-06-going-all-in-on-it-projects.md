---
layout: post
title: Going "All In" on IT Projects
date: '2012-08-06T15:10:00.002-07:00'
author: Paul Ramsey
tags:
- enterprise IT
- it
modified_time: '2013-07-18T09:29:50.685-07:00'
blogger_id: tag:blogger.com,1999:blog-14903426.post-4304953723282430243
blogger_orig_url: http://blog.cleverelephant.ca/2012/08/going-all-in-on-it-projects.html
comments: True
---

I was thinking about IT project failure this weekend (OK, actually I was thinking about the [ICM project](http://blog.cleverelephant.ca/2012/06/more-icm.html), but you can see how I got there) and did a little Googling around on failure rates.

The estimated range of failure rates is surprising large, from a [high of 68%](http://www.zdnet.com/blog/projectfailures/study-68-percent-of-it-projects-fail/1175) down to a [lower bound around 30%](http://www.zdnet.com/blog/projectfailures/new-it-project-failure-metrics-is-standish-wrong/513). A lot of the variability is definitional (what is a "failure", after all?) and some of it seems to be methodological (who are you asking, and what are you asking them about?). However the recent studies seem to cluster more around the lower range.

The web references are all pretty confident that **poor requirements gathering** is the root of most of the problems, and I can see some validity in that, but the variable I keep coming back to in my mental models is **project size**. The [Sauer/Germino/Reich](http://www.zdnet.com/blog/projectfailures/new-it-project-failure-metrics-is-standish-wrong/513) paper takes on project size directly, and finds that the odds of failure (or non-success) go up to steeply as project size increases. 

Sadly, they don't find that there is an optimal small-team size that brings down failure rates to what might be considered an acceptable level: even small-team projects fail at a rate of at best 25%.

So this brings me back to my weekend musings: suppose you have a capital budget of, say, [$180M](http://blog.cleverelephant.ca/2012/05/take-smaller-bites.html). Even assuming all projects of all sizes fail at the same rates (and as we've seen, they don't) **if you bet all your money on a single project there's at least a 25% chance that you'll lose 100% it in a failure.** 

On the other hand, if you split your money into multiple smaller independent projects (and smaller teams) the impact of any one failure goes way down. Rather than losing your whole capital budget (and, we hope, your job) in a massive IT meltdown, you lose a few of your sub-projects, about 25% of your total budget.

Fundamentally, organizing a project to deal with the 100% certainty of a 25% failure rate is a more defensible approach that gambling with the 25% chance of a 100% failure rate. 

Don't just go "all in", don't bet it all on black, know that the unknowns inherent in software development make it a probabilistic process, not a deterministic one, and plan appropriately.

**End note:** Expecting failure, and planning for it, makes more sense than crossing your fingers and hoping you'll dodge the bullet. And it surfaces some attractive approaches to achieving success: small independent teams can be evaluated and measured against one another, allowing you to find and better utilize your top performers; because you now expect some teams to fail, you can insulate yourself against some failures by running duplicate teams on critical sub-projects; because small failures are non-fatal, they can be used as learning tools for succeeding rounds. The similarity to [agile development](http://en.wikipedia.org/wiki/Agile_software_development) is probably no coincidence. 
{: .note }
