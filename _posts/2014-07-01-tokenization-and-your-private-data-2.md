---
layout: post
title: Tokenization and Your Private Data (2)
date: '2014-07-01T09:14:00.000-07:00'
author: Paul Ramsey
category: politics
tags:
- foippa
- bc
- it
modified_time: '2014-07-01T09:14:21.727-07:00'
blogger_id: tag:blogger.com,1999:blog-14903426.post-7255097867133408653
blogger_orig_url: http://blog.cleverelephant.ca/2014/07/tokenization-and-your-private-data-2.html
comments: True
---

So, ([Day 1](/2014/06/tokenization-and-your-private-data-1.html)) the BC government's vendors (and thus, by extension, the BC government) are hot to trot to use the [salesforce.com](http://salesforce.com) cloud [CRM](http://en.wikipedia.org/wiki/Customer_relationship_management) to store the personal data of BC citizens. But, BC privacy law [does not allow that](http://www.bclaws.ca/civix/document/LOC/complete/statreg/--%20F%20--/Freedom%20of%20Information%20and%20Protection%20of%20Privacy%20Act%20[RSBC%201996]%20c.%20165/00_Act/96165_03.xml#section30.1). Whatever will the government do? 

Enter stage left: "tokenization". The CIO has recommended tokenization technology for Ministries looking to use salesforce.com and other cloud services to manage private information:

> Using tokenization – a method of substituting specified data fields for arbitrary values – these solutions allow for the use of foreign-based services while remaining within the residency-based restrictions of FOIPPA.<br/>
> &mdash; [Bette-Jo Hughes, Oct 2, 2013](http://docs.openinfo.gov.bc.ca/D11384614A_Response_Package_CTZ-2014-00009.PDF)

[Tokenization](http://en.wikipedia.org/wiki/Tokenization_(data_security)) is a strategy that takes every word in an input text, and replaces it with a random substitution "token", and keeps track of the relationship between words and tokens. So, the input to a tokenization process would be N words, and the output would be N random numbers, and an N-entry dictionary matching the words to the numbers that replaced them.

Crytography buffs will note that this is just a [one-time pad](http://en.wikipedia.org/wiki/One-time_pad), an old but unbreakable scheme for encoding messages, only operating word-by-word instead of letter-by-letter.

This seems like a nice trick!

<table border="1" width="60%" cellpadding="5">
    <tr>
        <th width="33%">Input</th>
        <th width="33%">Dictionary</th>
        <th width="33%">Output</th>
    </tr>
    <tr>
        <td>Paul Ramsey<br/>Paul Jones<br/>Tim Jones</td>
        <td>Paul = rtah<br/>Ramsey = hgat<br/>Paul = fasp<br/>Jones = nasd<br/>Tim = yhav<br/>Jones = imfa</td>
        <td>rtah hgat<br/>fasp nasd<br/>yhav imfa</td>
    </tr>
</table>

If you are clever, you can put a tokenizing filter between your users and American web sites like SF.com, and have the tokenizer replace the words you send to SF.com with tokens, and replace the tokens SF.com sends you with words. So the data at SF.com will be gobbledegook, but what you see on your screen will be words. Magic!

<img src="https://docs.google.com/drawings/d/1TVBz3F3Tt8ehGu0ob7lJFGdZ-m-p9g33jDqK0aNts8U/pub?w=650">

If all we wanted to do was just store data securely somewhere outside of Canada, and then get it back, "tokenization" would be a grand idea, but there's a hitch.

* First, storing tokenized data means storing 3-times the volume of the original (one copy of tokens stored at salesforce.com, and a locally stored dictionary that contains both the original and the tokens). You get no benefit from the cloud from a storage standpoint (in fact it's worse, you're storing twice as much local data); and, you get no redundancy benefit, since if you lose your local copy of the dictionary the cloud data becomes meaningless.
* Second, ***and most importantly*** this whole exercise isn't about storing data, it's about **making use of a customer relationship management** (CRM) system, salesforce.com, and secure tokenization, as described above, is **not consistent** with using salesforce.com effectively.

[Tomorrow](/2014/07/tokenization-and-your-private-data-3.html), we'll discuss why this most excellent "tokenization" magic doesn't work if you want to use it inside a CRM (or any other system that expects its data to have meaning).