---
layout: post
title: Adding PgSQL to PHP on OSX
date: '2017-10-12T06:00:00-08:00'
author: Paul Ramsey
category: technology
tags:
- pgsql
- php
- osx
comments: True
image: "2017/phppg.png"
---

I'm [yak shaving](http://whatis.techtarget.com/definition/yak-shaving) this morning, and one of the yaks I need to ensmooth is running a PHP script that connects to a PgSQL database. 

No problem, OSX ships with PHP! Oh wait, that PHP does not include PgSQL database support.

<img src="{{ site.images }}{{ page.image }}" alt="{{ page.title }}" />

At this point, one can either run to completely replace your in-build PHP with another PHP (probably good if you're doing modern PHP development and want something newer than 5.5) or you can add PgSQL to your existing PHP installation. I chose the latter.

The key is to **build the extension you want without building the whole thing**. This is a nice trick available in PHP, similar to the Apache module system for independent module development.

First, figure out what version of PHP you will be extending:
```
> php --info | grep "PHP Version"

PHP Version => 5.5.38
```
For my version of OSX, Apple shipped 5.5.38, so I'll pull down the code package for that version.

* [http://php.net/get/php-5.5.38.tar.bz2/from/a/mirror](http://php.net/get/php-5.5.38.tar.bz2/from/a/mirror)

Then, unbundle it and go to the php extension directory:
```
tar xvfz php-5.5.38.tar.bz2
cd php-5.5.38/ext/pgsql
```
Now the magic part. In order to build the extension, without building the whole of PHP, we need to tell the extension how the PHP that Apple ships was built and configured. How do we do that? We run `phpize` in the extension directory.
```
> /usr/bin/phpize

Configuring for:
PHP Api Version:         20121113
Zend Module Api No:      20121212
Zend Extension Api No:   220121212
```
The `phpize` process reads the configuration of the installed PHP and sets up a local build environment just for the extension. All of a sudden we have a `./configure` script, and we're ready to build (assuming you have installed the MacOSX command-line developers tools with XCode).
```
> ./configure \
    --with-php-config=/usr/bin/php-config \
    --with-pgsql=/opt/pgsql/10

> make
```
Note that I have my own build of PostgreSQL in `/opt/pgsql`. You'll need to supply the path to your own install of PgSQL so that the PHP extension can find the PgSQL libraries and headers to build against.

When the build is complete, you'll have a new `modules/` directory in the extension directory. Now figure out where your system wants extensions copied, and copy the module there.
```
> php --info | grep extension_dir

extension_dir => /usr/lib/php/extensions/no-debug-non-zts-20121212 => /usr/lib/php/extensions/no-debug-non-zts-20121212

> sudo cp modules/pgsql.so /usr/lib/php/extensions/no-debug-non-zts-20121212
```
Finally, you need to edit the `/etc/php.ini` file to enable the new module. If the file doesn't already exist, you'll have to copy in the template version and then edit that.
```
sudo cp /etc/php.ini.default /etc/php.ini
sudo vi /etc/php.ini
```
Find the line for the PgSQL module and uncomment and edit it appropriately.
```
;extension=php_pdo_sqlite.dll
extension=pgsql.so
;extension=php_pspell.dll
```
Now you can check and see if it has picked up the PgSQL module.
```
> php --info | grep PostgreSQL

PostgreSQL Support => enabled
PostgreSQL(libpq) Version => 10.0
PostgreSQL(libpq)  => PostgreSQL 10.0 on x86_64-apple-darwin15.6.0, compiled by Apple LLVM version 8.0.0 (clang-800.0.42.1), ```
That's it!