---
layout: post
title: The Minimum Abstraction
date: '2007-07-09T11:17:00.001-07:00'
author: Paul Ramsey
tags: 
modified_time: '2007-07-09T11:32:49.198-07:00'
blogger_id: tag:blogger.com,1999:blog-14903426.post-1041462765089407166
blogger_orig_url: http://blog.cleverelephant.ca/2007/07/minimum-abstraction.html
comments: True
---

So much work is done trying to create abstractions on top of relational databases, it is something of a crime!  The OGC's ebRIM implementation of a catalogue, is basically an abstraction that sits on a database.  The Hibernate framework is a Java abstraction that sits on a database.  Ruby on Rails is an abstraction that sits on a database.  It is almost as if we don't like our databases!  But they are so useful and flexible, let's expose them, instead of hiding them.

<img src="http://radio.weblogs.com/0105910/images/square_wheels.jpg" width="300" height="201" />

Most "web services" are just method calls that do little more than re-write input parameters into SQL, and return the result as XML!

Why not cut out the middle man, I say?  I propose the ur-web-service, just deploy this one web service and then Declare Victory in your corporate web services strategy:

https://yourserver.com/db2xml?sql=&lt;your urlencoded SQL here&gt;

Returns (for example):

&lt;Rows&gt;<br />&lt;Row type="string" name="first_name"&gt;Paul&lt;/Row&gt;<br />&lt;Row type="string" name="last_name"&gt;Ramsey&lt;/Row&gt;<br />&lt;/Rows&gt;

For security, pull the HTTP_AUTH_USER and password from the HTTP header and use those to create the database connection, that way all the security beyond simple access is handled by the existing database security layer.

I think this approach (let's call it the "brain dead approach") re-invents the minimum number of wheels while providing the maximum quantity of data access flexibility.  Perhaps I should write a book; no, a pamphlet; no, a leaflet; no, a business card; on "implementing brain dead web services for the enterprise".