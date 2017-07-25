---
layout: post
title: Some Great Things about PostgreSQL
date: '2017-05-17T08:00:00-08:00'
author: Paul Ramsey
category: technology
tags:
- postgresql
- sql
comments: True
image: "2017/postgresql.png"
---

I spent the last few months using PostgreSQL for real work, with real data, and I've been really loving some of the more esoteric features. If you use PostgreSQL on a regular basis, learning these tools can make your code a lot more readable and possibly faster too.


## Distinct On

A number of the tables I had to work with included multiple historical records for each individual, but I was only interested in the most recent value. That meant that every query had to start with some kind of filter to pull off the latest value for joining to other tables.

It turns out that the PostgreSQL `DISTINCT ON` syntax can spit out the right answer very easily:

{% highlight sql %}
SELECT DISTINCT ON (order_id) orders.*
FROM orders
ORDER BY orders.order_id, orders.timestamp DESC
{% endhighlight %}

No self-joining or complexity here, the tuple set is sorted into id/time order, and then the distinct on clause pulls the first entry (which is the most recent, thanks to the sorting) off of each id grouping.


## Filtered Aggregates

I was doing a lot of reporting, so I built a BI-style denormalized reporting table, with a row for every entity of interest and a column for every variable of interest. Then all that was left was the reporting, which rolled up results across multiple groupings. The trouble was, the roll-ups were oftenly highly conditional: all entities with this condition A but not B, compared with those with B but not A, compared with all entities in aggregate. 

Ordinarily this might involve embedding a big case statement for each conditional but with filtered aggregates we get a nice terse layout that also [evaluates faster](http://www.cybertec.at/postgresql-9-4-aggregation-filters-they-do-pay-off/).

{% highlight sql %}
SELECT
    store_territory,
    Count(*) FILTER (WHERE amount < 5.0) 
        AS cheap_sales_count,
    Sum(amount) FILTER (WHERE amount < 5.0) 
        AS cheap_sales_amount,
    Count(*) FILTER (WHERE amount < 5.0 AND customer_mood = 'good') 
        AS cheap_sales_count_happy,
    Sum(amount) FILTER (WHERE amount < 5.0 AND customer_mood = 'good')
        AS cheap_sales_amount_happy
FROM bi_table
GROUP BY store_territory
{% endhighlight %}
    
I would routinely end up with 20-line versions of this query, which spat out spreadsheets that analysts were extremely happy to take and turn into charts and graphs and even decisions.

    
# Window Functions

My mind aches slightly when trying to formulate window functions, but I was still able to put them to use in a couple places.

First, even with a window wide enough to cover a whole table, window functions can be handy! Add a percentile column to a whole table:

{% highlight sql %}
SELECT bi_table.*, 
    ntile(100) OVER (ORDER BY amount) 
        AS amount_percentile
FROM bi_table
{% endhighlight %}
    
Second, using ordinary aggregates in a window context can create some [really groovy results](https://stackoverflow.com/questions/22841206/calculating-cumulative-sum-in-postgresql). Want cumulated sales over store territories? (This might be better delegated to front-end BI display software, but...)

{% highlight sql %}
WITH daily_amounts AS (
    SELECT 
        sum(amount) AS amount,
        store_territory,
        date(timestamp) AS date
    FROM bi_table
    GROUP BY store_territory, date
)
SELECT 
    sum(amount) OVER (PARTITION BY store_territory ORDER BY date) 
        AS amount_cumulate
    store_territory, date
FROM daily_amounts
{% endhighlight %}
    
Alert readers will note the above example won't provide a perfect output table if there are days without any sales at all, which brings me to a side note cool feature: PostgreSQL's [generate_series](https://www.postgresql.org/docs/current/static/functions-srf.html) function (Regina Obe's [favourite function](http://www.bostongis.com/blog/index.php?/categories/13-generate_series)) supports generating time-based series!

{% highlight sql %}
SELECT generate_series(
    '2017-01-01'::date, 
    '2017-01-10'::date, 
    '18 hours'::interval);
{% endhighlight %}
        
Normally you'll probably generate boring 1-day, or 1-week, or 1-month series, but the ability to generate arbitrarily stepped time series is pretty cool and useful. To solve the cumulation problem, you can just generate a full series of days of interest, and left join the calculated daily amounts to that, prior to cumulation in order to get a clean one-value-per-day cumulated result.


# Left Join and Coalesce

This is not really an advanced technique, but it's still handy. Suppose you have partial data on a bunch of sales from different sources and in different tables. You want a single table output that includes your best guess about the value, what's the easiest way to get it? Left join and coalesce.

Start with a base table that includes all the sales you care about, left join all the potential sources of data, then coalesce the value you care about into a single output column.

{% highlight sql %}
SELECT
    base.order_id,
    Coalesce(oi1.order_name, oi2.order_name, oi2.order_name) 
        AS order_name
FROM base
LEFT JOIN order_info_1 oi1 USING (order_id)
LEFT JOIN order_info_2 oi2 USING (order_id)
LEFT JOIN order_info_3 oi3 USING (order_id)
{% endhighlight %}
    
The coalesce function takes the first non-NULL value it encounters in its parameters and returns that as the value. The practical effect is that, in the case where the first two tables have no rows for a particular base record, and the third does, the coalesce will skip past the first two and return the non-NULL value from the third. This is a great technique for compressing sparse multiple input sources into a terse usable single output.


