---
layout: post
title: If I hear the words "triple delete" one more time...
date: '2015-10-24T12:05:00.000-07:00'
author: Paul Ramsey
category: politics
tags:
- foi
- scandal
- bc
- oipc
- it
modified_time: '2015-10-25T09:40:33.434-07:00'
thumbnail: https://lh3.googleusercontent.com/-XHk-iEPpMBE/AAAAAAAAAAI/AAAAAAAAAAA/6ZPvqo28YIc/s72-c/photo.jpg
blogger_id: tag:blogger.com,1999:blog-14903426.post-8850519691258948922
blogger_orig_url: http://blog.cleverelephant.ca/2015/10/if-i-hear-words-triple-delete-one-more.html
comments: True
---

<img src="http://www.firstaidadvice.info/fm-21-11/images/fig3-19.PNG" style="clear:both; float: right; height: 200px; width: 332px;" /> ... I'm going to tear my ears off. Also "transitory email". Just bam, going to rip them right off. 

<more/>

**Note for those not following the British Columbia political news:** While we have known for many years that high-level government staff [routinely delete their work email](http://blog.cleverelephant.ca/2013/08/bc-government-email-defective-by-design.html), a smoking gun came to light in the spring. A [former staffer told](https://s3.amazonaws.com/s3.documentcloud.org/documents/2089546/foi-letter.pdf) how his superior personally deleted emails that were subject to an FOI request and then memorably said "It's done. Now you don't have to worry anymore." (A line which really should only be delivered over a fresh mound of dirt with a shovel in hand.) The BC FOI Commissioner investigated his allegation and [reported back](https://www.oipc.bc.ca/investigation-reports/1874) that, yep, it really did happen and that the government basically does it all the time.
{: .note }

The Microsoft Outlook tricks and the contortions of policy around what is "transitory" or not, are all beside the point, since: 

1. there is **no reason electronic document destruction should be allowed**, in any circumstance, ever, because
2. electronic message **archival and retrieval is a solved problem**. 
    
The [BC Freedom of Information Act](http://www.bclaws.ca/Recon/document/ID/freeside/96165_00), with its careful parsing of "[transitory](http://www.gov.bc.ca/citz/iao/records_mgmt/guides/transitoryug.pdf)" versus real e-mails, was written in the early 1990s, when there was a tangible, physical cost to retaining duplicative and short-lived records -- they took up space, and cost money to store. 

<img src="http://www.staples-3p.com/s7/is/image/Staples/s0404113_sc7" style="float: right; height: 200px; width: 281px;" />Oh, yes, digital documents cost money to store, but please note, my old CD collection (already a very information dense media) takes up a 2-cube box in my garage, but barely dents the storage capacity of an $10 memory stick in MP3 form. My book collection (6 shelves) hardly even registers in digital form. You use more data streaming an episode of Breaking Bad. **Things have changed since 1995. And since 2005.**

So why are we still having this conversation, and why does the government have such lax rules around message retention? And let me be clear, the government rules are **very, very, lax**. 

In the USA, public companies are under the [Sarbanes-Oxley](https://en.wikipedia.org/wiki/Sarbanes%E2%80%93Oxley_Act) rules and have extremely [strict requirements](http://www.sox-online.com/act_section_802.html) for [document retention](http://www.creditworthy.com/3jm/articles/cw90507.html), with punishments to match:

> "Whoever knowingly alters, destroys, mutilates, conceals, covers up, falsifies, or makes a false entry in any record, document, or tangible object with the intent to impede, obstruct, or influence the investigation or proper administration of any matter within the jurisdiction of any department or agency of the United States or any case filed under title 11, or in relation to or contemplation of any such matter or case, shall be fined under this title, imprisoned not more than 20 years, or both."

Similarly, in Canada investment companies must keep complete archives of all messages, in all kinds of media:

> Pursuant to National Instrument 31-103 ... firms must retain records of their business activities, financial affairs, client transactions and communication. ... **The type of device used to transmit the communication or whether it is a firm issued or personal device is irrelevant.** Dealer Members must therefore design systems and programs with compliant record retention and retrieval functionalities for those methods of communication permitted at the firm. For instance, the content posted on social media websites, such as **Twitter, Facebook, blogs, chat rooms and all material transmitted through emails**, are subject to the above-noted legislative and regulatory requirements. <br/>&mdash; IIROC [Guidelines for the review, supervision and retention of advertisements, sales literature and correspondence](http://www.iiroc.ca/Documents/2011/dbed7d6a-ed1c-4a8b-b3d9-bef60412aa27_en.pdf), Section II 

Wow! That sounds really hard! I wonder how US public companies and Canadian investment dealers can do this, while the government can't even upgrade their email servers without losing 8 months worth of archival data:

> As it turned out, the entire migration process would take eight months. When the process extended beyond June 2014, MTICS forgot to instruct HPAS to do backups on a monthly basis. This meant that every government mailbox that migrated onto the new system went without a monthly backup until all mailboxes were migrated. Any daily backup that existed was expunged after 31 days. At its peak, some 48,000 government mailboxes were without monthly email backups.<br/>&mdash; OIPC [Investigation Report F15-03](https://www.oipc.bc.ca/investigation-reports/1874), Page 32 

<img src="https://lh3.googleusercontent.com/-XHk-iEPpMBE/AAAAAAAAAAI/AAAAAAAAAAA/6ZPvqo28YIc/photo.jpg" style="float:right; height:100px; width:100px; "/>Corporations and investment banks can do this because high volume [enterprise email archiving](https://www.google.ca/?q=enterprise+email+archive) has been a solved problem for well over a decade. So there are lots of options, [proprietary](http://www.messagesolution.com/email_archiving.htm), [open source](https://www.mailarchiva.com/#firstPage), and even [British Columbian](http://globalrelay.com/)!

Yep, one of the top companies in the electronic message archiving space, [Global Relay](http://globalrelay.com/), is actually headquartered in Vancouver! Guys! Wake up! Put a salesperson on the float-plane to Victoria on Monday!

Right now, British Columbia doesn't have an enterprise email archive. It has an email server farm, with infrequent backup files, retained for only 18 months and requiring substantial effort to restore and search. Some of the advantages of an archive are:

1. The archive is separate from the users, they do not individually determine the retention schedule using their [DELETE] key, retention is applied enterprise-wide on the archive.
2. Archive searches are not done by users, they are done by the people who need access to the archive. In the case of corporate archives, that's usually the legal team. In the case of the government it would be the legal team and the FOI officers.
3. Archive searches can address the **whole** collection of email in one search. Current government FOI email searches are done computer-by-computer, by line staff who probably have better things to do.
4. The archive is separate from the operational mail delivery and mail box servers, so upgrades on the operation equipment do not affect the archive.

So, for the next little while, the Commissioner's narrow technical recommendations are fine (even though they make me want to tear my ears off):

<a href="http://2.bp.blogspot.com/-WcPaHLhhssY/VivThIrDjtI/AAAAAAAAAi8/pSu1CFJCGEU/s1600/screenshot_340.png" imageanchor="1" ><img border="0" width="527" height="357"  src="http://2.bp.blogspot.com/-WcPaHLhhssY/VivThIrDjtI/AAAAAAAAAi8/pSu1CFJCGEU/s1600/screenshot_340.png" /></a>

But the real long-term technical solution to treating email as a document of record is... **start treating it as a document of record**! Archive it, permanently, in a searchable form, and don't let the end users set the retention policy. It's not rocket science, it's just computers.