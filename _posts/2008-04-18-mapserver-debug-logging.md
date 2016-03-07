---
layout: post
title: Mapserver Debug Logging
date: '2008-04-18T08:51:00.001-07:00'
author: Paul Ramsey
tags: 
modified_time: '2008-04-18T08:55:06.421-07:00'
blogger_id: tag:blogger.com,1999:blog-14903426.post-1505517466525390416
blogger_orig_url: http://blog.cleverelephant.ca/2008/04/mapserver-debug-logging.html
---

Daniel Morissette spills the beans on the mapserver-users list:

> IIRC, LOG only logs some info on the mapserv request status at the end of its execution. I don't use it much and don't know much about it.
>
> To get debugging output, with MapServer 5.0+, set:
>
> CONFIG "MS_ERRORFILE" "/var/tmp/ms.log"
>
> ... and then set DEBUG level (ON, or number between 1 and 5) at the top-level in the mapfile and in each layer for which you want debugging output.
>
> More details are available in RFC-28: http://mapserver.gis.umn.edu/development/rfc/ms-rfc-28

If there is something definitively "bad" about modern Mapserver it is the migration of configuration directives into "magic string" blocks of the map file, which are much less well documented that the "official" elements of the file.  

`CONFIG`, `PROCESSING`, `METADATA`, that's right, I'm looking at you.