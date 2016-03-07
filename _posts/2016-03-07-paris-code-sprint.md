---
layout: post
title: 'Paris Code Sprint, PostGIS Recap'
date: '2016-03-07T12:00:00-08:00'
modified_time: '2016-03-07T12:00:00-08:00'
author: Paul Ramsey
category: technology
tags:
- oss
- postgis
- cartodb
---

At the best of times, I find it hard to generate a lot of 
sympathy for my work-from-home lifestyle as an international
coder-of-mystery. However, the last few weeks have been especially
difficult, as I try to explain my week-long business trip
to Paris, France to participate in an annual [OSGeo Code Sprint](https://wiki.osgeo.org/wiki/Paris_Code_Sprint_2016).

<a href="https://wiki.osgeo.org/wiki/Paris_Code_Sprint_2016"><img src="https://wiki.osgeo.org/images/archive/d/d1/20160204192143%21Logo-TOSPrint_Paris.png" height="178" width="300" alt= "Paris Code Sprint" /></a>

Yes, really, I "had" to go to Paris for my work. Please, 
stop sobbing. Oh, that was light jealous retching? Sorry about
that.

Anyhow, my (lovely, wonderful, superterrific) employer, [CartoDB](http://cartodb.com)
was an event sponsor, and sent me and my co-worker [Paul
Norman](https://github.com/pnorman) to the event, which we 
attended with about 40 other hackers on 
[PDAL](http://pdal.io), [GDAL](http://gdal.org), [PostGIS](http://postigs.net), 
[MapServer](http://mapserver.org), [QGIS](http://qgis.org), [Proj4](http://proj4.org),
[PgPointCloud](http://github.com/pgpointcloud) etc.

Paul Norman got set up to do PostGIS development and crunched through a
number couple feature enhancements. The [feature enhancement ideas](https://wiki.osgeo.org/wiki/Paris_Code_Sprint_2016_:_PostGIS_Agenda) were
courtesy of [Remi Cura](https://github.com/Remi-C), who brought in some great power-user ideas for
making the functions more useful. As developers, it is frequently hard
to distinguish between features that are interesting to **us** and features
that are using to **others** so having feedback from folks like
Remi is invaluable.

The [Oslandia](http://oslandia.com) team was there in force, naturally, as they were the
organizers. Because they worki a lot in the 3D/[CGAL](http://www.cgal.org) 
space, they were interested in making CGAL faster, which meant they were
interested in some "expanded object header" experiments I did last
month. Basically the [EOH code](http://www.postgresql.org/message-id/20178.1423598435@sss.pgh.pa.us) allows you to return an unserialized
reference to a geometry on return from a function, instead of a flat
serialiation, so that calls that look like
`ST_Function(ST_Function(ST_Function()))` don't end up with a chain of
three serialize/deserialize steps in them. When the deserialize step
is expensive (as it in for their 3D objects) the benefit of this
approach is actually measureable. For most other cases it's not.

(The exception is in things like mutators, called from within
PL/PgSQL, for example doing array appends or insertions in a tight
loop. [Tom Lane](https://en.wikipedia.org/wiki/Tom_Lane_(computer_scientist)) wrote up this enhancement of PgSQL with examples for
array manipulation and did find big improvements for that narrow use
case. So we could make things like `ST_SetPoint()` called within
PL/PgSQL much faster with this
approach, but for most other operations probably the overhead of
allocating our objects isn't all that high to make it worthwhile.)

There was also a team from 
[Dalibo](http://www.dalibo.com/en/) and 
[2nd Quadrant](http://2ndquadrant.com). They worked on a 
[binding for geometry](http://blog.2ndquadrant.com/brin-postgis-codesprint2016-paris/)
to the 
[BRIN indexes](http://www.postgresql.org/docs/devel/static/brin-intro.html) (9.5+). 
I was pretty sceptical, since BRIN indexes require useful ordering, and
spatial data is not necessarily well ordered, unlike something like
time, for example. However, they got a prototype working, and showed
the usual good BRIN properties: indexes were extremely small and
extremely cheap to build. For narrow range queries, they were about 5x
slower than GIST-rtree, however, the differences were on the order of
25ms vs 5ms, so not completely unusable. They managed this result with
presorted data, and with some data in its "natural" order, which
worked because the "natural" order of GIS data is often fairly
spatially autocorrelated.

I personally thought I would work on merging the back-log of GitHub
pull-requests that have built up on the 
[PostGIS git mirror](https://github.com/postgis/postgis/pulls), 
and did manage to merge
several, both new ones from Remi's group and some old ones. I merged
in my 
[ST_ClusterKMeans()](http://postgis.net/docs/manual-dev/ST_ClusterKMeans.html)
clustering function, and [Dan Baston](https://github.com/dbaston) merged in his 
[ST_ClusterDBSCAN()](http://postgis.net/docs/manual-dev/ST_ClusterDBSCAN.html)
one, so PostGIS 2.3 will have a couple of new clustering implementations.

However, in the end I spent probably 70% of my time 
[on a blocker in 2.2](https://trac.osgeo.org/postgis/ticket/3429), 
which was related to upgrade. Because the bug manifests during
upgrade, when there are two copies of the `postgis.so` library floating
in memory, and because it only showed up on particular Ubuntu 
platforms, it was hard to debug: but in the end we found the problem
and put in a fix, so we are once again able to do upgrades on all
platforms. 

The other projects also got lots done, and there are more
write-ups at the [event feedback page](https://wiki.osgeo.org/wiki/Paris_Code_Sprint_2016_:_Feedback). 
Thanks to [Olivier Courtin](https://github.com/ocourtin) 
from Oslandia for taking on the heavy weight of 
organizing such an amazing event!

