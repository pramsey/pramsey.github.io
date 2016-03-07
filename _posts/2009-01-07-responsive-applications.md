---
layout: post
title: '"Responsive" Applications'
date: '2009-01-07T10:42:00.000-08:00'
author: Paul Ramsey
tags: 
modified_time: '2009-01-07T10:59:48.388-08:00'
thumbnail: http://farm4.static.flickr.com/3389/3176884653_4ae0a3f37f_t.jpg
blogger_id: tag:blogger.com,1999:blog-14903426.post-5786030861456365251
blogger_orig_url: http://blog.cleverelephant.ca/2009/01/responsive-applications.html
---

One of the first development projects I'm doing with [OpenGeo](http://www.opengeo.org) is putting together a GUI for data loading/dumping in PostGIS.  The command-line tools have served the project well for a long time, but with such good GUI tools like [PgAdmin](http://www.pgadmin.org) available for all the other interaction with the database, it is a shame to have to head to the command-line to load a shape-file.<div style="float:right;margin:10px;text-align:center;">[<img src="http://farm4.static.flickr.com/3389/3176884653_4ae0a3f37f_m.jpg" width="239" height="240" alt="PostGIS Loader GUI" />](http://www.flickr.com/photos/92995391@N00/3176884653/" title="PostGIS Loader GUI by pwramsey3, on Flickr)<br/><small>Shape File Loader GUI</small></div>

I've had a grand time learning [GTK+](http://library.gnome.org/devel/gtk/stable/index.html) to build the GUI window, got it all laid out, and then spent some time re-working the output portions of the existing loader code so I could write into a database handle rather than to [STDOUT](http://en.wikipedia.org/wiki/Standard_streams).

I got everything hooked up, ran small small test cases (victory!) then got a big file, and hit the "Import" button and ... everything froze for 20 seconds, then *whoooosh* all the logging information updated. What gives? Oh, right, I took control away from the GUI thread for 20 seconds while I was loading the data, then handed it back.

[Mono](http://www.mono-project.com/) uses GTK for their Linux widgets, and they have some good advice on how to build [responsive applications](http://www.mono-project.com/Responsive_Applications) &ndash; applications that stay usable and informative, even while doing computationally demanding tasks.

I thought I already knew the answer &ndash; I was going to have to put my loading process into its own thread and figure out all the joys of thread programming. I still may do that, but in the meantime I've implemented one of the other options the Mono project suggested. There is an "idle" event in GTK, which is thrown whenever the application has "time on its hands". By breaking a large process into small chunks, and executing them during idle moments, the application remains responsive, and the work still gets done.

Is the application now "responsive"? I would argue, not really, it just **seems** responsive. But in this modern world, the appearance of a thing is usually just as good as the thing itself.

The code now looks a bit uglier though... instead of simply running the translation, the GUI moves through little stages: create the tables, load the first 100 features, the second, etc, finish the process.  However, it's now possible to stop an import mid-stream, and the logging information hits the window in real time.

