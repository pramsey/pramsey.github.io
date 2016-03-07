---
layout: post
title: Making Lines from Points
date: '2015-03-20T13:07:00.000-07:00'
author: Paul Ramsey
category: technology
tags:
- postgis
modified_time: '2015-03-20T13:07:02.435-07:00'
blogger_id: tag:blogger.com,1999:blog-14903426.post-572071594835044806
blogger_orig_url: http://blog.cleverelephant.ca/2015/03/making-lines-from-points.html
---

Somehow I've gotten through 10 years of SQL without ever learning this construction, which I found while proof-reading a [colleague's](https://twitter.com/sanderpick) blog post and looked so unlikely that I had to test it before I believed it actually worked. Just goes to show, there's always something new to learn.

Suppose you have a GPS location table:

* **gps_id**: integer
* **geom**: geometry
* **gps_time**: timestamp
* **gps_track_id**: integer

You can get a correct set of lines from this collection of points with just this SQL:

{% highlight sql %}
SELECT
  gps_track_id,
  ST_MakeLine(geom ORDER BY gps_time ASC) AS geom
FROM gps_poinst
GROUP BY gps_track_id
{% endhighlight %}
    
Those of you who already knew about placing `ORDER BY` within an aggregate function are going "duh", and the rest of you are, like me, going "whaaaaaa?"

Prior to this, I would solve this problem by ordering all the groups in a CTE or sub-query first, and only then pass them to the aggregate make-line function. This, is, so, much, nicer.