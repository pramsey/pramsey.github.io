---
layout: post
title: Valgrinding PostGIS
date: '2008-08-16T15:35:00.001-07:00'
author: Paul Ramsey
tags: 
modified_time: '2008-08-17T08:49:37.587-07:00'
blogger_id: tag:blogger.com,1999:blog-14903426.post-8151750573740419758
blogger_orig_url: http://blog.cleverelephant.ca/2008/08/valgrinding-postgis.html
comments: True
---

<img src="http://valgrind.org/images/valgrind-100.png" width="167" height="49" style="float:right;padding:5px" />So, you want to be a super-hero?  How about tracking down memory leaks and otherwise using valgrind to make PostGIS a cleaner and better system?  However, getting PostGIS *into* valgrind can be a bit tricky.

First of all, what is [valgrind](http://www.valgrind.org)?  It's a tool for finding memory leaks and other memory issues in C/C++ code.  It only runs under Linux, so you do need to have sufficiently portable code to run it there.  Many memory checking tools rely on "static code analysis", basically looks at what your code *says it does* and seeing if you have made any mistakes.  These kinds of tools have to be very clever, since they not only need to understand the language, they have to understand the structure of your code.  Valgrind takes the opposite tack &mdash; rather than inspect your code for what it says it does, it runs your code inside an emulator, and sees what it *actually does*.  Running inside valgrind, every memory allocation and deallocation can be tracked and associated with a particular code block, making valgrind a very effective memory debugger.

In order to get the most useful reports, you have to compile your code with minimal optimization flags, and with debugging turned on.  To grind both GEOS and PostGIS simultaneously, compile GEOS and PostGIS with the correct flags:

    # Make GEOS:
    CXXFLAGS="-g -O0" ./configure
    make clean
    make
    make install
    
    # Make PostGIS:
    CFLAGS="-g -O0" ./configure --with-pgconfig=/usr/local/pgsql/bin/pg_config
    make clean
    make
    make install
    
Once you have your debug-enabled code in place, you are ready to run valgrind.  Here things get interesting!  Usually, PostgreSQL is run in multi-user mode, with each back-end process spawned automatically as connections come in.  But, in order to use valgrind, we have to run our process *inside* the valgrind emulator.  How to do this?

Fortunately, PostgreSQL supports a "single user mode".  Shut down your database instance (`pg_ctl -D /path/to/database stop`) first.  Then invoke a postgres backend in single-user mode:

    echo "select * from a, b where st_intersects(a.the_geom, b.the_geom)" | \
      valgrind \
        --leak-check=yes \
        --log-file=valgrindlog \
        /usr/local/pgsql/bin/postgres -D /usr/local/pgdata --single postgis
        
So, here we are echoing the SQL statement we want tested, and piping it into a valgrind-wrapped instance of single-user PostgreSQL.  Everything will run much slower than usual, and valgrind will output a report to the valgrindlog file detailing where memory blocks are orphaned by the code.

