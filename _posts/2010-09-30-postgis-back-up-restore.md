---
layout: post
title: PostGIS Back-up / Restore
date: '2010-09-30T09:47:00.000-07:00'
author: Paul Ramsey
tags: 
modified_time: '2010-09-30T10:29:39.746-07:00'
blogger_id: tag:blogger.com,1999:blog-14903426.post-4803293406955015956
blogger_orig_url: http://blog.cleverelephant.ca/2010/09/postgis-back-up-restore.html
comments: True
---

A very common question on PostGIS in production is "how do I upgrade", which is actually a variant on "how do I backup and restore"?

First, for patch version increases (e.g. X.Y.Z -> X.Y.(Z+1)) in PostgreSQL and PostGIS you do not need to do anything at all other than install the new software. The data can remain in place and everything will Just Work.

For minor version increases in PostgreSQL (e.g. X.Y.Z -> X.(Y+1).Z) you need to dump and restore. For minor version increases in PostGIS, you need to do a "soft upgrade", which means leaving the data in place, but running the upgrade scripts (e.g. postgis_upgrade_14_to_15.sql) after you install the software update.

Finally, for major version increases in PostgreSQL and PostGIS (e.g. X.Y.Z -> (X+1).Y.Z) you need to dump and restore.

Which brings me to the actual point I want to make: you can ensure the greatest ease in doing dump and restore of PostGIS data if you ensure that you store *no data* in the "public" schema. 

The "public" schema is where the PostGIS functions and system tables get installed, so if you dump that schema you get all those definitions in your dump. If those definitions are mixed in amongst your data, loading them into a fresh database gets tricky: are the paths to the libraries the same? are there function name clashes? (The utils/postgis_restore.pl script attempts manfully to strip out PostGIS components from a dump file to allow a clean restore, but it is hard to get 100% performance.)

If, on the other hand, all your data is neatly separated into its own schema, you can neatly backup *just that schema* and avoid having PostGIS system information mixed in with your data. That means you can easily restore your data into *any version of PostGIS and PostgreSQL that you like*. So upgrades are easy easy easy.

**Remember: Store your data in a schema other than "public".**

"But Paul," you say, "I already have a full database dump, does that mean I'm SOL?" No, but you will need a strong stomach. First, set up your new PostgreSQL. Create a blank database, load PostGIS into it. Now, load your backup file into that database. You **will see lots of errors**. However, these errors will be caused by old PostGIS function and type definitions from your dump file conflicting with the existing type definitions in your database. And since you want the new definitions, not the old ones, that's OK. Your load, despite all the noise and errors, should actually work. Once it's done, you can move your data into a nice separate schema, so that *next time* you can do a clean, error-free restore.

