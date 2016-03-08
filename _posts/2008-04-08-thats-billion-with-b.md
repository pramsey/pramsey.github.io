---
layout: post
title: That's Billion with a "B"
date: '2008-04-08T15:50:00.001-07:00'
author: Paul Ramsey
tags: 
modified_time: '2008-04-08T15:55:33.150-07:00'
blogger_id: tag:blogger.com,1999:blog-14903426.post-1151420551577195516
blogger_orig_url: http://blog.cleverelephant.ca/2008/04/thats-billion-with-b.html
comments: True
---

[This article](http://highscalability.com/skype-plans-postgresql-scale-1-billion-users) on scaling PostgreSQL to support Skype's operations is well worth a read for anyone running a high-end PostgreSQL installation.<img src="http://www.objects-of-design.com/UploadImages/ProductImages/LargeImages/Letter-B-260.jpg" width="130" height="145" style="float:right;padding:10px;" />

> PostgreSQL is used "as the main DB for most of [Skype's] business needs." Their approach is to use a traditional stored procedure interface for accessing data and on top of that layer proxy servers which hash SQL requests to a set of database servers that actually carry out queries. The result is a horizontally partitioned system that they think will scale to handle 1 billion users.

