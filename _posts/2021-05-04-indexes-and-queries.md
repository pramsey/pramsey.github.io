---
layout: post
title: 'Spatial Indexes and Bad Queries'
date: '2021-05-04T00:00:00-08:00'
author: Paul Ramsey
category: technology
tags:
- postgis
- postgresql
- indexes
comments: True
image: "2021/flames.jpg"
---

So, this happened:

![Tweet about Indexes]({{ site.images }}/2021/index-tweet.png)

Basically a GeoDjango user [posted some workarounds to some poor performance](https://dizhak.com/query-objects-with-geodjango-part-2) in spatial queries, and the original query was truly awful and the workaround not a lot better, so I snarked, and the GeoDjango maintainer reacted in kind.

Sometimes a guy just wants to be a prick on the internet, you know? But still, I did raise the **red flag of snarkiness**, so it it seems right and proper to pay the fine.

I come to this not knowing entirely the contract GeoDjango has with its users in terms of "hiding the scary stuff", but I will assume for these purposes that:

* Data can be in any coordinate system.
* Data can use geometry or geography column types.
* The system has freedom to create indexes as necessary.

So the system has to cover up a lot of variability in inputs to hide the scary stuff.

We'll assume a table name of **the_table** a geometry column name of **geom** and a geography column name of **geog**.

## Searching Geography

This is the easiest, since geography queries conform to the kind of patterns new users expect: the coordinates are in lon/lat but the distances are provided/returned in metres.

Hopefully the column has been spatially indexed? You can check in the system tables. 

```sql
SELECT * 
FROM pg_indexes 
WHERE tablename = 'the_table';
```

Yes, there are more exact ways to query the system tables for this information, I give the simple example for space reasons.
{: .note }

If it has not been indexed, you can make a geography index like this:

```sql
CREATE INDEX the_table_geog_x 
  ON the_table
  USING GIST (geog);
```

And then a "buffered" query, that finds all objects within a radius of an input geometry (any geometry, though only a point is shown here) looks like this.

```sql
SELECT *
FROM the_table
WHERE ST_DWithin(
    the_table.geog,
    ST_SetSRID(ST_MakePoint(%lon, %lat), 4326),
    %radius
    );
```

Note that there is no "buffering" going on here! A radius search is logically equivalent and does not pay the cost of building up buffers, which is an expensive operation.

Also note that, logically, **ST_DWithin(A, B, R)** is the same as **ST_Distance(A, B) < R**, but in **execution** the former can leverage a spatial index (if there is one) while the latter cannot.

## Indexable Functions

Since I mention that **ST_DWithin()** is indexable, I should list all the functions that can make use of a spatial index:

* [ST_Intersects()](http://postgis.net/docs/ST_Intersects.html)
* [ST_Contains()](http://postgis.net/docs/ST_Contains.html)
* [ST_Within()](http://postgis.net/docs/ST_Within.html)
* [ST_DWithin()](http://postgis.net/docs/ST_DWithin.html)
* [ST_ContainsProperly()](http://postgis.net/docs/ST_ContainsProperly.html)
* [ST_CoveredBy()](http://postgis.net/docs/ST_CoveredBy.html)
* [ST_Covers()](http://postgis.net/docs/ST_Covers.html)
* [ST_Overlaps()](http://postgis.net/docs/ST_Overlaps.html)
* [ST_Crosses()](http://postgis.net/docs/ST_Crosses.html)
* [ST_DFullyWithin()](http://postgis.net/docs/ST_DFullyWithin.html)
* [ST_3DIntersects()](http://postgis.net/docs/ST_3DIntersects.html)
* [ST_3DDWithin()](http://postgis.net/docs/ST_3DDWithin.html)
* [ST_3DDFullyWithin()](http://postgis.net/docs/ST_3DDFullyWithin.html)
* [ST_LineCrossingDirection()](http://postgis.net/docs/ST_LineCrossingDirection.html)
* [ST_OrderingEquals()](http://postgis.net/docs/ST_OrderingEquals.html)
* [ST_Equals()](http://postgis.net/docs/ST_Equals.html)

And for a bonus there are also a few operators that access spatial indexes.

* **geom_a && geom_b** returns true if the bounding box of **geom_a** intersects the bounding box of **geom_b** in 2D space.
* **geom_a &&& geom_b** returns true if the bounding box of **geom_a** intersects the bounding box of **geom_b** in ND space (an ND index is required for this to be index assisted),

## Searching Planar Geometry

If the data are planar, then spatial searching should be relatively easy, even if the input geometry is not in the same coordinate system.

First, is your data planar? Here's a quick-and-dirty query that returns true for geographic data and false for planar.

```sql
SELECT srs.srtext ~ '^GEOGCS' 
FROM spatial_ref_sys srs
JOIN geometry_columns gc
ON srs.srid = gc.srid
WHERE gc.f_table_name = 'the_table'
```

Again, do you have a spatial index on your geometry column? Check!

```sql
CREATE INDEX the_table_geom_x 
  ON the_table
  USING GIST (geom);
```

Now, **assuming query coordinates in the same planar projection as the data**, a fast query will look like this:

```sql
SELECT *
FROM the_table
WHERE ST_DWithin(
    geom,
    ST_SetSRID(ST_MakePoint(%x, %y), %srid)
    %radius
    );
```

But what if users are feeding in queries in geographic coordinates? No problem, just convert them to planar before querying:

```sql
SELECT *
FROM the_table
WHERE ST_DWithin(
    geom,
    ST_Transform(
        ST_SetSRID(ST_MakePoint(%lon, %lat), 4326), 
        %srid)
    %radius
    );
```

Note that here we are transforming the geography query to planar, **not** transforming the planar column to geographic! 

Why? There's only one query object, and there's potentially 1000s of rows of table data. And also, the **spatial index** has been built on the planar data: it cannot assist the query unless the query is in the same projection.

## Searching Lon/Lat Geometry

This is the hard one. It is quite common for users to load geographic data into the "geometry" column type. So the database understands them as planar (that's what the geometry column type is for!) while their units (longitude and latitude) are in fact **angular**.

There are benefits to staying in the geometry column type: 

* There are far more functions native to geometry, so you can avoid a lot of casting.
* If you are mostly working with planar queries you can get better performance from 2D functions.

However, there's a huge downside: questions that expect metric answers or metric parameters can't be answered. [ST_Distance()](http://postgis.net/docs/ST_Distance.html) between two geometry objects with lon/lat coordinates will return an answer in... "degrees"? Not really an answer that makes any sense, as cartesian math on anglar coordinates returns **garbage**.

So, how to get around this conundrum? First, the system has to recognize the conundrum!

* Is the column type "geometry"?
* Is the SRID a long/lat coordinate system? (See test query above.)

Both yes? Ok, this is what we do.

First, create a **functional index** on the geography version of the geometry data. (Since you're here, make a standard geometry index too, for other purposes.)

```sql
CREATE INDEX the_table_geom_geog_x
ON the_table
USING GIST (geography(geom));

CREATE INDEX the_table_geom
ON the_table
USING GIST (geom);
```

Now we have an index that understands geographic coordinates!

All we need now is a way to query the table that uses that index efficiently. The key with functional indexes is to ensure the function you used in the index shows up in your query.

```sql
SELECT * 
FROM the_table
WHERE ST_DWithin(
    geography(geom),
    geography(ST_SetSRID(ST_MakePoint(%lon, %lat), 4326))
    %radius
    );
```

What's going on here? By using the "geography" version of **ST_DWithin()** (where both spatial arguments are of type "geography") I get a search in geography space, and because I have created a functional index on the geography version of the "geom" column, I get it fully indexed.

## Random Notes

* The [user blog post](https://dizhak.com/query-objects-with-geodjango-part-2) asserts incorrectly that their best performing query is much faster because it is "using the spatial index".

```sql
SELECT 
    "core_searchcriteria"."id", 
    "core_searchcriteria"."geo_location"::bytea,
     "core_searchcriteria"."distance",
     ST_DistanceSphere(
        "core_searchcriteria"."geo_location", 
        ST_GeomFromEWKB('\001\001\000\000 \346\020\000\000\000\000\000\000\000@U@\000\000\000\000\000\000@@'::bytea)) AS "ds" 
     FROM "core_searchcriteria" 
        WHERE ST_DistanceSphere(
            "core_searchcriteria"."geo_location", 
            ST_GeomFromEWKB('\001\001\000\000 \346\020\000\000\000\000\000\000\000@U@\000\000\000\000\000\000@@'::bytea)
        ) <= "core_searchcriteria"."distance";
```

* However, the **WHERE** clause is just not using any of the spatially indexable functions. Any observed speed-up is just because it's less brutally ineffecient than the other queries.

* Why was the original brutally inefficient?

```sql
SELECT 
    "core_searchcriteria"."id", 
    "core_searchcriteria"."geo_location"::bytea, 
    "core_searchcriteria"."distance", 
    ST_Buffer(
        CAST("core_searchcriteria"."geo_location" AS geography(POINT,4326)), "core_searchcriteria"."distance"
        )::bytea AS "buff" FROM "core_searchcriteria" 
    WHERE ST_Intersects(
        ST_Buffer(
            CAST("core_searchcriteria"."geo_location" AS geography(POINT,4326)), "core_searchcriteria"."distance"), 
        ST_GeomFromEWKB('\001\001\000\000 \346\020\000\000\000\000\000\000\000@U@\000\000\000\000\000\000@@'::bytea)
    )
```

* The **WHERE** clause converts the **entire contents of the data column** to geography and then buffers **every single object** in the system.
* It then compares **all** those buffered objects to the query object (what, no index? no).
* Since the column objects have all been buffered... any spatial index that might have been built on the objects is unusable. The index is on the originals, not on the buffered objects.

