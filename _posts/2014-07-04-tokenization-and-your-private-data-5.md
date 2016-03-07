---
layout: post
title: Tokenization and Your Private Data (5)
date: '2014-07-04T09:16:00.000-07:00'
author: Paul Ramsey
category: politics
tags:
- foippa
- bc
- it
modified_time: '2014-07-04T09:16:00.362-07:00'
thumbnail: http://4.bp.blogspot.com/-mrn15yGa2MU/U7WwOHqe9tI/AAAAAAAAAMI/Q9m3cHa5Eis/s72-c/screenshot_61.png
blogger_id: tag:blogger.com,1999:blog-14903426.post-8221359595616138375
blogger_orig_url: http://blog.cleverelephant.ca/2014/07/tokenization-and-your-private-data-5.html
---

Recapping (last time):

* ([Day 1](http://blog.cleverelephant.ca/2014/06/tokenization-and-your-private-data-1.html)) The government is interested in using the salesforce.com [CRM](http://en.wikipedia.org/wiki/Customer_relationship_management) and other USA cloud applications, but the BC FOIPPA Act does not allow it.
* ([Day 2](http://blog.cleverelephant.ca/2014/07/tokenization-and-your-private-data-2.html)) So, the BC CIO has recommended "tokenization" systems to make personal information 100% obscured before storage in USA cloud applications.
* ([Day 3](http://blog.cleverelephant.ca/2014/07/tokenization-and-your-private-data-3.html)) But, using truly secure tokenization renders CRMs basically useless, so software vendors are flogging less secure forms of tokenization hoping that people won't notice the reduced security levels because they still call it "tokenization".
* ([Day 4](http://blog.cleverelephant.ca/2014/07/tokenization-and-your-private-data-4.html)) And, the BC Freedom of Information &amp; Privacy Commissioner distinguishes between "encryption" (which is considered inadequate protection for personal information held outside Canada) and "tokenization" (which is considered adequate (but only where the "tokenization" itself is "adequate" (which seems to mean "fully random"))).

<img border="0" style="float: right; margin-left: 1em;" src="http://4.bp.blogspot.com/-mrn15yGa2MU/U7WwOHqe9tI/AAAAAAAAAMI/Q9m3cHa5Eis/s200/screenshot_61.png" />

While this series on tokenization has been a bomb with regular folks (my post on the [BCTF and social media](http://blog.cleverelephant.ca/2014/05/government-broadcast-media-vs-bctf.html) got 10x the traffic) one category of readers have really taken notice: tokenization vendors. I've gotten a number of emails, and some educational comments as well. (Hi guys!)

For the love of the vendors, I'll repeat yesterdays postscript. I think I have been overly harsh on the cloud security vendors, because there are really two questions here, which have very different answers:

* **Is less-than-perfect tokenization better than nothing?** Yes, it's a lot better than nothing. Even with less-than-perfect tokenization, employees of the cloud software companies can't just casually read records in the database, and an entity wanting to break the security of the records would need to extract a pretty big corpus of records to analyze them to find information leaks and use them to break in.
* **Is less-than-perfect tokenization acceptable for BC?** No, because of the FOIPPA law, and because the Commissioner has already set a very very very high bar by not allowing standard symmetric encryption (which can be very very secure) to be used to host personal data outside of Canada.

It's worth re-visiting the two key phrases in the [OIPC guidance](https://www.oipc.bc.ca/public-comments/1649), which are:

> Tokenization is distinct from encryption; while encryption may be deciphered given sufficient computer analysis, tokens cannot be decoded without access to the crosswalk table.

What I take from this is that the OIPC is saying that "encryption" is vulnerable (it "may be deciphered"), and "tokenization" is not (it "cannot by decoded"). Now, as discussed on [day 3](http://blog.cleverelephant.ca/2014/07/tokenization-and-your-private-data-3.html), the "cannot be decoded" part is only true for a very small sub-set of "tokenization", the kind that uses fully random tokens. And the OIPC is aware of this, though they only barely acknowledge it:

> Public bodies may comply with FIPPA provided that the personal information is *adequately* tokenized and the crosswalk table is secured in Canada.

If you take "adequately" to mean "adequately" such that "tokens cannot be decoded without access to the crosswalk table" then you're talking about an extremely restrictive definition of tokenization. A lot more restrictive than what vendors are talking about when they come to sell you tokenization.

The vendors who are phoning me and commenting here are worried that readers will see my critique and think "huh, tokenization is insecure". And that's not what I'm saying. What I'm saying is:

> **Practical use of tokenization in a USA cloud CRM is not consistent with the British Columbia OIPC's incredibly narrow definition of an acceptable level of data security for personal information stored in foreign jurisdictions or under foreign control.**<br/><small>Paul Ramsey, Just Now</small>

If you're just looking for a reasonable level of surety that your data in a cloud service cannot be easily poked and prodded by a third party (or the cloud service itself), and you don't mind adding the extra level of complexity of interposing a tokenization service/server into your interactions with the cloud service, then by all means, a properly configured tokenization system would seem to fit the bill nicely.

[YMMV](http://crypto.stackexchange.com/questions/8050/should-i-trust-ciphercloud).