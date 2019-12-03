---
layout: post
title: 'PostgreSQL and SQL and Books'
date: '2019-11-28T00:00:00-08:00'
author: Paul Ramsey
category: technology
tags:
- sql
comments: True
image: "2019/art-of-pgsql-sm.png"
---

I never tire of telling developers that they should learn SQL. 

And I never run out of developers for whom that is good advice.

I think the reason is that so many developers learn basic SQL CRUD operations, and then stop. They can filter with a `WHERE` clause, they can use `Sum()` and `GROUP BY`, they can `UPDATE` and `DELETE`.

If they are particularly advanced, they can do a `JOIN`. But that's usually where it ends.

And the tragedy is that, because they stop there, they end up re-writing big pieces of data manipulation logic in their applications -- logic that they could skip if only they knew what their SQL database engine was capable of.

Since so many developers are using PostgreSQL now, I have taken to recommending a couple of books, written by community members. 

For people getting started with PostgreSQL, and SQL, the [Art of PostgreSQL](https://cleverelephant--theartofpostgresql.thrivecart.com/full-edition/), by Dmitri Fontaine. 

<a href="https://cleverelephant--theartofpostgresql.thrivecart.com/full-edition/"><img src="{{ site.images }}/2019/art-of-pgsql-lg.png" alt="Art of PostgreSQL" /></a>

For people who are wanting to learn PostGIS, and spatial SQL, I recommend [PostGIS in Action](https://www.manning.com/books/postgis-in-action-third-edition), by Regina Obe and Leo Hsu.

<a href="https://www.manning.com/books/postgis-in-action-third-edition"><img src="{{ site.images }}/2019/obe.png" alt="PostGIS in Action" /></a>

Both Dmitri and Regina are community members, and both have been big contributors to PostgreSQL and PostGIS. One of the key PostgreSQL features that PostGIS uses is the "extension" system, which Dmitri implemented many years ago now. And of course Regina has been active in the PostGIS develompent community almost since the first release in the early 2000s.

I often toy with the idea of writing a PostGIS or a PostgreSQL book, but then I stop and think, "wait, there's already lots of good ones out there!" So I wrote this short post instead.

