---
layout: post
title: Your Broken PostGIS Upgrade
date: '2016-08-10T09:05:00.004-07:00'
author: Paul Ramsey
category: technology
tags:
- upgrade
- postgis
- linux
comments: True
image: "2016/brick.jpg"
---

Since the Dawn of Time, people have found [PostGIS upgrades difficult and confusing](https://gis.stackexchange.com/questions/206412/how-can-i-do-a-soft-upgrade-from-postgis-2-1-4-to-2-2-2), and this is entirely to be expected, because a PostGIS upgrade consists of a number of interlocking parts. Sometimes, they "upgrade" their version of PostGIS and find out they've bricked their system. What gives?

<img src="{{ site.images }}{{ page.image }}" alt="{{ page.title }}" width="560" height="420" />

## What Makes PostGIS Work?

Before talking about upgrades, it's important to understand how PostGIS works at all, because that understanding is key to seeing how upgrade scenarios go bad.

PostGIS is a "run-time loadable library" for PostgreSQL. That means we have a block of C code that is added to a running PostgreSQL database. That C code sits in a "library file" which is named (for the current 2.2 version): `postgis-2.2.so`.

Just to add to the confusion: for Windows, the name of the library file is `postgis-2.2.dll`. For every rule, there must be an exception. For users of Apple OSX, yes, there's a further exception for you: even though most dynamic libraries on OSX are suffixed `.dylib`, the PostgreSQL modules on OSX are suffixed `.so`, just like their Linux counterparts.
{: .note }

The location of the `postgis-2.2.so` file will vary from system to system. 

The presence of the `postgis-2.2.so` alone is not sufficient to "PostGIS enable" a database. PostGIS consists of a large collection of SQL functions in the database.

The SQL functions are created when you run the `CREATE EXTENSION postgis` command. Until that time your database knows nothing about the existence or definition of the PostGIS functions.

Once the extension is installed, you can see the definitions of the PostGIS functions in the system tables. 

The use of dynamic function and type management catalogs is one of the things which makes PostgreSQL so incredibly flexible for extensions like PostGIS
{: .note }

{% highlight sql %}
SELECT * 
  FROM pg_proc 
  WHERE proname = 'st_pointonsurface';
{% endhighlight %}

    -[ RECORD 1 ]---+--------------------
    proname         | st_pointonsurface
    pronamespace    | 2200
    proowner        | 10
    prolang         | 13
    procost         | 100
    prorows         | 0
    provariadic     | 0
    protransform    | -
    proisagg        | f
    proiswindow     | f
    prosecdef       | f
    proleakproof    | f
    proisstrict     | t
    proretset       | f
    provolatile     | i
    pronargs        | 1
    pronargdefaults | 0
    prorettype      | 667466
    proargtypes     | 667466
    proallargtypes  | 
    proargmodes     | 
    proargnames     | 
    proargdefaults  | 
    prosrc          | pointonsurface
    probin          | $libdir/postgis-2.2
    proconfig       | 
    proacl          | 


Lots to see here, but most important bit is the **entry for the `probin` column**: `$libdir/postgis-2.2`. This function (like all the other PostGIS functions) is bound to a particular version of the PostGIS C library.

Those of you thinking forward can now begin to see where upgrades could potentially go wrong.

## How Things Go Wrong

### Package Managers

The most common way for things to go wrong is to upgrade the library on the system without upgrading the database. 

So, in Red Hat Linux terms, perhaps running:

    yum upgrade postgresql94-postgis
    
This seems straight-forward, but think about what a package manager does during an upgrade:

* Downloads a new version of the software
* Removes the old version
* Copies in the new version

So, if we had PostGIS 2.1.3 installed, and the latest version is 2.2.2, what has happend?

* The `postgis-2.1.so` file has been removed
* The `postgis-2.2.so` file has been added
* So, the `pg_proc` entries in every PostGIS-enabled database now point to a library file that **does not exist**

Fortunately this mismatch between the `pg_proc` entries and the system state is usually solved during the very next step of the upgrade. But it's a manual step, and if the DBA and system administrator are different people different schedules, it might not happen.

Your next step should be to go and update the SQL function definitions by running an extension upgrade on all your databases:

{% highlight sql %}
ALTER EXTENSION postgis UPDATE TO '2.2.2';
{% endhighlight %}

If you don't, you'll find that none of the PostGIS functions work. That, in fact, you cannot even dump your database. The very act of outputting a representation of the geometry data is something that requires the PostGIS C library file, and until you run `ALTER EXTENSION` the database doesn't know where the new library file is.

### Migrations

Since the use of `CREATE EXTENSION postgis` (available since PostgreSQL 9.1+ and PostGIS 2.0+) became commonplace, migrations now almost always "just work", which is excellent news. 

* When you dump a modern PostGIS-enabled database, that was created using the `CREATE EXTENSION postgis` command, the dump file just includes a `CREATE EXTENSION postgis` command of its own at the top.
* When you load the dump file into a new version of PostgreSQL even with a new version of PostGIS, the extension is created and the data magically loads.

**However**, there are still some old databases around that were created before the PostgreSQL extension system was invented, and when you dump them you get not only the data, but all the "custom" function and type definitions, including the defintions for PostGIS. A function definition looks like this:

{% highlight sql %}
CREATE OR REPLACE FUNCTION ST_PointOnSurface(geometry)
    RETURNS geometry
    AS '$libdir/postgis-2.2', 'pointonsurface'
    LANGUAGE 'c' IMMUTABLE STRICT; 
{% endhighlight %}

And look what is hiding inside of it: a reference to a **particular version** of the PostGIS library! So you cannot simply dump your old PostGIS 1.5 database on PostgreSQL 8.4 and load it into a fresh PostGIS 2.2 database on PostgreSQL 9.5: the function definitions won't reference the right library file.

The best bet for a really old database that was created without the extension mechanism is to use the "[hard upgrade](http://postgis.net/docs/postgis_installation.html#hard_upgrade)" process. The hard upgrade works by:

* Taking a special "custom-format" back-up that includes an object catalog;
* Filtering the back-up to clean out all the PostGIS-specific function and object definitions; and then
* Loading the "cleaned" back-up into a new database with the desired version of PostGIS already installed (using `CREATE EXTENSION postgis` this time, so you never have to hard upgrade again).

### Hacks

In the case of upgrades that change out the underlying library and other situations that result in a mismatch between the SQL definitions in the database and the state of the system, there are a couple hacks that provide short-term fixes for emergencies:

* **Symlink** the library name the database is looking for to the library name you have. So if your database wants `postgis-2.1.so` and all you have is `postgis-2.2.so`, you can `ln -s postgis-2.2.so postgis-2.1.so` and your database will "work" again.
* **Update the PostgreSQL catalog** definitions for the functions. As a super-user, you can do all kinds of dangerous things, and one of them is to just `UPDATE pg_proc SET probin = '$libdir/postgigs-2.2' WHERE probin ~ 'postgis-2.1'` 

Both hacks "work" because the PostGIS project doesn't change underlying function names often, and inter-version changes mostly involve adding functions to the C library, not removing old ones. 

However, there's no guarantee that an underlying function name hasn't change between versions, it's just unlikely. In the worst case, the function name hasn't changed, but the parameters have, so it's now possible that calling the function will crash your database. 

All this to say: **linking and SQL catalogue hacks should be used temporarily only** until you can properly upgrade your database using a hard upgrade.

