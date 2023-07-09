---
layout: post
title: 'MapScaping Podcast: Pg_EventServ'
date: '2023-07-08'
author: Paul Ramsey
category: technology
tags:
- postgis
- websockets
- listen
- notify
comments: True
image: "2023/pgeventserv.jpg"
---

Last month I got to record a couple podcast episodes with the [MapScaping Podcast](https://mapscaping.com/podcast/rasters-in-a-database/)'s [Daniel O'Donohue](https://mapscaping.com/about-us/). One of them was on the benefits and many pitfalls of [putting rasters into a relational database](https://mapscaping.com/podcast/rasters-in-a-database/), and the other was about real-time events and pushing data change information out to web clients!

* [PostgreSQL – Listen and Notify Clients In Real Time](https://mapscaping.com/podcast/postgresql-listen-and-notify-clients-in-real-time/)

TL;DR: geospatial data tends to be more "visible" to end user clients, so communicating change to multiple clients in real time can be useful for "common operating" situations.

I also recorded a presentation about [pg_eventserv](https://github.com/crunchydata/pg_eventserv) for [PostGIS Day 2022](https://www.youtube.com/playlist?list=PLesw5jpZchudJTmRukWO1eP5-6zPpIm5x).

* [Web Sockets and Real-Time Updates for Postgres with pg_eventserv](https://www.youtube.com/watch?v=Z_nOzHmpY8M)