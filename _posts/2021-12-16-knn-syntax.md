---
layout: post
title: 'PostGIS Nearest Neighbor Syntax'
date: '2021-12-16T00:00:00-08:00'
author: Paul Ramsey
category: technology
tags:
- postgis
- postgresql
- knn
comments: True
image: "2021/knn.jpg"
---

It turns out that it is possible to get an indexed n-nearest-neighbor (KNN) search out of PostGIS along with a distance using only **one distance calculation and one target literal**.

```sql
SELECT id, $point <-> geom AS distance
FROM geoms
ORDER BY distance
LIMIT 1
``` 

See that?!? Using the column-name syntax for `ORDER BY`, the `<->` operator pulls double duty, both returning the distance to the target list and also forcing an index-assisted KNN ordering.

<blockquote class="twitter-tweet"><p lang="en" dir="ltr">It&#39;s slightly more subtle because our query is finding the nearest object and its distance:<br>`SELECT id, <a href="https://twitter.com/search?q=%24point&amp;src=ctag&amp;ref_src=twsrc%5Etfw">$point</a> &lt;-&gt; geom<br>FROM geoms<br>WHERE foo<br>ORDER BY 2<br>LIMIT 1` <br>It&#39;s in the order by clause but we&#39;re also returning the distance as a by-product (and taking advantage of the index)</p>&mdash; Joel Haasnoot (@webguy) <a href="https://twitter.com/webguy/status/1471370663495667712?ref_src=twsrc%5Etfw">December 16, 2021</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script> 

I never considered this possibility until seeing it in this tweet. Before I would have been doing this:

```sql
SELECT id, ST_Distance($point, geom) AS distance
FROM geoms
ORDER BY $point <-> geom
LIMIT 1
``` 

Two distance calculations (one in the function, one in the operator) and two references to the literal. Yuck! 