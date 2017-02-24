---
layout: post
title: Super Expensive Cerner Crack-up at Island Health
date: '2017-02-19T08:00:00-08:00'
author: Paul Ramsey
category: politics
tags:
- it
- enterprise
- bc
- transformation
- health
- cerner
- nanaimo
comments: True
image: "2017/ihealth-houson.jpg"
---

[Kansas City](https://en.wikipedia.org/wiki/Cerner), we have a problem. 

<img src="{{ site.images }}{{ page.image }}" alt='{{ page.title }}' width="528" height="206" />

A year after roll-out, the Island Health electronic health record (EHR) project being piloted at Nanaimo Regional General Hospital (NRGH) is **abandoning electronic processes and returning to pen and paper**. An alert reader forwarded me this note from the Island Health CEO, sent out Friday afternoon:

> The Nanaimo Medical Staff Association Executive has requested that the CPOE tools be suspended while improvements are made. An Island Health Board meeting was held yesterday to discuss the path forward. The Board and Executive take the concerns raised by the Medical Staff Association seriously, and recognize the need to have the commitment and confidence of the physician community in using advanced EHR tools such as CPE. We will engage the NRGH physicians and staff on a plan to start **taking steps to cease use of the CPOE tools and associated processes.** Any plan will be implemented in a safe and thoughtful way with patient care and safety as a focus.<br/>-- [Dr. Brendan Carr to all Staff/Physicians at Nanaimo Regional General Hospital]({{ site.images }}2017/ihealth-snap.png)

This extremely expensive back-tracking comes after a year of struggles between the Health Authority and the staff and physicians at NRGH.

After [two years](http://ihealth.islandhealth.ca/2014/09/canadian-healthcare-technology-aritcle-island-health/) of development and testing, the system was rolled out on March 19, 2016. Within a couple months, staff had moved beyond internal griping to griping to the media and attempting to force changes through bad publicity.

> Doctors at Nanaimo Regional Hospital say a new paperless health record system isn't getting any easier to use.
> 
> They say the system is cumbersome, prone to inputting errors, and has led to problems with medication orders. 
> 
> "There continue to be reports daily of problems that are identified," said Dr. David Forrest, president of the Medical Staff Association at the hospital.<br/>-- CBC News, [July 7, 2016](http://www.cbc.ca/news/canada/british-columbia/nanaimo-hospital-doctors-paperless-system-1.3668146)

Some of the early problems were undoubtedly of the "critical fault between chair and keyboard" variety -- any new information interface quickly exposes how much we use our mental muscle memory to navigate both computer interfaces and paper forms. 

<img src="{{ site.images }}/2017/ihealth-computer.jpg" alt='IHealth Terminal &amp; Trainer' width="531" height="399" />

So naturally, the Health Authority stuck to their guns, hoping to wait out the learning process. Unfortunately for them, the system appears to have been so poorly put together that no amount of user acclimatization can save it in the current form.

An [independent review](http://ihealth.islandhealth.ca/wp-content/uploads/2016/11/ihealth-review-2017.pdf) of the system in November 2016 has turned up not just user learning issues, but critical functional deficiencies:

* High doses of medication can be ordered and could be administered. Using processes available to any user, a prescriber can inadvertently write an order for an unsafe dose of a medication.
* Multiple orders for high-risk medications remain active on the medication administration record resulting in the possibility of unintended overdosing.
* The IHealth system makes extensive use of small font sizes, long lists of items in drop-down menus and lacks filtering for some lists. The information display is dense making it hard to read and navigate.
* End users report that challenges commonly occur with: system responsiveness, log-in when changing computers, unexplained screen freezes and bar code reader connectivity
* PharmaNet integration is not effective and adds to the burden of medication reconciliation. 

The Health Authority committed to address the concerns of the report, but evidently the hospital staff felt they could no longer risk patient health while waiting for the improvements to land. Hence a very expensive back-track to paper processes, and then another expensive roll-out process in the future.

This set-back will undoubtedly cost millions. The EHR roll-out was supposed to proceed smoothly from NRGH to the rest of the facilities in Island Health [before the end of 2016](https://web.archive.org/web/20160316002551/http://ihealth.islandhealth.ca/about/). 

> This new functionality will first be implemented at the NRGH core campus, Dufferin Place and Oceanside Urgent Care on March 19, 2016. The remaining community sites and programs in Geography 2 and all of Geography 1 will follow approximately 6 months later. The rest of Island Health (Geographies 3 and 4) will go-live roughly 3 to 6 months after that.

Clearly that schedule is no longer operative. 

The failure of this particular system is deeply worrying because it is a failure on the part of a vendor, [Cerner](https://en.wikipedia.org/wiki/Cerner), that is now the primary provider of EHR technology to the BC health system. 

<img src="{{ site.images }}/2017/ihealth-cerner.jpg" alt='Cerner' width="528" height="297" />

When the IBM-led EHR project at PHSA and Coastal Health was "reset" (after spending $72M) by Minister Terry Lake in 2015, the [government fired IBM and turned to a vendor](http://vancouversun.com/news/staff-blogs/breaking-news-health-minister-says-he-read-riot-act-to-it-leaders-over-megaproject-problems-ibm-out-cerner-in) they hoped would be more reliable: EHR software maker [Cerner](https://www.cerner.com/).

Cerner was already leading the Island Health project, which at that point (mid-2015) was apparently heading to a successful on-time roll-out in Nanaimo. They seemed like a safe bet. They had more direct experience with the EHR software, since they wrote it. They were a health specialist firm, not a consulting generalist firm.

For all my concerns about failures in enterprise IT, I would have bet on Cerner turning out a successful if very, very, very costly system. There's a lot of strength in having relevant domain experience: it provides focus and a deep store of best practices to fall back on. And as a specialist in EHR, a failed EHR project will injure Cerner's reputation in ways a single failed project will barely dent IBM's clout.

There will be a lot of finger-pointing and blame shifting going on at Island Health and the Ministry over the next few months. The government should not be afraid to point fingers at Cerner and force them to cough up some dollars for this failure. If Cerner doesn't want to wear this failure, if they want to be seen as a true "[partner](https://web.archive.org/web/20160316061148/http://ihealth.islandhealth.ca/about/partnership-with-cerner/)" in this project, they need to buck up.

Cerner will want to blame the end users. But when data entry takes twice as long as paper processes, that's not end users' fault. When screens are built with piles of non-relevant fields, and poor layouts, that's not end users' fault. When systems are slow or unreliable, that's not end users' fault.

Congratulations British Columbia, on your latest non-working enterprise IT project. The only solace I can provide is that eventually it will probably work, albeit some years later and at several times the price you might have considered "reasonable". 


