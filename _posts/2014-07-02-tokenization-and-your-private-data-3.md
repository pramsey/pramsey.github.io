---
layout: post
title: Tokenization and Your Private Data (3)
date: '2014-07-02T10:00:00.000-07:00'
author: Paul Ramsey
category: politics
tags:
- foippa
- bc
- it
modified_time: '2014-07-02T10:00:01.847-07:00'
blogger_id: tag:blogger.com,1999:blog-14903426.post-7998908834141334910
blogger_orig_url: http://blog.cleverelephant.ca/2014/07/tokenization-and-your-private-data-3.html
comments: True
---

To recap:

* ([Day 1](http://blog.cleverelephant.ca/2014/06/tokenization-and-your-private-data-1.html)) The government is interested in using the salesforce.com [CRM](http://en.wikipedia.org/wiki/Customer_relationship_management) and other USA cloud applications, but the BC FOIPPA Act does not allow it,
* ([Day 2](http://blog.cleverelephant.ca/2014/07/tokenization-and-your-private-data-2.html)) So the BC CIO has recommended "tokenization" systems to make personal information 100% obscured before storage in USA cloud applications.

**BUT**, and it's a big **BUT**, storing securely tokenized data makes cloud applications mostly useless.

As we saw yesterday, secure tokenization replaces every input word with a completely random token. This is done in practice with a tokenization server that translates words to tokens and vice versa.

<img src="https://docs.google.com/drawings/d/1TVBz3F3Tt8ehGu0ob7lJFGdZ-m-p9g33jDqK0aNts8U/pub?w=650" />

The tokenization server also has to translate user queries into tokenized equivalents. So if the user asked:

> "Show me the record for 'paul' 'ramsey'"

The filter would translate it into this query for the server:

> "Show me the record for 'rtah' 'hgat'"

Hm, the magic still seems to be working. But what about a search that returns more than one record?

> "Show me all the records of people named 'Paul'"

This is harder. In a secure tokenization system, there's a unique token for every word ever stored, even the same word. So the tokenizer now has to ask:

> "Show me all the records that have firstname 'rtah' or 'fasp'"

Our example has only two 'Paul's. Imagine this example with a database with 50 **thousand** 'Paul's. The query functionality would either not work or slow to a crawl. Can it be fixed? Sure!

We can fix the performance problem by just using the same token for every 'Paul' encountered by the system (and for every 'Jones', and so on).

<img src="https://docs.google.com/drawings/d/18PhJv3Ew2O61_9vH0p2HAWH7TqFMVZL5oDF1b03pJE4/pub?w=650"/>

Problem solved, now if I ask:

> "Show me all the records of people named 'Paul'"

The filter can translate it simply into:

> "Show me all the records that have firstname 'rtah'"

And no matter how many 'Paul's there are in the system it will work fine.

**Just one (big) problem.** Always substituting the same token for the same word turns "tokenization" from an [uncrackable system](http://en.wikipedia.org/wiki/One-time_pad) into a trivial [substitution cipher](http://en.wikipedia.org/wiki/Substitution_cipher), like the ones you used in Grade 4 to write secret messages to your friends (only using words as the substitution elements instead of letters).

And things get even worse [1] as you add other, very common features people expect from their CRM software:

* If you want to retrieve records in sorted order, then the tokens in the CRM must have the same sort order as the words they stand in for.
* If you want to do substring matching ("give me all the names that start with 'p'") then the token internal structure must also reflect the internal structure of the original word.

None of this has stopped tokenization software vendors (like [CipherCloud](http://www.ciphercloud.com), one of the vendors being used by the BC government) from claiming to be able to both provide the magic unbreakability of tokenization while still supporting all the features of the backend CRM.

Cryptography buffs, interested in how CipherCloud could substantiate the claims it was making, [started looking at the material](http://crypto.stackexchange.com/questions/3645/how-is-ciphercloud-doing-homomorphic-encryption) it published in its manual and demonstrated at trade shows. Based on the publicly available material, one writer [concluded](http://crypto.stackexchange.com/a/3646):

> The observed encryption has significant weaknesses, most of them inherent to a scheme that wants to encrypt data, while enabling the original application to perform operations such as search and sorting on the encrypted data without changing that application. There might be some advanced techniques (homomorphic encryption and the likes) that avoid these weaknesses, but at least the software demoed in the video does not use them.

In response, the company slapped their discussion site with a [DMCA takedown order](http://meta.crypto.stackexchange.com/questions/250/ciphercloud-dmca-notice). This is not the action of a company that is [confident in its methods](http://crypto.stackexchange.com/questions/8050/should-i-trust-ciphercloud).

[Tomorrow](http://blog.cleverelephant.ca/2014/07/tokenization-and-your-private-data-4.html), I'll look at what the Freedom of Information Commissioner has said about "tokenization" and where we are going from here.

<small>[1] Yes, my equality example is very simplified for teaching purposes, and there are some papers out there on "[fully homomorphic encryption](http://en.wikipedia.org/wiki/Homomorphic_encryption)", but note that FHE is still an area of research, and in any event (see [tomorrow's](http://blog.cleverelephant.ca/2014/07/tokenization-and-your-private-data-4.html) post), wouldn't meet the BC Information Commissioner's standard for extra-territorial storage of personal information.</small>