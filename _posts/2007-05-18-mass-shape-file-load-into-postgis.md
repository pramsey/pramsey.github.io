---
layout: post
title: Mass Shape File Load into PostGIS
date: '2007-05-18T10:48:00.000-07:00'
author: Paul Ramsey
tags: 
modified_time: '2007-05-18T10:59:41.819-07:00'
blogger_id: tag:blogger.com,1999:blog-14903426.post-2000071596975314912
blogger_orig_url: http://blog.cleverelephant.ca/2007/05/mass-shape-file-load-into-postgis.html
comments: True
---

I needed some test data to do some performance investigations, and had to load 235 shape files, all of identical schema.  Here's what I did.

First, get the table schema into the database, by loading a small file, and then deleting the data.  We delete the data so we can loop through all the files later without worrying about duplicating the data from the initial file.

    shp2pgsql -s 3005 -i -D lwssvict.shp lwss | psql mydatabase
    psql -c "delete from lwss" mydatabase

Then use the shell to loop through all the shape files and append them into the table.

    foreach f (*.shp)
    foreach? shp2pgsql -s 3005 -i -D $f -a lwss | psql mydatabase
    end

Note the "-a" switch to tell ``shp2pgsql`` we are in append mode, rather than the default create mode.  Add a spatial index, and we're done.

    psql -c "create index lwss_gix on lwss using gist (the_geom)" mydatabase

Seven hundred thousand line segments, ready to play!

    psql -c "select count(*) from lwss" mydatabase
    
    count
    --------
     755373
    (1 row)