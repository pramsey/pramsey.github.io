---
layout: post
title: Transparent PNG for IE6
date: '2008-01-29T16:31:00.001-08:00'
author: Paul Ramsey
tags: 
modified_time: '2008-01-29T16:38:20.524-08:00'
blogger_id: tag:blogger.com,1999:blog-14903426.post-322718598586170988
blogger_orig_url: http://blog.cleverelephant.ca/2008/01/transparent-png-for-ie6.html
comments: True
---

I've been wrapping our web content in some new web designs, and one of the issues I have encountered is supporting transparent PNG on IE6.  It can be done, and all it requires is a [relatively unobtrusive hack](http://www.twinhelix.com/css/iepngfix/) that uses the IE-only "behavior" CSS attribute.

Stangely, though, while our web developer could serve pages that worked with this trick, when I implemented them on our own servers, it didn't work!  It took a while to realize that the problem wasn't how I was *implementing* the hack ("check the URLs", "are you line stripping the files?", "make sure the files aren't missing") but rather from *where I was serving* the hack.  Namely, from an old server running Apache.

IE6 would not execute the hack, which was bundled in an IE-only "behavior" file, with a <code>.htc</code> extension.  It would load it, I could see that in the logs, but it never *did* anything.  The problem was that my old Apache wasn't serving up the <code>.htc</code> file with the mime-type that IE wanted on it.

So, one quick entry in <code>/etc/mime.types</code> and an Apache restart later:

<blockquote><code>text/x-component htc</code></blockquote>

And we're golden.