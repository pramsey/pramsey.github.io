---
layout: post
title: Nothing, Nada, Zip, Bupkus
date: '2010-03-01T09:26:00.000-08:00'
author: Paul Ramsey
tags:
- ogc
- postgis
- iso
- wkb
modified_time: '2010-03-01T11:35:50.895-08:00'
blogger_id: tag:blogger.com,1999:blog-14903426.post-3893762606281830656
blogger_orig_url: http://blog.cleverelephant.ca/2010/03/nothing-nada-zip-bupkus.html
comments: True
---

There is nothing new under the sun, and I have been wrestling this week with writing out ISO-standard well-known binary from PostGIS. 

<img src="http://images.fanpop.com/images/image_uploads/Empty-Set-Symbol-random-241186_191_160.jpg" style="float:right;">

The most obvious difference is that the type numbers for encoding the presence of Z- and M-dimensions are not the ones described in the old [OGC extension document](http://portal.opengeospatial.org/files/?artifact_id=909) [OGC members only, [cited by Martin Daly](http://lists.osgeo.org/pipermail/postgis-devel/2004-December/000695.html) in 2004, and [extended further](http://svn.osgeo.org/postgis/trunk/doc/ZMSgeoms.txt) for PostGIS by Sandro Santilli that year] for WKB. Instead of setting high-bits to indicate the presence of Z and M, as OGC did, the ISO spec simply adds 1000. 

So, the ISO geometry number for a PolygonZ is `3 (Polygon) + 1000 = 1003`.

The, old OGC geometry number for a PolygonZ is `3 (Polygon) | 0x80000000 = 2147483651`. 

OGC seems more complex until you note that the function `WKB_HASZ(num)` can be written `(num & 0x80000000)`. While the ISO test is `(num >= 1000 && num < 2000)`. Setting flags for binary values (has-z, has-m, has-a-piece-of-pie) is nice. 

Anyhow, that change was well-known and expected. What I didn't expect was the amount of ambiguity surrounding the definition of an empty geometry in WKB.

To review, the spatial SQL definition includes the concept of an "empty geometry", which is an empty set of a particular geometry type. The empty geometry has more information than a simple database NULL, which is a typeless emptiness. A 'POLYGON ZM EMPTY' has an implied dimensionality. It makes some sense that ST_Intersection() of two disjoint polygons would return a 'POLYGON EMPTY'.

The ISO SQL/MM well-known text specification has clear directions for writing empty geometries of all types. In fact, I've just written two of them above: the type name plus the 'EMPTY' keyword.

For well-known binary, ISO SQL/MM includes the following useless guidance:

> i) Case:<br/>
> i) If &lt;point binary representation&gt; immediately contains a &lt;wkbpoint binary&gt;, then &lt;point binary representation&gt; is the well-known binary representation for an ST_Point value that is produced by &lt;wkbpoint binary&gt;.<br/>
> ii) Otherwise, &lt;point binary representation&gt; produces an empty set of type ST_Point

Representing an empty point in WKB is hard because there's nowhere obvious to indicate the lack of ordinates. But the ISO specification makes no attempt to solve the problem, they instead provide explicit guidance that is impossible to implement. Basically, if you are reading a WKB POINT and there are doubles after the TYPE number, you have a `POINT(x y)`. If not, you have a `POINT EMPTY`. All well and good, but how do you distinguish, in a collection of WKB geometries, between the presence of doubles in the byte stream and the presence of another geometry in the stream? You don't. 

The ISO guidance for empty Linestrings is even worse! 

> q) Case:<br/>
> i) If &lt;linestring binary representation&gt; immediately contains &lt;num&gt;, then &lt;linestring binary representation&gt; is the well-known binary representation for an ST_LineString value. Let APA be an ST_Point ARRAY value with cardinality of &lt;num&gt; that contains the ST_Point values specified by the immediately contained &lt;wkbpoint binary&gt;s. &lt;linestring binary representation&gt; produces an ST_LineString value as the result of the value expression: NEW ST_LineString(APA).<br/>
> ii) Otherwise, &lt;linestring binary representation&gt; produces an empty set of type ST_LineString.

As with the POINT case, the WKB reader is supposed to magically distinguish between an element of the current geometry (the &lt;num&gt;) in the byte-stream and an element of the *next* geometry in the byte-stream. And worse, the "clarifying" comment implicitly adds a **whole new kind of empty geometry**! What if the &lt;num&gt; is present, but the value is zero!?! 

This is where the snake starts eating its tail. The way that implementations of OGC WKB have been encoding EMPTY geometries has been to provide the type number and an element count of zero.  Back when PostGIS was first getting WKB support, Dave Blasby [wrestled with](http://lists.osgeo.org/pipermail/postgis-users/2003-April/002346.html) the fact that the specification did not describe how to encode EMPTY.  Mateusz Loskot recently [published some information](http://mateusz.loskot.net/2010/02/26/sqlgeometry-and-point-empty-in-wkb/) showing the WKB EMPTY implementation that Microsoft used for SQLServer. Their implementation is one of the options Dave described five years ago &ndash; there's only so many ways to solve this problem.

If ISO didn't like the use of a zero-valued &lt;num&gt; count as a way of indicating EMPTY, they had another option available, which was to follow the original OGC WKB standard and use bitmask flags on their type numbers. There could have been a bitmask for Z, a bitmask for M, and a bitmask for EMPTY. There could even have been a bitmask for SRID, fixing up a huge drawback in WKB, namely that WKB does not include a slot for the SRID, which is an important element in the geometry model.

Sidenote: As a result of WKB not having SRID support, it's not possible to round-trip a geometry through WKB without losing the SRID value. Try this standard SQL and see what happens: 

{% highlight sql %}
SELECT ST_SRID( 
 ST_GeomFromWKB(  
  ST_AsBinary( 
   ST_GeomFromText('POINT(0 0)', 4326) 
 )))
{% endhighlight %}

Then try the bastardized [PostGIS EWKB format](http://svn.osgeo.org/postgis/trunk/doc/ZMSgeoms.txt) instead: 

{% highlight sql %}
SELECT ST_SRID( 
 ST_GeomFromEWKB( 
  ST_AsEWKB( 
   ST_GeomFromText( 'POINT(0 0)', 4326)
 )))
{% endhighlight %}

As it stands now, the specification is out of synch with the implementations on the ground, which is bad news for the relevance of the specification. I will be implementing EMPTY using the same semantics as SQLServer, which will make the kinds of EMPTY PostGIS can represent slightly richer, but remain backwards compatible to the old schemes.

