---
layout: post
title: PostgreSQL "Compatible" Aurora
date: '2016-12-11T08:09:00-08:00'
author: Paul Ramsey
category: technology
tags:
- postgis
- postgresql
- aws
comments: True
image: "2016/database-overloads.jpg"
---

<img src="{{ site.images }}{{ page.image }}" alt='{{ page.title }}' width="512" height="384" />

While I know full well that Amazon's marketing department doesn't need my help, I cannot resist flagging [this new development](https://aws.amazon.com/blogs/aws/amazon-aurora-update-postgresql-compatibility/) from the elves in Santa's AWS workshop:

> Today we are launching a preview of Amazon Aurora PostgreSQL-Compatible Edition. It offers ... high durability, high availability, and the ability to quickly create and deploy read replicas. Here are some of the things you will love about it:

> **Performance** – Aurora delivers up to 2x the performance of PostgreSQL running in traditional environments.

> **Compatibility** – Aurora is fully compatible with the open source version of PostgreSQL (version 9.6.1). On the stored procedure side, we are planning to support Perl, pgSQL, Tcl, and JavaScript (via the V8 JavaScript engine). We are also planning to support all of the PostgreSQL features and extensions that are supported in Amazon RDS for PostgreSQL.

> **Cloud Native** – Aurora takes full advantage of the fact that it is running within AWS.

The language Amazon uses around Aurora is really wierd -- they talk about "MySQL compatibility" and "PostgreSQL compatibility".  At an extreme, one might interpret that to mean that Aurora is a net-new database providing wire- and function-level compatibility to the target databases.  However, in the PostgreSQL case, the fact that they are additionally supporting PostGIS, the server-side languages, really the whole database environment, hints strongly that most of the code is actually PostgreSQL code. 

There is not a lot of reference material about what's going on behind the scenes, but [this talk](https://www.youtube.com/watch?v=CwWFrZGMDds) from re:Invent shows that most of the action is in the storage layer. For MySQL, since storage back-ends are pluggable, it's possible that AWS has added their own back-end. Alternately, they may be running a hacked up version of the InnoDB engine. 

For PostgreSQL, with only one storage back-end, it's pretty much a foregone conclusion that AWS have taken a fork and added some secret sauce to it. However, the fact that they are tracking the community version almost exactly (they currently offer 9.6.1) indicates that maybe their fork isn't particularly invasive. 

I'd want to wait a while before trusting a production system of record to Aurora PgSQL, but the idea of the cloud native PostgreSQL, with full PostGIS support, excites me to no end. RDS is already very very convenient, so RDS-with-better-performance and integration is just icing on the cake for me.

I, for one, welcome our new cloud database overlords.