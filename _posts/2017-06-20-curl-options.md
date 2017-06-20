---
layout: post
title: CURL Options and Availability Version
date: '2017-06-20T08:00:00-08:00'
author: Paul Ramsey
category: technology
tags:
- postgresql
- http
- curl
- sql
comments: True
image: "2017/curl.png"
---

I've been adding support for [arbitrary CURL options](https://github.com/pramsey/pgsql-http/pull/44) to [http-pgsql](https://github.com/pramsey/pgsql-http), and have bumped up against the classic problem with linking external libraries: different functionality in different versions.

CURL has a [huge collection of options](https://curl.haxx.se/libcurl/c/easy_setopt_options.html), and different versions have different support, but **for any given options, what versions support it**? This turns out to be a fiddly question to answer in general. Each option has availability in the documentation page, but finding availability for **every** option is a pain. 

So, I've scraped the documentation and put the answers in a [CSV file](https://gist.github.com/pramsey/a61d6ec6e4cb737f6ef7c26dba07ddcf#file-curl-options-csv), along with the hex-encoded version number that CURL exposes in `#define LIBCURL_VERSION_NUM`.

<script src="https://gist.github.com/pramsey/a61d6ec6e4cb737f6ef7c26dba07ddcf.js?file=curl-options.csv"></script>


If you need to re-run the table as new versions come out, the [Python script](https://gist.github.com/pramsey/a61d6ec6e4cb737f6ef7c26dba07ddcf) is also in the Gist.

