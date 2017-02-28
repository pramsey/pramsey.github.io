---
layout: post
title: Two Thoughts About Enterprise IT
date: '2017-02-27T08:00:00-08:00'
author: Paul Ramsey
category: politics
tags:
- it
- enterprise
- bc
comments: True
image: "2017/overpass.jpg"
---

While thinking about the failure of the Cerner roll-out in Nanaimo, where an expensive COTS electronic health record (EHR) system [has been withdrawn](http://www.cbc.ca/news/canada/british-columbia/island-health-ihealth-nanaimo-1.3995300) after the medical staff rejected it, I have had a couple thoughts.

## Origins Matter

As I [noted in my post](/2017/02/nanaimo-ihealth.html), I actually expected the Cerner roll-out on Vancouver Island to go fine. Proven software, specialized company, no shortage of cash. But it didn't go fine. Among the complaints were things you'd expect to have been ironed out of a mature product ages ago: data entry efficiency, user-friendly displays of relevant data at relevant places, plain old system speed and responsiveness.

Why would a system rolled out in multiple US hospitals display these drawbacks? 

I'm wondering if some of the issue might be the origin story: Cerner is an EHR developed and deployed first in the USA. As such, one of the main **value propositions** of the system would be the fine-grained tracking and management of **billable events**. To the people purchasing the system, the hospital managers, the system would pay for itself many times over just by improving the accounting aspect of hospital management. Even if it made patient care **less** efficient, the improvement in billing alone could make the system fiscally worthwhile.

Recently, a colleague told me about the ambulance dispatch system BC procured a decade ago. Like Cerner, it was a US system. It handled dispatch fine, and still does. What was odd the system was that when you cracked open the user manuals, over 75% of the material was about how to configure and manage **billing**. The primary IT pain point for these US organizations is the incredibly complicated accounting issues associated with their multiple-payer private health insurance system, and the system reflects that.

What I'm getting at here is that if you go to a US reference customer for one of these systems and ask "how did it work for you, was it good?", when they answer "it is great, it has really made things better!" what **they** mean by better might not be what **you** might mean by better, at least not 100%.

<img src="{{ site.images }}{{ page.image }}" alt='{{ page.title }}' />

## Cost of Safe, Proven Systems

My second thought on the Cerner roll-out was about the timelines associated with software procurement, particularly when the goal is a "safe, proven choice". IT managers -- particularly ones who are, deep in their hearts, afraid of technology -- like a safe, proven choice. They like software that someone else with a similar business is already using, in a similar way.

When you're talking about big production systems, that may take a couple years to set up, and another couple years to roll out progressively to a large front-line staff, there's a number of big lags:

* If you take two years to configure and a year to roll out, the software will be three years old before your staff is all using it.
* Your procurement process will itself probably take a year.
* If during procurement, you only consider software that has been in operation for a year somewhere else, that adds a year.
* The organization you are using as your reference will in turn have taken 3 years to prepare and roll-out.
* So, assuming the software was brand new when the **reference** organization chose it, your staff will be getting software at least 8 years old by the time your roll-out is complete.

This is more-or-less exactly what happened to the Ministry of Children and Families [in the ICM procurement](/2012/06/more-icm.html). 

The software that runs their basically "brand new" system (I believe final roll-out was officially finished last year) is now over a decade old, and shows it.

The reason consumer-facing systems are always *au courant*, lovely and fast, is because they are maintained by dedicated teams who are charged with continuous improvement. As long as we purchase systems like we build bridges, as a [one-time capital expense](/2012/12/is-building-enterprise-systems-capital.html) followed by decades of disintigration and then replacement, we can expect our enterprise systems to lag far far behind. 


