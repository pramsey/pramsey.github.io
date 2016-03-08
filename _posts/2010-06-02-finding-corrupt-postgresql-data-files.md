---
layout: post
title: Finding Corrupt PostgreSQL Data Files
date: '2010-06-02T06:02:00.000-07:00'
author: Paul Ramsey
tags: 
modified_time: '2010-06-02T06:04:51.826-07:00'
blogger_id: tag:blogger.com,1999:blog-14903426.post-2386682083197092374
blogger_orig_url: http://blog.cleverelephant.ca/2010/06/finding-corrupt-postgresql-data-files.html
comments: True
---

While PostgreSQL itself will never create corrupt data files, that doesn't stop other processes or hardware failures for corrupting the files underneath the database, which can cause database crashes. Josh Williams of End Point provides a [super rundown](http://blog.endpoint.com/2010/06/tracking-down-database-corruption-with.html) of how to track and repair a file corruption.

