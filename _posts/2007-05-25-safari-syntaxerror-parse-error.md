---
layout: post
title: 'Safari: SyntaxError - Parse error'
date: '2007-05-25T09:05:00.000-07:00'
author: Paul Ramsey
tags: 
modified_time: '2007-05-25T09:12:09.913-07:00'
blogger_id: tag:blogger.com,1999:blog-14903426.post-6412160392837517993
blogger_orig_url: http://blog.cleverelephant.ca/2007/05/safari-syntaxerror-parse-error.html
comments: True
---

I have now worked my way past this particularly opaque Safari error message twice, which is one time too many, so I am putting the explanation for *my* error case online.  Safari seems to have a few cases where it throws up this utterly useless error message.  It *does* include a line number reference, and double-clicking the error line in the log will take you to the offending line, but heaven help you if it is not clear what is wrong at that point.

I found [another reference](http://meyerweb.com/eric/thoughts/2005/07/11/safari-syntaxerror/) to this problem on the web, but it wasn't the problem *I* had.

**My problem was that I used "abstract" as a variable name.**  Because I am working on web pages for viewing presentation abstracts, this seemed natural, however I guess "abstract" is a reserved word of some kind in Safari's Javascript implementation.  Firefox showed no errors and happily ran code that Safari could not even parse.