---
layout: post
title: 'I am Metadata Man'
date: '2016-03-19T03:00:00-08:00'
modified_time: '2016-03-19T03:00:00-08:00'
author: Paul Ramsey
category: politics
tags:
- bc
- email
- foi
- smtp
- metadata
comments: True
image: "2016/metadataman.jpg"
---

I have been keeping a secret for the last couple years.

BC CIO Betty-Jo Hughes [knows my secret](https://www.leg.bc.ca/documents-data/committees-transcripts/20151118am-FIPPAReview-Victoria-n7):

> Though once considered benign to many, metadata found in government e-mail and server logs is beginning to generate interest from knowledgable freedom-of-information applicants who file requests for these logs spanning large time frames.

And Information Commissioner Elizabeth Denham [knows my secret](https://www.oipc.bc.ca/special-reports/1935): 

> In fact, my Office recently issued an Order on this very issue, in which an applicant requested metadata from message tracking logs relating to email traffic for several government ministries and public sector agencies.

I can no longer deny the truth: **I am Metadata Man**

<img src="{{ site.images }}{{ page.image }}" alt="{{ page.title }}" width="330" height="546" />

## The Origin Story

I donned my suit back in July of 2013. It was an interesting time:

* Elizabeth Denham had [reported](https://www.oipc.bc.ca/investigation-reports/1559) out on the FOI implications of the "[ethnic outreach scandal](http://www.cbc.ca/news/canada/british-columbia/leaked-documents-reveal-liberals-plan-to-win-ethnic-vote-1.1325543)" and included some interesting notes about the use and abuse of government e-mail. 
* A [scandal in Ontario](http://www.ctvnews.ca/politics/tech-expert-allegedly-linked-to-deleted-emails-had-contract-with-liberals-1.1753735) revolving around the deliberate deletion of e-mail records made me wonder about the persistance of log files as a kind of guarantee of data integrity.
* Edward Snowden had revealed that the US government was gathering [massive amounts of metadata](http://www.theguardian.com/world/2013/sep/30/nsa-americans-metadata-year-documents) about public citizens; we would later learn that the Canadian government also engages in this kind of surveilance (it [still does](https://s3.documentcloud.org/documents/711481/freedom-of-information-request-on-canadas-top.pdf#page=18)). 

I wondered if government had the same open attitude about its own metadata that it appeared to have for the general public's metadata.

Thanks to IT centralization, every mail sent or received by government goes through a handful of SMTP servers. Looking at headers on mail I had received from government, I could see the servers were running Microsoft Exchange. And like other servers, Exchange automatically generates logs of every e-mail processed. So I asked:

> Message tracking log files (files beginning with MSGTRK in %ExchangeInstallPath%TransportRoles\Logs\MessageTracking) from e7hub01.idir.bcgov, e7hub02.idir.bcgov, e7hub03.idir.bcgov, e7hub04.idir.bcgov, e7hub05.idir.bcgov, e7hub06.idir.bcgov, e7hub07.idir.bcgov, e7hub08.idir.bcgov, e7hub09.idir.bcgov. 
> <br />Date range is January 1, 2013 to July 3, 2013.

The log files do not contain email *contents*, only *metadata* such as:

* the sender email address
* the recipient email address
* the date and time the email transitted the server
* the unique message number for the email
* the subject line of the email (Microsoft Exchange only)

Mail server log files are not under the control of mail recipients and senders, they are under the control of central IT administrators. So while political staff can delete the mails they **receive** or the mails they **send**, they **cannot delete the log entries** that prove the emails existed in the first place.

Except for the subject line, which is easily stripped from the log file, there's little in any particular log entry that could be considered unreleasable under [FOI exceptions](http://www.bclaws.ca/civix/document/LOC/complete/statreg/--%20F%20--/Freedom%20of%20Information%20and%20Protection%20of%20Privacy%20Act%20[RSBC%201996]%20c.%20165/00_Act/96165_02.xml#division_d2e1078):

* no cabinet confidences
* no policy advice
* no personal information
* etc...

When each entry can be boiled to "John sent an e-mail to Jim on February 13, 2013", it's hard to see how any particular entry can be withheld. So I entertained the (na&#239;ve) hope that the whole corpus would be releasable post-haste.

Ha ha ha ha ha. Ha ha.


## The First Battle

The government initially attempted to deny the request based on "[Section 43](http://www.bclaws.ca/civix/document/LOC/complete/statreg/--%20F%20--/Freedom%20of%20Information%20and%20Protection%20of%20Privacy%20Act%20[RSBC%201996]%20c.%20165/00_Act/96165_04.xml#section43)" of the Act. 

> 43  If the head of a public body asks, the commissioner may authorize the public body to disregard requests under section 5 or 29 that <br />
> (a) would unreasonably interfere with the operations of the public body because of the repetitious or systematic nature of the requests, or <br />
> (b) are frivolous or vexatious.

Section 43 is supposed to protect public bodies from harassment. For example, if I submitted thousands of requests in an attempt to bury the government in paperwork, the requests could be denied under Section 43.

The [Ministry argued](http://s3.cleverelephant.ca/oipc/2014_s43_hearing/citz_submission/Initials%20Final.pdf) that they would have to manually review every line of the log files prior to release, and since the log files were 100's of millions of lines long, obviously that was an undue burden, so, "go away, Metadata Man!".

The size and detail in [Ministry response](http://s3.cleverelephant.ca/oipc/2014_s43_hearing/citz_submission/Initials%20Final.pdf) were the first hint of just how uneven this field of battle was going to be. 

* The Ministry fielded real, live lawyers, whose full-time job is to argue FOI cases. 
* They took actual affadavits from staff and submitted them as evidence.
* They cited relevant case law from both courts and previous FOI cases.
* They double-spaced it all and neatly numbered every paragraph!

However, they also called me "frivolous or vexatious", which was hurtful, so I felt duty bound to sit down and hammer out [a response](http://s3.cleverelephant.ca/oipc/2014_s43_hearing/F13-54010%20Ramsey%20Response.pdf). I too double-spaced and numbered every paragraph.

In the end, the Adjudicator **ignored** most of the arguments made by both the Ministry and by me, and [ruled](http://s3.cleverelephant.ca/oipc/2014_s43_hearing/OrderF14-13.pdf#page=6) that my request was neither "frivolous" nor "vexatious", according to definitions clarified in prior FOI rulings.

And so I learned another useful lesson about the FOI appeals process: not only was I heavily out-gunned from a legal skills and resources perspective, but also the decision might in the end hinge on a some fact I knew nothing about in the first place. 


## The Second Battle

Having lost the first round, the Ministry fell back to more defensible territory: [Section 22](http://www.bclaws.ca/civix/document/LOC/complete/statreg/--%20F%20--/Freedom%20of%20Information%20and%20Protection%20of%20Privacy%20Act%20[RSBC%201996]%20c.%20165/00_Act/96165_02.xml#section22), "a public body must refuse to disclose personal information to an applicant if the disclosure would be an unreasonable invasion of a third party's personal privacy".

If Section 22 can be found to apply to records in the log file, then the Ministry can circle back around and point to the volume of data and say "sorry Metadata Man, there's no way we can review all those records to remove the private bits".

The trouble with that argument, from the Ministry's point of view, is that any given record is completely anodyne: "John sent an e-mail to Jim on February 13, 2013". 

So they set about finding true example of personal information in the data, by having BC Statistics run network analyses on the log files and [comment on the network diagram](http://s3.cleverelephant.ca/oipc/2015_s22_hearing/citz_submission/Aff%20Monkman%20severed.pdf).

> From my review of the diagram, reporting structures are evident. In addition, relationships with individual outside the BC public service become evident. These may be business relationships or personal correspondance.
> 
> In my opinion, the graph also begins to hint at the sensitive information that might be revealed in this data set. In the lower centre, an individual has sent an email to "Fitness Centre". There may be other accounts in government of a much more sensitive nature.
> <br />&mdash; [Brad Williams Affidavit #1](http://s3.cleverelephant.ca/oipc/2015_s22_hearing/citz_submission/AFF%20Williams%20sworn%20Apr%2010-15.pdf)

To the staff in BC Stats who got to step out of the ordinary day-to-day grind and do network and relationship analyses to feed this process, depending on your level of intellectual curiousity: "your welcome"; or, "sorry".
{: .note }

My case was getting harder to argue, but not impossible. There was definitely some provable personal information in the corpus, but the Ministry was still unable to point to any particular record and say "there! that is personal and private". They were stuck hand-waving at potential "patterns of information" that **might** be there.

So [my counter-argument](http://s3.cleverelephant.ca/oipc/2015_s22_hearing/F14-58135-ramsey-response.pdf#page=9) acknowledged that while there might be **some** personal information in the data, the **public interest** in being able to monitor the actions of government (things like [deleting emails](/2016/03/fall-guy.html), and so on) **out-weighed the private interest** in keeping these thus-far-unproven data patterns private.

> The message tracking logs are an important example of a government record, in that they are a huge corpus of data which should, because of their uncontroversial nature (from, to, date, id) be immediately releasable, but because of the possibility of personal information patterns, have become subject to this contentious process. 
>
> Imagine a document warehouse full of boxes of completely uncontroversial, releasable files. Imagine that the government refuses to release the files, because an employee at the warehouse may have placed his university transcript in one of the boxes. They are not sure he did so or not, but the effort of searching all the boxes is too high, therefore none of the boxes is releasable.
> 
> The situation with email logs is fundamentally the same. The question is not whether the effort of searching the boxes is too high: that's a given, it's too high. The question is whether the potential presence of a small piece of personal information is sufficient to block the release of a huge volume of public information.
> <br />&mdash; OIPC File F14-58135, [Paul Ramsey, Mar 4, 2015](http://s3.cleverelephant.ca/oipc/2015_s22_hearing/F14-58135-ramsey-response.pdf)

I liked my argument, it was simple and clear. But I also submitted my final argument with low expectations: the Information and Privacy Commissioner has always seemed to me to be an "<small>information</small> and **PRIVACY** Commissioner" in her priorities. In an OIPC decision balancing public access rights and privacy rights, the latter is more likely to win out.


## Judgement Day

In the end, [the result](https://www.oipc.bc.ca/orders/1887#page=15) was as I expected:

> the Ministry’s evidence demonstrates that the Logs reveal personal information, including information that is subject to a presumption that disclosure would be an unreasonable invasion of personal privacy. Against that, I recognize the valuable insights into the practical workings of government that could be gained from the applicant having access to the information.
> 
> However, this is insufficient to rebut the presumptions that apply to some of the information or to overcome the invasion of personal privacy that would result from disclosure of the Logs. Disclosure of some information in the requested information in the Logs would be an unreasonable invasion of personal privacy under s. 22.
> <br />&mdash; Hamish Flanagan, OIPC, [Order F15-63](https://www.oipc.bc.ca/orders/1887#page=15)

After over **two years of process**, my bulk request for the email server logs was at an end: Metadata Man was defeated.


## Metadata Man Vindicated

However, within the ashes of defeat the seeds of a few victories could be found blooming.

The OIPC did not rule that all email log requests could rejected, only those for which it was not possible to purge private information.

> To be clear, my conclusion does not mean that metadata in the Logs can never be disclosed under FIPPA. The breadth of the applicant’s request means that the volume of responsive information allows patterns to be discerned that make disclosure in this particular case an unreasonable invasion of personal privacy. In a smaller subset of the same type of information, such patterns may not be so easily discerned so the personal privacy issues may be different.
> <br />&mdash; Hamish Flanagan, OIPC, [Order F15-63](https://www.oipc.bc.ca/orders/1887#page=15)

And the OIPC itself made use of email logs in investigating the illegal destruction of records in its report, "Access Denied".

> My investigators asked the Investigations and Forensics Unit to provide government’s message tracking logs for all of Duncan’s emails prior to November 21, 2014. My investigators then looked for terms in the subject lines of the emails such as “Highway of Tears” or “Highway 16”.
>
> The query revealed six emails in his account predating his November 20, 2014 search
> <br />&mdash; OIPC Report F15-03, "[Access Denied](https://www.oipc.bc.ca/investigation-reports/1874#page=33)"

While denying the public the information access to carry out such research directly, the OIPC used the **same technique** to prepare one of its most politically explosive investigation reports.

The OIPC decision makes clear the technique needed to make a releasable request for message tracking logs:

* Make the request small
* Make the request targeted

So, if you think a particular employee is deleting the targets of your FOI requests, make simultaneous requests for the email itself and also for all message tracking log entries from and to the employee's address. 

For example, directed to the employee's ministry:

> All emails sent and received by jim.bob@gov.bc.ca between Jan 1 and Jan 8, 2017.

And directed to the Ministry of Citizen's Services: 

> All e-mail message tracking log entries To: jim.bob@gov.bc.ca or From: jim.bob@gov.bc.ca between Jan 1 and Jan 8, 2017. Entries should include To, From, CC, Datetime, Message ID and Subject lines.

Even a very busy person is unlikely to generate more than a few dozen emails a day, so it is possible for FOI reviewers to manually scrub any private information from the log files. Similarly because the volume of records is low, there's no leverage for pattern recognition algorithms to ascertain any information not visible in a line-by-line manual review.

For folks contemplating an FOI appeal, I have kept the [full collection of documents](https://github.com/pramsey/bcfoi-email-log-files) submitted by myself and the Ministry during the process. Be prepared to spend a moderate amount of time reading and writing legalese.
{: .note }

## Beyond the Borders of BC

The OIPC ruling should be of interest to information and privacy nerds in other parts of Canada and beyond because it provides real-world precedents of:

* A government arguing forcefully that metadata is personal information.
* A privacy commissioner ruling that metadata is personal information.

Against the backdrop of bulk harvesting of Canadian metadata by federal security agencies, and the same practice in the USA, having some institutional examples of governments arguing the opposite position might help in arguing for better behaviour at higher levels of government.
