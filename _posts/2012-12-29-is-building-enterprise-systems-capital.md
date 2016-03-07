---
layout: post
title: 'Is building an enterprise systems a capital expense? '
date: '2012-12-29T23:15:00.000-08:00'
author: Paul Ramsey
tags:
- enterprise
- accounting
- it
modified_time: '2012-12-29T23:16:25.896-08:00'
blogger_id: tag:blogger.com,1999:blog-14903426.post-6200366641149406786
blogger_orig_url: http://blog.cleverelephant.ca/2012/12/is-building-enterprise-systems-capital.html
---

**First**, terminology: [operating](http://en.wikipedia.org/wiki/Operating_expense) versus [capital](http://en.wikipedia.org/wiki/Capital_expenditure) expenses. Bah! Accounting! However, it's important stuff. Wikipedia provides a good example of the difference:

<blockquote>For example, the purchase of a photocopier involves capital expenditures, and the annual paper, toner, power and maintenance costs represents operating expenses.</blockquote>

The key thing to remember is that a capital expense is supposed to convert cash into an asset.

**Second**, application: most enterprise information system builds these days are funded as capital expenses. Money is spent, and at the end of the day the organization places an entry on the balance sheet saying "System Z is worth X million dollars".

**Third**, contention: this common IT accounting practice is bullshit.

The reason it is bullshit is that the asset has to be placed on the books with a value, some dollar figure that represents what it is worth. This isn't just some made up number, it's important. This number is a component of the total asset value of the organization, and if you are adding up the value of the organization, it will be added in along with the cash, the real estate, the fixtures, all the other things that we know **do have value**.

Does the enterprise information system have value? How much? Where does that number come from?

Is the information system value a **re-sale value**? No. Unlike the photocopier from the Wikipedia example, the enterprise information system has no value outside the organization that built it: it's *sui generis*, custom-built for the purposes of one organization.

Is the information system value a **replacement cost**? No. Governments build things like bridges and highways that don't necessarily have a re-sale value (who is going to buy them?) but still have a provable value in terms of their replacement cost. If it takes $100M to build a bridge, it's a fair bet that it'll take $100M to build a second one just like it. Is this true of enterprise information systems? If I build a billing system and it costs me $1M, will it cost you the same thing to build a second one? If you have access to my source code and specifications, you could probably build an even nicer one for 1/10 the cost or less, since you wouldn't have to spend any time at all discovering the requirements or doing data cleansing. There's no expense in materials and relatively little of the labor value ends up embodied in the final product--the system value is not the replacement cost.

Is the information system value **durable**? No. Long-lived public infrastructure may not be re-sellable, but it often has a useful life span reckoned in multiple decades. Given that, it's fair to say that the cash involved in building it has not been spent, but has been converted into a fixed asset. Do enterprise information systems have that kind of durability? Do I even have to ask?

Does the information system value reflect a **one-time acquisition cost**? No. The $3B (gulp) Port Mann bridge newly opened on BC's Lower Mainland will have an annual maintenance cost of perhaps $30M a year, %1 of the capital cost. The asset is built, and we get to keep using it almost for free (except for the tolls to cover the loan, ha ha!). Is this true of enterprise information systems? In my experience, information systems budget 10-20% of build cost for expected annual maintenance. So, it's very different again.

Is there **any case at all** to be made that enterprise information systems can be treated as assets, and hence budgeted as capital expenses? Yes. But it requires that the asset value be assessed very conservatively (the whole build budget is not indicative of final value), and that the **value depreciate very quickly** (the system has a relatively short lifespan, years not decades). 

But rapid asset depreciation is just as hard on a balance sheet as operating spending is! Build a $100M system and depreciate it at 10% a year, all you've done is concentrate $100M of IT spending into a very short period of time and spread out the depreciation over a decade.

So, skill testing question for all you IT practitioners out there. Who will get the better results:<ol><li>the manager who spends $100M in one year on a system build and depreciates his asset over the ensuing decade? or,</li><li>the manager who spends $10M a year over a decade in incremental system enhancements and improvements?</li></ol>Note that both approaches have exactly the same effect on the organizational balance sheet. Take your time, don't rush your answers.

**Accounting for enterprise information systems as capital expenses is a mistake.** It's dubious from an accounting perspective, because the "asset" on the books isn't re-sellable, doesn't hold its value, and doesn't cost nearly its book value to replace. And it's dubious from a practical perspective because it forces system development and maintenance into an incredibly risky and inefficient spending pattern.

Don't do it if you can help it.<br />&nbsp;<br />