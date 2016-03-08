---
layout: post
title: FastCGI on OS/X Leopard
date: '2008-05-12T14:03:00.000-07:00'
author: Paul Ramsey
tags: 
modified_time: '2011-08-17T11:13:55.819-07:00'
blogger_id: tag:blogger.com,1999:blog-14903426.post-3200481563505181999
blogger_orig_url: http://blog.cleverelephant.ca/2008/05/fastcgi-on-osx-leopard.html
comments: True
---

A post for posterity.

OK, so you want to run FastCGI on OS/X 10.5, how does that work? If you've just followed the directions and used your usual UNIX skillz, you'll have dead-ended on this odd error:

`httpd: Syntax error on line 115 of /private/etc/apache2/httpd.conf: Cannot load /usr/libexec/apache2/mod_fastcgi.so into server: dlopen(/usr/libexec/apache2/mod_fastcgi.so, 10): no suitable image found.  Did find:\n\t/usr/libexec/apache2/mod_fastcgi.so: mach-o, but wrong architecture`

This is the architecture of your DSO not matching the x86_64 architecture of the build shipped with OS/X. So we must build with the correct flags in place.

Here's the steps from scratch.

    curl http://www.fastcgi.com/dist/mod_fastcgi-2.4.6.tar.gz > mod_fastcgi-2.4.6.tar.gz
    tar xvfz mod_fastcgi-2.4.6.tar.gz
    cd mod_fastcgi-2.4.6
    cp Makefile.AP2 Makefile
    
Now edit `Makefile` and change `top_dir` to `/usr/share/httpd` and add a line `CFLAGS=-arch x86_64`.

    make
    sudo cp .libs/mod_fastcgi.so /usr/libexec/apache2
    
Now edit `/private/etc/apache2/httpd.conf` and add a line `LoadModule fastcgi_module libexec/apache2/mod_fastcgi.so`.  Run `sudo apachectl restart` and you are now loaded.  You'll need to enable FastCGI for your applications [as described](http://www.fastcgi.com/mod_fastcgi/docs/mod_fastcgi.html) in the documentation.

