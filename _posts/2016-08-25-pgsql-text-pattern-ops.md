---
layout: post
title: PgSQL Indexes and "LIKE"
date: '2016-08-25T02:05:00.004-07:00'
author: Paul Ramsey
category: technology
tags:
- postgis
- postgresql
- indexing
- sql
comments: True
image: "2016/card-catalog.jpg"
---

Do you write queries like this:

{% highlight sql %}
SELECT * FROM users 
WHERE name LIKE 'G%'
{% endhighlight %}

Are your queries unexpectedly slow in PostgreSQL? Is the index not doing what you expect? Surprise! You've just discovered a PostgreSQL quirk.

**TL;DR:** If you are running a locale other than "C" (`show LC_COLLATE` to check) you need to create a special index to support pattern searching with the `LIKE` operator: `CREATE INDEX myindex ON mytable (mytextcolumn text_pattern_ops)`. Note the specification of the `text_pattern_ops` [operator class](https://www.postgresql.org/docs/current/static/indexes-opclass.html) after the column name.
{: .note }

As a beginner SQL student, you might have asked "will the index make my 'like' query fast" and been answered "as long as the wildcard character is at the end of the string, it will."

<img src="{{ site.images }}{{ page.image }}" alt='{{ page.title }}' width="377" height="250" />

That statement is only true in general if your database is initialized using the ["C" locale](https://unix.stackexchange.com/questions/87745/what-does-lc-all-c-do) (the North America/English-friendly UNIX default). Running with "C" used to be extremely common, but is less and less so, as modern operating systems automagically choose appropriate regional locales to provide approriate time and formatting for end users.

For example, I run Mac OSX and I live in British Columbia, an English-speaking chunk of North America. I could use "C" just fine, but when I check my database locale (via my collation), I see this:

    pramsey=# show LC_COLLATE;
     lc_collate  
    -------------
     en_CA.UTF-8
    (1 row)

It's a good choice, it's where I live, it supports lots of characters via UTF-8. However, it's not "C", so there are some quirks.

I have a big table of data linked to postal codes, this is what the table looks like:

                  Table "gis.postal_segments"
          Column       |     Type     | Modifiers 
    -------------------+--------------+-----------
     postal_code       | text         | not null
     segment           | character(4) | 
    Indexes:
        "postal_segments_pkey" PRIMARY KEY, btree (postal_code)

Note the index on the postal code, a standard btree. 

I want to search rows based on a postal code prefix string, so I run:

{% highlight sql %}
EXPLAIN ANALYZE 
SELECT * FROM postal_segments 
WHERE postal_code LIKE 'V8V1X%';
{% endhighlight %}

                                                  QUERY PLAN                                              
    ------------------------------------------------------------------------------------------------------
     Seq Scan on postal_segments  (cost=0.00..2496.85 rows=10 width=68) (actual time=30.320..34.219 rows=4 loops=1)
       Filter: (postal_code ~~ 'V8V1X%'::text)
       Rows Removed by Filter: 100144
     Planning time: 0.250 ms
     Execution time: 34.263 ms
    (5 rows)

Ruh roh! 

I have an index on the postal code, so why am I getting a sequence scan?!?! Because my index is no good for doing pattern matching in any collation other than "C". I need a special index for that, which I create like this.

{% highlight sql %}
CREATE INDEX postal_segments_text_x 
  ON postal_segments (postal_code text_pattern_ops);
{% endhighlight %}

The magic part is at the end, invoking `text_pattern_ops` as the [opclass for this index](https://www.postgresql.org/docs/current/static/indexes-opclass.html). Now my query works as expected:

{% highlight sql %}
EXPLAIN ANALYZE 
SELECT * FROM postal_segments 
WHERE postal_code LIKE 'V8V1X%';
{% endhighlight %}

                                                               QUERY PLAN                                                           
    --------------------------------------------------------------------------------------------------------------------------------
     Index Scan using postal_segments_text_x on postal_segments  (cost=0.29..8.31 rows=10 width=68) (actual time=0.067..0.073 rows=4 loops=1)
       Index Cond: ((postal_code ~>=~ 'V8V1X'::text) AND (postal_code ~<~ 'V8V1Y'::text))
       Filter: (postal_code ~~ 'V8V1X%'::text)
     Planning time: 0.532 ms
     Execution time: 0.117 ms
    (5 rows)

I have gotten so used to PostgreSQL doing exactly the right thing automatically that it took quite a long time to track down this quirk when I ran into it. I hope this page helps others save some time!