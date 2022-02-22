---
layout: post
title: '2022 Senate Mortality'
date: '2022-02-01T00:00:00-08:00'
author: Paul Ramsey
category: politics
tags:
- usa
- senate
- demographics
- actuarial
comments: True
image: "2022/numbers.jpg"
---

One of the crazy things about actuarial probability is that if you get a large enough population of people together, the odds that something unlikely will happen to any one of them really go up fast. They can get hit by lightning, crushed by a vending machine, killed by a tiger, or more prosaicly [suffer a stroke at the age of 49](https://talkingpointsmemo.com/news/democratic-senator-ben-lujan-hospitalized-for-stroke) as Democratic Senator Ben Ray Luján did today (apparently and hopefully he will be fine). 

<iframe width="560" height="315" src="https://www.youtube.com/embed/7Sw9Fh6uk4Q" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

The news last week that [US Justice Breyer will resign](https://www.nytimes.com/2022/01/26/us/politics/supreme-court-nominee-black-woman.html), and that his replacement can only be confirmed if the entirety of the US Democratic Senate Caucus remains healthy, led me to dust off an old macabre political analysis of group mortality: *"what are the odds that the one or more members of the Democratic Senate Caucus will die in the next year"*.

Basically the whole thing turns on a pretty simple statement of group probability. The odds that one or more members of a group will die is equal to the inverse of the odds that all members of the group will stay alive.

And the odds of N independent events all happening (like all members of a group staying alive for a period of time) is just the product of all probabilities of each individual event.

To answer the question for the Senate, we just need a few easily sourced pieces of data:

* The ages and sexes and parties of all the Senators, from [Wikipedia](https://en.wikipedia.org/wiki/List_of_current_United_States_senators).
* The age- and sex- adjusted one-year mortalities of people, from the [Social Security Administration](https://www.ssa.gov/oact/STATS/table4c6.html).

Then we can easily [construct a spreadsheet](https://docs.google.com/spreadsheets/d/16kGtcRkcl6RBUKtSYIIJ3q5AIu1LspLjV2BxkY9mOTI/edit#gid=1651248072) to answer the pressing actuarial question of the day.

**Probability of one or more Senators dying in next 12 months**

| Population  | Probability       |
|:-----------:|:-----------------:|
| All Parties | 87.8% | 
| Democratic  | 63.0% |
| Republican  | 67.1% |
| D Senator + R Governor | 32.3% |
| R Senator + D Governor | 18.4% |

It's been a while since I took probability, but this strikes me as an easy one so I don't think I got it wrong. 

Long story short, a caucus made up of 50 quite old people has a really surprisingly high probability of suffering a death in any given year. The population level Social Security tables probably overstate the mortality of the Senate members though, since Senators are all wealthier than the average American and thus have access to better medical care and generally healthier living conditions.


