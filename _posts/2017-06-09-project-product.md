---
layout: post
title: Project or Product?
date: '2017-06-09T08:00:00-08:00'
author: Paul Ramsey
category: technology
tags:
- enterprise
- it
- agile
comments: True
image: "2017/product-manager-vs-project-manager.jpg"
---

There are several nuggets in [this webinar by David Eaves](https://kennedyschool.webex.com/kennedyschool/lsr.php?RCID=1c359d844bd91601a746dfb9fc860e92), but the one that really tickled my brain was the distinction between two almost identically named roles: **project manager** and **product manager**. 

The **lexical** difference is, of course, very small:

    # SELECT levenshtein('project manager', 'product manager');
    
     levenshtein 
    -------------
               2
    (1 row)

The **functional** difference is extremely large:

* The **project** manager is optimizing for **budget and schedule**. Is the project on time? Are you delivering according to your agreed schedule? Then your project manager is doing a good job.
* The **product** manager is optimizing for **user satisfaction**. Is the product fast and easy to use? Are the users happy to adopt it? Then your product manager is doing a good job.

The BC government has a [project management office](https://dir.gov.bc.ca/gtds.cgi?show=Branch&organizationCode=BCS&organizationalUnitCode=PMO) and in some respects it shows: big projects like ICM, MyEdBC and the iHealth systems have been delivered within their (very long) schedules and (incredibly huge) budget envelopes (plus or minus a bit). 

On the other hand the projects above have also been catastrophically bad for users, rolling out with big performance failures and lots of of user push-back. In the case of the Nanaimo iHealth project, doctors have actually been [suspended](http://www.cbc.ca/news/canada/british-columbia/nanaimo-ihealth-problems-1.4142020) for refusing to use the system. Now there's a system that needs some user acceptance testing!

The "product manager" role is one that's very common in the private sector IT world, certainly at the big Silicon valley firms and the last two start-ups I've worked with. It's not one I've seen much in the government space, with the exception of "digital transformation" carve-outs like [GDS](https://gds.blog.gov.uk/) or [USDS](https://www.usds.gov/).

<img src="{{ site.images }}{{ page.image }}" alt='{{ page.title }}' />

Delivering junk on time and on budget isn't success, and neither is delivering a great system 2 years late and 100% over budget. Some kind of co-equal arrangement [seems like a good idea](https://blog.aha.io/the-product-manager-vs-project-manager/):

> Product and project managers see the same work through different lenses. And that’s a good thing when you are trying to achieve something special like bringing a new product to market as I was. But they both work for the same team. And when they join forces to collaborate, everyone benefits and the company wins.<br/>- [Ron Yang](https://blog.aha.io/author/ron-yang)



