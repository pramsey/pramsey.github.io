---
layout: post
title: 'How I Make Jeff Richer'
date: '2019-07-22T08:00:00-08:00'
author: Paul Ramsey
category: technology
tags:
- aws
- amazon
- postgresql
- postgres
- pgsql
comments: True
---

> "How can I get paid to work on this cool open source project?"

Once upon a time, it felt like most discussions about open source were predicated on answering this question. Developers fell in love with, or created, some project or other, but found themselves working on it in their spare time. If only there was some way to monetize their labour of love!

<img src="{{ site.images }}/2019/knitting-money.jpg" alt="loadMap" />

From that complaint, a score of (never quite satisfactory) models were spawned.

* **Pure consulting**, which depends on a never-ending supply of enhancements and updates, usually to the detriment of core maintainance.
* **Professional support**, which depends on a deep enough market of potential enterprises, and a sense of "deployment risk" large enough to open wallets.
* **Open core**, which invests in the open source core to promote adoption and hopefully build a sub-population of enterprises that have embedded the project sufficiently to be in the market for add-ons to make things faster/simpler/more integrated.
* **Relicensing**, which leverages adoption of the open source to squeeze conventional licensing revenue out of enterprises that don't want to accept open source license terms of use.

What all the models above have in common is that they more-or-less require successful adopters to invest effort in the open source project at the center of the model. Adoption of the open source project is an "on ramp" to revenue opportunities, but the operating assumption is that customer will continue using the open source core, so the business has an incentive to invest in the "on ramp".

<img src="{{ site.images }}/2019/onramp.jpg" alt="loadMap" />

In the same way, Oracle provides an "on ramp" to their enterprise product, in the free-as-in-beer [Oracle Express](https://www.oracle.com/ca-en/database/technologies/appdev/xe.html). Oracle pays for the development of the on-ramp (it's just Oracle, after all) and in return (maybe) reaps the reward of eventual migration of users to their paid product.

Which brings me to "AWS Aurora", now [generally available](https://aws.amazon.com/blogs/aws/amazon-aurora-postgresql-serverless-now-generally-available/) on Amazon's cloud.

AWS deliberately does not say Aurora is "PostgreSQL". They say it is "PostgreSQL compatible". That's probably for the best: Aurora is a soft fork of the core PostgreSQL code that replaces big chunks of PostgreSQL storage logic with [clever, custom AWS code](https://www.youtube.com/watch?v=wGopOkzLcww).  

Like [AWS PostgreSQL RDS](https://aws.amazon.com/rds/postgresql/), Aurora is a revenue generating fork of PostgreSQL that uses open source PostgreSQL adoption as an on-ramp for AWS revenue. This would superficially seem to be a similar situation to all the other open source business models, except for one thing: AWS doesn't have any stake in the success of PostgreSQL per se.

AWS offers RDS versions of **all** the RDBMS systems, open source and otherwise, and they invest in the core projects accordingly, and fairly: hardly at all. After all, to do otherwise would be to declare a preference.

So the open source communities end up building the on-ramp to AWS paid services as a free service to AWS. 

That's annoying enough, but it gets uglier, I think, as time goes on.

<img src="{{ site.images }}/2019/itsatrap.jpg" alt="loadMap" />

For now, Aurora tracks the PostgreSQL version fairly well. You can move your app onto Aurora, you can move it back off to RDS, you can move it to [Google's managed PostgresSQL](https://cloud.google.com/sql/docs/postgres/), you can host it yourself on premise or in the cloud.

However, eventually the business expense of maintaining the Aurora code base against a PostgreSQL baseline that is in constant motions will wear on Amazon, and they will start to see places where adding "Aurora only" features will "improve the customer experience".

At that point, the soft fork will turn into a hard fork, and migrations into Aurora will start to look like a one-way valve.

And the community will still be maintaining the on-ramp to AWS.

Let me pre-empt some of the commentary.

"Free riding is part of the deal!" 

Sure it is. AWS isn't doing anything illegal. They are just taking advantage where they can take advantage.

Similarly, the industries that dumped waste into the [Cuyahoga River](https://en.wikipedia.org/wiki/Cuyahoga_River) until it was so polluted it caught fire were no doubt working within the letter of the law.

Free riding is part of the deal. 

I hope that all kinds of people and organizations free ride on my open source work, it's part of the appeal of the work. 

I also hope that enlightened self-interest at the very least will lead to one of two outcomes:

* That the customers of AWS RDS and (particularly) Aurora recognize that the organization they are paying (AWS) is not adequately supporting the core of they software (PostgreSQL) their operations depend on, and that as a result **they are implicitly taking on the associated technical risk** of under-investment.
* That AWS itself has the foresight to invest directly in the open source on-ramps to their paid cloud deployments, acknowledging that the core software does in fact provide **just as much** (and maybe even more) **value** as their impressive cloud infrastructure does.

I think it's more likely that short term thinking will lead to "AWS only" featuritis and the creation of a one-way valve, even the deliberate downgrading of RDS and on-premise capabilities to drive customers into the arms of Aurora, because: why not? 

The logic of enterprise sales is: land, expand, lock-in, and squeeze. 

Just because AWS is currently in the land-and-expand phase doesn't mean they won't get to the succeeding phases eventually. 
