---
layout: post
title: 'Some PostGIS Users'
date: '2022-06-20T00:00:00-08:00'
author: Paul Ramsey
category: technology
tags:
- postgis
comments: True
image: "2022/elemap.jpg"
---

Last week, I wrote that [getting large organizations to cop to using PostGIS](/2022/06/postgis-logos.html) was a hard lift, despite that fact that, anecdotally, I know that there is massive use of PostGIS in every sector, at every scale of institution.

## Simple Clues

Here's a huge tell that PostGIS is highly in demand: despite the fact that PostGIS is a relatively complex extension to build (it has numerous dependencies) and deploy (the upgrade path between versions can be complex) **every single cloud offering of PostgreSQL includes PostGIS**.

[AWS](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Appendix.PostgreSQL.CommonDBATasks.PostGIS.html), [Google Cloud](https://cloud.google.com/sql/docs/postgres/extensions#postgis), [Azure](https://docs.microsoft.com/en-us/azure/postgresql/single-server/concepts-extensions), [Crunchy Bridge](https://docs.crunchybridge.com/extensions-and-languages/postgis/), [Heroku](https://devcenter.heroku.com/articles/postgis), etc, etc. Also forked not-quite-Postgres things like [Aurora](https://aws.amazon.com/about-aws/whats-new/2021/10/amazon-aurora-postgresql-supports-postgis/) and [AlloyDB](https://cloud.google.com/alloydb/docs/reference/extensions). Also not-Postgres-but-trying things like [Cockroach](https://www.cockroachlabs.com/docs/stable/spatial-data.html) and [Yugabyte](https://docs.yugabyte.com/preview/explore/ysql-language-features/pg-extensions/).

If PostGIS was a niche hobbyist project...? Complete the sentence any way you like.

## Logos

True to form, I received a number of private messages from people working in or with major institutions you have heard of, confirming their PostGIS use, and the fact that the institution would not publicly validate it.

However, I also heard from a couple medium sized companies, which seem to be the only institutions willing to talk about how useful they find open source in growing their businesses.

<img src="{{ site.images }}/2022/foundryLogo.svg" width="200px" style="float:right;padding-left:10px;" />Hailey Eckstrand of [Foundry Spatial](https://foundryspatial.com/) writes to say:


> Foundry Spatial uses PostGIS in development and production. In development we use it as our GIS processing engine and warehouse. We integrate spatial data (often including rasters that have been loaded into PostGIS) into a watershed fabric and process summaries for millions of watersheds across North America. We often use it in production with open source web tooling to return results through an API based on user input. One of our more complex usages is to return raster results within polygons and along networks within a user supplied distance from a click location. We find the ease and power of summarizing and analyzing many spatial datasets with a single SQL query to be flexible, performant, efficient, and&hellip; FUN!

<img src="{{ site.images }}/2022/understory-logo.svg" width="200px" style="float:right;padding-left:10px;" />Dian Fay of [Understory](https://understoryweather.com) writes in:


> We use PostGIS at Understory to track and record storms, manage fleets of weather stations, and optimize geographic risk concentration for insurance. PostGIS lets us do all this with the database tools we already know &amp; love, and without severing the connections between geographic and other categories of information.

## More logos?

Want to appear in this space? [Email me!](mailto:pramsey@cleverelephant.ca)





