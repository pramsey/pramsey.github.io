---
layout: post
title: Network Walking in PostGIS
date: '2010-07-21T14:41:00.000-07:00'
author: Paul Ramsey
tags:
- postgis
- recursion
- with recursive
modified_time: '2010-07-21T14:44:38.288-07:00'
blogger_id: tag:blogger.com,1999:blog-14903426.post-1646776111192103355
blogger_orig_url: http://blog.cleverelephant.ca/2010/07/network-walking-in-postgis.html
comments: True
---

One of the new features in PostgreSQL 8.4 was the &#8220;WITH RECURSIVE&#8221; clause available for queries. It allows you to define a subquery based on a recursive term &#8212; fancy language for a function that calls itself. One of the favorite uses of recursion is walking a network. Geospatial applications use networks all the time: electrical grids, stream systems, and storm sewers are all directed networks (they have unidirectional flow).

Here&#8217;s an example of network walking using a simple collection of segments. As is common in many GIS applications, the segment are implicitly connected &#8212; their end points are coincident with the start points of other segments.

<pre>CREATE TABLE network ( segment geometry, id integer primary key );

INSERT INTO network VALUES ('LINESTRING(1 1, 0 0)', 1);<br />INSERT INTO network VALUES ('LINESTRING(2 1, 1 1)', 2);<br />INSERT INTO network VALUES ('LINESTRING(1 2, 1 1)', 3);<br />INSERT INTO network VALUES ('LINESTRING(3 1, 2 1)', 4);<br />INSERT INTO network VALUES ('LINESTRING(3 2, 2 1)', 5);<br />INSERT INTO network VALUES ('LINESTRING(2 3, 1 2)', 6);<br />INSERT INTO network VALUES ('LINESTRING(1 3, 1 2)', 7);<br />INSERT INTO network VALUES ('LINESTRING(4 2, 3 2)', 8);<br />INSERT INTO network VALUES ('LINESTRING(3 4, 2 3)', 9);<br />INSERT INTO network VALUES ('LINESTRING(2 4, 2 3)', 10);<br />INSERT INTO network VALUES ('LINESTRING(1 4, 1 3)', 11);<br />INSERT INTO network VALUES ('LINESTRING(4 3, 4 2)', 12);<br />INSERT INTO network VALUES ('LINESTRING(4 4, 3 4)', 13);

CREATE INDEX network_gix ON network USING GIST (segment);</pre><br />Visually, the network looks like this:

<img class="alignnone size-full wp-image-892" title="Network" src="http://blog.opengeo.org/wp-content/uploads/2010/07/screenshot_01.png" alt="Network" width="332" height="334" />

To walk our network, use a WITH clause that starts with one segment, then repeatedly adds the next downstream segment to the collection. In our case, the &#8220;next downstream segment&#8221; is defined as a segment whose start point is close to the end point of the current segment. We&#8217;ll walk down from segment 6.

<pre>WITH RECURSIVE walk_network(id, segment) AS (<br />    SELECT id, segment FROM network WHERE id = 6<br />  UNION ALL<br />    SELECT n.id, n.segment<br />    FROM network n, walk_network w<br />    WHERE ST_DWithin(ST_EndPoint(w.segment),ST_StartPoint(n.segment),0.01)<br />  )<br />SELECT id<br />FROM walk_network</pre><br />Which returns:

<pre> id<br />----<br />  6<br />  3<br />  1<br />(3 rows)</pre><br />From 6 to 3 to 1, correct! Once we have our walker producing the results we want, we can wrap more PostGIS and PostgreSQL functions around the walker to produce a finished product. Here&#8217;s a function that takes in an edge identifier and outputs a linestring based on the downstream path.

<pre>CREATE OR REPLACE FUNCTION downstream(integer)<br />RETURNS geometry<br />LANGUAGE sql<br />AS '<br />WITH RECURSIVE walk_network(id, segment) AS (<br />    SELECT id, segment FROM network WHERE id = $1<br />  UNION ALL<br />    SELECT n.id, n.segment<br />    FROM network n, walk_network w<br />    WHERE ST_DWithin(ST_EndPoint(w.segment),ST_StartPoint(n.segment),0.01)<br />  )<br />SELECT ST_MakeLine(ST_EndPoint(segment))<br />FROM walk_network<br />' IMMUTABLE;</pre><br />And here&#8217;s the function in action, generating the downstream path from segment 12.

<pre>=# SELECT ST_AsText(Downstream(12));

            st_astext<br />---------------------------------<br /> LINESTRING(4 2,3 2,2 1,1 1,0 0)<br />(1 row)</pre><br />Check the generated path against our network picture &#8212; looks good!

<img class="alignnone size-full wp-image-893" title="Path 12" src="http://blog.opengeo.org/wp-content/uploads/2010/07/screenshot_02.png" alt="Path 12" width="339" height="334" />