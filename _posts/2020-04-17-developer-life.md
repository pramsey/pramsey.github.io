---
layout: post
title: Developers Diary 1
date: '2020-04-16T00:00:00-08:00'
author: Paul Ramsey
category: technology
tags:
- open source
- pandemic
- diary
comments: True
image: "2020/diary.jpg"
---

I'm not a particularly good developer.

I don't plan well, I tend to hack first and try and find the structure afterwards. I am easily distracted. It takes me an exceedingly long time to marshal a problem in my head enough to attack it.

That said, the enforced slow-down from pandemic time has given me the opportunity to sit and look at code, knowing nothing else is coming down the pipe. There are no talks to prepare, no big-think keynotes to draft. I enjoy those things, and I **really** enjoy the ego-boost of giving them, but the preparation of them puts me in a mental state that is not conducive to doing code work.

So the end of travel has been good, for at least one aspect of my professional work.

## The Successful Failure

Spatial operations against large objects have always been a performance hot spot.

The first problem is that large objects are ... large. So if you have algorithms that scale O(n^2) on the number of vertices large objects will kill you. Guess what? Distance, intersects tests, and so on are all O(n^2) in their basic implementations.

We solved this problem a long time ago in PostGIS by putting in an extra layer of run-time indexing. 

![INDEXING!]({{ site.images }}/2020/indexing.gif)

During a query (for those functions where it makes sense) if we see the same object twice in a row, we build an index on the edges of that object and keep the index in memory, for the life of the query. For joins in particular, this pattern of "seeing the same big thing multiple times" is very common.

This one small trick is one reason PostGIS is so much faster than "the leading brands".

However, in order to "see the same object twice" we have to, for each function call in the query, retrieve the whole object, in order to compare it against the one we are holding in memory, to **see if it is the same**. 

Here we run into an issue with our back-end. PostgreSQL deals with large objects by (a) compressing them and (b) cutting the compressed object into slices and storing them in a side table. This all happens in the background, and is why you can store 1GB objects transparently in a database that has only an 8KB page size.

It's quite computationally expensive, though. So much so that I found that simply bypassing the compression part of this feature [could provide 5x performance gains](http://blog.cleverelephant.ca/2018/09/postgis-external-storage.html) on our spatial join workload.

![Faster]({{ site.images }}/2020/faster.gif)

At a [code sprint in 2018](http://blog.cleverelephant.ca/2018/09/postgis-sprint-1.html#serialization), the PostGIS team agreed on the necessary steps to work around this long-standing performance issue.

* Enhance PostgreSQL to allow partial decompression. This would allow the PostGIS caching system to retrieve just a **little bit** of large objects and use that part to determine if the object was not already in the cache.
* Enhance the PostGIS serialization scheme to add a hashcode at the front of each large object. This way "is this a new object" could be answered with just a few bytes of hash, instead of checking the whole object.
* Actually update the caching code code to use hash code and avoid unneccessary object retrievals.

Since this involved a change in PostgreSQL, which runs on an annual release cycle, and a change to the PostGIS serialization scheme, which is a major release marker, the schedule for this work was... long term.

![Long Term]({{ site.images }}/2020/sisyphus.gif)

Still, I managed to slowly chip away at it, goal in mind:

* Last year I got [compressed TOAST slicing](https://www.postgresql.org/message-id/CACowWR07EDm7Y4m2kbhN_jnys%3DBBf9A6768RyQdKm_%3DNpkcaWg%40mail.gmail.com) added to PostgreSQL, which provided immediate performance benefits for some existing large object workloads.
* I also [added the serialization update](https://trac.osgeo.org/postgis/ticket/4438) to PostGIS, which was part of the PostGIS 3.0 release in the fall of 2019.

That left adding the hash code to the front of the objects, and using that code in the PostGIS statement cache.

And this is where things fall apart.

![Things Fall Apart]({{ site.images }}/2020/fallapart.gif)

The old statement cache was focussed on ensuring the in-memory indexes were in place. It didn't kick in until the object had already been retrieved. So avoiding retrieval overhead was going to involve re-working the cache quite a bit, to handle both object and index caching. 

I started on the work, which still lives on [in this branch](https://github.com/pramsey/postgis/tree/master-statement-cache), but the many possible states of the cache (do I have part of an object? a whole object? an indexed object?) and the fact that it was used in multiple places by different indexing methods (geography tree, geometry tree, GEOS tree), made the change worrisomely complex.

And so I asked a question, that I should have asked years ago, to the [pgsql-hackers list](https://www.postgresql.org/message-id/CACowWR3JEgEQmWJNbRK6UyPcMHdsa8UHKW7i_OTLMfv05JaV2w%40mail.gmail.com):

> ... within the context of a single SQL statement, will the Datum values for a particular object remain constant?

Basically, could I use the datum values as unique object keys without retrieving the whole object? That would neatly remove any need to retrieve full objects in order to determine if the cache needed to be updated. As usual, Tom Lane [had the answer](https://www.postgresql.org/message-id/8196.1585870220%40sss.pgh.pa.us):

> Jeez, no, not like that.

Oh, "good news", I guess, my work is not in vain. Except wait, Tom included a codicil:

> The case where this would actually be worth doing, probably, is where you are receiving a toasted-out-of-line datum.  In that case you could legitimately use the toast pointer ID values (va_valueid + va_toastrelid) as a lookup key for a cache, as long as it had a lifespan of a statement or less. 

Hm. So for a subset of objects, it was possible to generate a unique key without retrieving the whole object. 

![Facepalm]({{ site.images }}/2020/facepalm.gif)

And that subset "toasted-out-of-line datum" were in fact the objects causing the hot spot: object large enough to have been compressed and then stored in a side table in 8KB chunks.

What if, instead of re-writing my whole existing in-memory index cache, I left that in place, and just added a [simple new cache](https://trac.osgeo.org/postgis/ticket/4657) that only worried about object retrieval. And only cached objects that it could obtain unique keys for, these "toasted-out-of-line" objects. Would that improve performance?

It did. By **20 times** on my [favourite spatial join benchmark](http://blog.cleverelephant.ca/2018/09/postgis-external-storage.html). In increased it by **5 times** on a join where only 10% of the objects were large ones. And on joins where none of the objects were large, the new code did not **reduce performance** at all. 

And here's the punch line: I've known about the large object hot spot for at least 5 years. Probably longer. I put off working on it because I thought the solution involved core changes to PostgreSQL and PostGIS, so first I had to put those changes in, which took a long time.

Once I started working on the "real problem", I spent a solid week:

* First on a branch to add hash codes, using the new serialization mechanisms from PostGIS 3.
* Then on a unified caching system to replace the old in-memory index cache.

And then **I threw all that work away**, and in about 3 hours, wrote and tested the [final patch](https://github.com/postgis/postgis/commit/8b548a4697490b7e45508b91cb340eb79b424a92) that gave a **20x** performance boost.

So, was this a success or a failure? 

![Stupid]({{ site.images }}/2020/stupid.gif)

I've become inured to the huge mismatch in "time spent to code produced", particularly when debugging. Spending 8 hours stepping through a debugger to generate a one-line patch is pretty routine.

But something about the mismatch between my grandious and complex solution (partial retrieval! hash code!) and the final solution (just ask! try the half-measure, see if it's better!) has really gotten on my nerves.

I like the win, but the path was a long and windy one, and PostGIS users have had slower queries than necessary for **years** because I failed to pose my simple question to the people who had an answer.

## The Successful Success

Contra to that story of the past couple weeks, this week has been a raging success. I keep pinching myself and waiting for something to go wrong.

A number of years ago, JTS got an improvement to robustness in some operations by doing determinant calculations in higher precision than the default IEEE double precision.

Those changes didn't make it into GEOS. There was an experimental branch, that [Mateusz Loskot](https://github.com/mloskot/geos) put together, and it sat un-merged for years, until I picked it up last fall, rebased it and merged it. I did so thinking that was the fastest way, and probably it was, but it included a dependency on a full-precision math library, [ttmath](https://www.ttmath.org/), which I added to our tree.

![Stupid]({{ site.images }}/2020/math.gif)

Unfortunately, ttmath is basically unmaintained now. 

And ttmath is arbitrary precision, while we really only need "higher precision". JTS just uses a "[double double](https://github.com/locationtech/jts/blob/master/modules/core/src/main/java/org/locationtech/jts/math/DD.java)" implementation, that uses the register space of two doubles for higher precision calculations.

And ttmath doesn't support big-endian platforms (like Sparc, Power, and other chips), which was the real problem. We couldn't go on into the future without support for these niche-but-not-uncommon platfors.

And ttmath includes some fancy assembly language that makes the build system more complex.

Fortunately, the JTS [DD](https://github.com/locationtech/jts/blob/master/modules/core/src/main/java/org/locationtech/jts/math/DD.java) is really not that large, and it has no endian assumptions in it, so I [ported it](https://github.com/libgeos/geos/pull/303) and tested it out against ttmath.

It's **smaller**.

It's **faster**. (About 5-10%. Yes, even though it uses no special assembly tricks, probably because it doesn't have to deal with arbitrary precision.)

And here's the huge surprise: **it caused zero regression failures**! It has exactly the same behaviour as the old implementation! 

![Perfect]({{ site.images }}/2020/perfect.gif)

So needless to say, once the branch was stable, I merged it in and stood there in wonderment. It seems implausable that something as foundational as the math routines could be swapped out without breaking **something**.

The whole thing took just a few days, and it was so painless that I've also made a patch to the 3.8 stable series to bring the new code back for big endian platform support in the mean time.

The next few days I'll be doing ports of JTS features and fixes that are net-new to GEOS, contemplative work that isn't too demanding.

Some days everything is easy.

Some days everything is hard.

Don't let the hard days hold you back!

![Perfect]({{ site.images }}/2020/koolaid.gif)
