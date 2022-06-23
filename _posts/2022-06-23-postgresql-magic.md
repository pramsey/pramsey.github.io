---
layout: post
title: 'Technology, Magic & PostgreSQL'
date: '2022-06-23T00:00:00-08:00'
author: Paul Ramsey
category: technology
tags:
- postgis
comments: True
image: "2022/elemap.jpg"
---

I have a [blog post up today](https://www.crunchydata.com/blog/indexes-selectivity-and-statistics) at Crunchy Data on some of the mechanisms that underlie the PostgreSQL query planner, it's pretty good if I do say so myself.

I was motivated to write it by a conversation over coffee with my colleague Martin Davis. We were talking about a customer with an odd query plan case and I was explaining how the spatial statistics system worked and he said "you should do that up as a blog post". And, yeah, I should. 

One of the things that is striking as you follow the PostgreSQL development community is the extent to which a fairly mature piece of technology like PostgreSQL is stacks of optimizations on top of optimizations on top of optimizations. Building and executing query plans involves so many different paths of execution, that there's always a new, niche use case to address and improve.

I worked a political campaign a few years ago as a "data science" staffer, and our main problem was stitching together data from multiple systems to get a holistic view of our data. 

That meant doing cross-system joins. 

The first cut is always easy: pull a few records out of **System A** with a filter condition and then go to **System B** and pull the associated records. But then inevitably a new filter condition shows up and applied to **A** it generates so many records that the association step on **B** gets overloaded. But it turns out if I start from **B** and then associate in **A** it's fast again.

And thus suddenly I found myself writing a query planner and executor.

It's only when dumped into the soup of having to solve these problems yourself that you really appreciate the **magic** that is a mature relational database system. The idea that PostgreSQL can take a query that involves multiple tables of different sizes, with different join cardinalities, and different indexes and figure out an optimal plan in a few milliseconds, and then execute that plan in a streaming, memory efficient way...? 

**Magic** is really the best word I've found.
