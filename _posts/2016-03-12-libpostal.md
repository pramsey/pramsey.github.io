---
layout: post
title: 'libpostal for PostgreSQL'
date: '2016-03-12T03:00:00-08:00'
modified_time: '2016-03-12T03:00:00-08:00'
author: Paul Ramsey
category: technology
tags:
- postgis
- pgsql
- geocoding
- libpostal
comments: True
image: "2016/newman.jpg"
---

Dealing with addresses is a common problem in information systems: people live and work in buildings which are addressed using "standard" postal systems. The trouble is, the postal address systems and the way people use them aren't really all that standard.

<img src="{{ site.images }}{{ page.image }}" alt="{{ page.title }}" width="500" height="276" />

Postal addressing systems are just standard enough that your average programmer can whip up a script to handle 80% of the cases correctly. Or a good programmer can handle 90%. Which just leaves **all the rest of the cases**. And also all the cases from countries where the programmer doesn't live.

The classic resource on postal addressing is called [Falsehoods programmers believe about addresses](https://www.mjt.me.uk/posts/falsehoods-programmers-believe-about-addresses/) and includes such gems as:

> **An address will start with, or at least include, a building number.**
> 
> Counterexample: Royal Opera House, Covent Garden, London, WC2E 9DD, United Kingdom.
> 
> **No buildings are numbered zero**
> 
> Counterexample: 0 Egmont Road, Middlesbrough, TS4 2HT
> 
> **A street name won't include a number**
> 
> Counterexample: 8 Seven Gardens Burgh, WOODBRIDGE, IP13 6SU (pointed out by Raphael Mankin)

Most solutions to address parsing and normalization have used rules, hand-coded by programmers. These solutions can take years to write, as special cases are handled as they are uncovered, and are generally restricted in the language/country domains they cover. 

There's now an open source, empirical approach to address parsing and normalization: [libpostal](https://github.com/openvenues/libpostal). 

Libpostal is [built using machine learning techniques](https://medium.com/@albarrentine/statistical-nlp-on-openstreetmap-b9d573e6cc86) on top of [Open Street Map](http://openstreetmap.org) input data to produce parsed and normalized addresses from arbitrary input strings. It has binding for lots of languages: Perl, PHP, Python, Ruby and more.

And now, it also has a binding for PostgreSQL: [pgsql-postal](https://github.com/pramsey/pgsql-postal).

You can do the same things with the PostgreSQL binding as you can with the other languages: convert raw strings into normalized or parsed addresses. The normalization function returns an array of possible normalized forms:

{% highlight sql %}
SELECT unnest(
  postal_normalize('412 first ave, victoria, bc')
  );
{% endhighlight %}

                      unnest                  
    ------------------------------------------
     412 1st avenue victoria british columbia
     412 1st avenue victoria bc
    (2 rows)

The parsing function returns a `jsonb` object holding the various parse components:

{% highlight sql %}
SELECT postal_parse('412 first ave, victoria, bc');
{% endhighlight %}

             postal_parse                                   
    ----------------------------------
     {"city": "victoria", 
      "road": "first ave", 
      "state": "bc", 
      "house_number": "412"}
    (1 row)

The core library is very fast once it has been initialized, and the binding has been shown to be acceptably fast, despite some unfortunate implementation tradeoffs.

<blockquote class="twitter-tweet" data-lang="en"><p lang="en" dir="ltr"><a href="https://twitter.com/pwramsey">@pwramsey</a> parsed and normalized 1.2 million rows in five minutes. *does happy dance*</p>&mdash; Darrell Fuhriman (@nixzusehen) <a href="https://twitter.com/nixzusehen/status/708726623445475328">March 12, 2016</a></blockquote> <script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>

Thanks to Darrell Fuhriman for [motivating this work](https://twitter.com/nixzusehen/status/708360171546746882)!

