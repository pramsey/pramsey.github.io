---
layout: post
title: Building CUnit from Source
date: '2014-12-03T10:33:00.002-08:00'
author: Paul Ramsey
category: technology
tags:
- cunit
- c
- development
modified_time: '2014-12-07T11:45:03.844-08:00'
blogger_id: tag:blogger.com,1999:blog-14903426.post-4092334853861029408
blogger_orig_url: http://blog.cleverelephant.ca/2014/12/building-cunit-from-source.html
comments: True
---

I haven't had to build CUnit myself for a while, because most of the systems I work with have it in their packaged software repositories, but for Solaris it's not there, and it turns out, it's quite painful to build! 

* First, the latest version on sourceforge, 2.1.3, is incorrectly bundled, with files (config.h.in) missing, so you have to use 2.1.2. 
* Second, the directions in the README don't include all the details of what autotools commands need to be run. 

Here's the commands I finally used to get a build. Note that you do need to run `libtoolize` to get some missing support scripts installed, and that you need to also run automake in "add missing" mode to get let more support scripts. Then and only then do you get a build. 

    wget http://downloads.sourceforge.net/project/cunit/CUnit/2.1-2/CUnit-2.1-2-src.tar.bz2
    tar xvfj CUnit-2.1-2.tar.bz2
    cd CUnit-2.1-2
    libtoolize -f -c -i \
      && aclocal \
      && autoconf \
      && automake --gnu --add-missing \
      && ./configure --prefix=/usr/local \
      && make \
      && make install
      
**Update:** The `bootstrap` file does provide the required autotools flags.
