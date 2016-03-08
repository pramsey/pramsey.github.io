---
layout: post
title: Tokenization and Your Private Data (4)
date: '2014-07-03T10:00:00.000-07:00'
author: Paul Ramsey
category: politics
tags:
- foippa
- bc
- it
modified_time: '2014-07-03T13:41:43.366-07:00'
blogger_id: tag:blogger.com,1999:blog-14903426.post-7014244049165196608
blogger_orig_url: http://blog.cleverelephant.ca/2014/07/tokenization-and-your-private-data-4.html
comments: True
---

Recapping:

* ([Day 1](http://blog.cleverelephant.ca/2014/06/tokenization-and-your-private-data-1.html)) The government is interested in using the salesforce.com [CRM](http://en.wikipedia.org/wiki/Customer_relationship_management) and other USA cloud applications, but the BC FOIPPA Act does not allow it.
* ([Day 2](http://blog.cleverelephant.ca/2014/07/tokenization-and-your-private-data-2.html)) So, the BC CIO has recommended "tokenization" systems to make personal information 100% obscured before storage in USA cloud applications.
* ([Day 3](http://blog.cleverelephant.ca/2014/07/tokenization-and-your-private-data-3.html)) But, using truly secure tokenization renders CRMs basically useless, so software vendors are flogging less secure forms of tokenization hoping that people won't notice the reduced security levels because they still call it "tokenization".

The BC [CIO guidance](http://docs.openinfo.gov.bc.ca/D11384614A_Response_Package_CTZ-2014-00009.PDF) on using USA cloud services has a certain breathless enthusiasm (is there any innovation more exciting than vendor innovation?) for the tokenization products vendors are bringing to market:

> Vendors have begun to address this “data-residency” issue in innovative ways. As an example, Force.com, and CypherCloud offer solutions that allow sensitive or personal information to remain in Canada. Using tokenization – a method of substituting specified data fields for arbitrary values – these solutions allow for the use of foreign-based services while remaining within the residency-based restrictions of FOIPPA.<br/>&mdash;<small>BC OCIO, [Data Residency and Tokenization](http://docs.openinfo.gov.bc.ca/D11384614A_Response_Package_CTZ-2014-00009.PDF)</small>

<img src="http://cache.thephoenix.com/secure/uploadedImages/The_Phoenix/Life/Reality_Check/TJI_Sipress_adequate.jpg" style="float:right; width: 220px; margin: 5px; padding:10px; border: 1px solid grey;" />  

And the [guidance released by BC's Office of the Information &amp; Privacy Commissioner](https://www.oipc.bc.ca/public-comments/1649) (OIPC) at first glance appears to similarly swallow claims about tokenization hook, line and sinker.

> Public bodies may comply with FIPPA provided that the personal information is adequately tokenized and the crosswalk table is secured in Canada.<br/>&dash;<small>BC OIPC, [Updated guidance on the storage of information outside of Canada by public bodies](https://www.oipc.bc.ca/public-comments/1649 )</small>

However, the OIPC guidance has one small but important difference, **the word *"adequately"***.

I met with a lawyer from the OIPC's office to discuss tokenization, and he was clear that the OIPC understood the very important difference between fully randomized tokenization (basically unbreakable, and "adequate") and any other tokenization (potentially trivially breakable, and perhaps not "adequate"). This is reassuring, because the difference is not immediately obvious, and the tokenization software vendors are doing everything in their power to obscure the difference in their marketing materials.

It is not reassuring that the OIPC has opened the door to "tokenization" at all. The OIPC is sufficiently anal retentive about personal information that they have ruled that no forms of standard encryption are sufficiently secure to be used to store personal information outside Canada, because "encryption may be deciphered given sufficient computer analysis". That's right, the OIPC scoffs at your [AES-256](http://en.wikipedia.org/wiki/Advanced_Encryption_Standard) encoded data, but is OK with "adequate" tokenization, for some undefined values of "adequate".

The OIPC guidance spends two paragraphs on "re-identification" of data (the practice of mixing tokenized and un-tokenized fields in records), and spends five more on the legal and physical security of the tokenization crosswalk table (dictionary), but spends only one word ("**adequately**") on whether or not the tokenization dictionary is full of junk.

The OIPC told me that, because fully random tokenization [completely obscured the original data](http://blog.cleverelephant.ca/2014/07/tokenization-and-your-private-data-2.html)[1], they had to rule that fully tokenized personal data was no longer "personal information" and thus not covered by the Act. This strikes me as very lawyerly, but also very dangerous, since it opens the door for government to consider technical "tokenization" solutions from vendors that are likely far less secure than conventional approaches (like [AES-256](http://en.wikipedia.org/wiki/Advanced_Encryption_Standard)) that the OIPC has already rejected.

I'll close with the good news: all plans to store personal data outside Canada are still subject to case-by-case review by the OIPC, there is thus far no blanket approval for systems that claim they "tokenize", and the OIPC can still issue further guidance based on research that is going on right now. I'm not lighting my hair on fire, yet. But the door is cracked open, and the snake-oil salesmen are laying out their wares, let's keep an eye on them.

<small>[1] Again, implementation matters. At a minimum, even completely random word-based tokenization can leak information about how many words are in each field. Some implementations also don't encode punctuation, so they leak symbols ("Smith &amp; Wesson" becomes "faerqb &amp; gabedfsara") and other non-word entities. Depending on the input data, these small leakages can be significant.</small>

**PostScript**

In re-reading my series of posts, I think I have been overly harsh on the cloud security vendors, because there are really two questions here, which have very different answers:

* **Is less-than-perfect tokenization better than nothing?** Yes, it's a lot better than nothing. Even with less-than-perfect tokenization, employees of the cloud software companies can't just casually read records in the database, and an entity wanting to break the security of the records would need to extract a pretty big corpus of records to analyze them to find information leaks and use them to break in.
* **Is less-than-perfect tokenization acceptable for BC?** No, because of the FOIPPA law, and because the Commissioner has already set a very very very high bar by not allowing standard symmetric encryption (which can be very very secure) to be used to host personal data outside of Canada.

More on this [tomorrow](http://blog.cleverelephant.ca/2014/07/tokenization-and-your-private-data-5.html).

