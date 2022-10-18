---
layout: post
title: 'What you Need to Know'
date: '2022-10-17T00:00:00-08:00'
author: Paul Ramsey
category: technology
tags:
- hacking
- cloud
- technology
comments: True
image: "2022/layers1.jpg"
---

[Matt Asay](https://mobile.twitter.com/mjasay)'s piece today about the skills shortage in cloud got me to thinking about what constitutes the required knowledge to work on various projects, and how much implicit knowledge is bound up with any given "single" technology.

<blockquote class="twitter-tweet"><p lang="en" dir="ltr">The cloud has a people problem (tl;dr? There&#39;s a skills shortage, per <a href="https://twitter.com/cloudpundit?ref_src=twsrc%5Etfw">@cloudpundit</a>, and multicloud, increasingly a reality, compounds the problem) <a href="https://t.co/7fwFEYRC3K">https://t.co/7fwFEYRC3K</a> by <a href="https://twitter.com/mjasay?ref_src=twsrc%5Etfw">@mjasay</a> for <a href="https://twitter.com/InfoWorld?ref_src=twsrc%5Etfw">@InfoWorld</a></p>&mdash; Matt Asay (@mjasay) <a href="https://twitter.com/mjasay/status/1582027626247385089?ref_src=twsrc%5Etfw">October 17, 2022</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script> 

Like, what should you know to "do cloud"? 

## Doing Cloud

Well, "containers" I guess would be a core building block, but what does that imply? Some knowledge of Linux **system administration**, so you can understand things like the shell and environment. Lots of **network administration** as well, to understand routing rules and name resolution. Perhaps some **package management** so you can install some dependencies and build out others. Really, sounds like you need to understand all the things a late 90's era sysop did. And we haven't even started in on the actual **cloud** part yet!

![]({{ site.images }}/2022/layers2.jpg)

For that you need to understand the abstraction over the actual machines that the **container management** environment (pick one, pick ten) provides, the **configuration** system for that environment (declarative? programmatic?), and whatever **security/authentication/roles** system your cloud uses. Multiply by **N** for "multi-cloud".

And that's just for the container part! Want to get into objects stores (S3/R2) and production deployments? Add in a pretty solid understanding of **HTTP**, **CDN** options, **DNS** and **TLS**.

Do you have to manage queues? Databases? ML? Each cloud has its own subtly different and variegated offering, and each area has its own unique set of skills you need to master, whether it be **DBA concepts** or **domain languages** or **security needs**. 

I can rattle off all these things because I have learned them all to some extent or other over the course of my career, and that's great but I'm **51 years old**. I am constantly amazed that any new graduate can find enough initial purchase to start a career in technology.

## Doing PostGIS

Like, want to get involved in **PostGIS**? Easy, "**it's in C**"! Except, well actually we've got some **C++** bits, but frankly if you know C you probably know C++ too. C and C++ both embed a macro language (**CPP**) so you need to know that to understand the code.

But wait, you want to build it? Well the build system is **autotools**. That's an unholy mixture of **M4** and **bash shell** scripting. Fortunately you can mostly ignore the M4 but bash skills are definitely required.

Naturally you'll also have to understand **Makefile** syntax.

![]({{ site.images }}/2022/layers3.jpg)

Of course PostGIS is a **PostgreSQL** extension, so to even understand what we're doing you need to understand **SQL**. You'll end up learning the PostgreSQL extension and function APIs by osmosis via the PostGIS code base, but it's still another thing.

Inevitably you will make a mistake, so you'll need to understand a **debugger**, probably gdb or lldb, which are glorious command-line tools with their own terse commandline syntax.

Ooops! Forgot the **UNIX commandline**! That's table stakes, really, but there you go. 

Also forgot **git**, which is one of the few tools that is common across most branches of practical modern IT.

The documentation is all in **DocBook XML**, but you can probably figure that out by inspection.

You probably won't change the WKT lexer/parser, but that's in **flex/bison**. There's also a **protobuf** binding that has its own little domain language.

## Fixes? Nah.

One of the reasons I don't do "real javascript" is because doing this exercise with any modern Javascript project involves a **similar-but-much-longer** litany of completely different tooling from the tooling I already know.

I learned Go relatively recently, and I have to say that even though I did have to, yes, learn all about build and test and debug and modularity for Go, at least there wasn't a huge pile of options to wade through -- the Go community mostly "picked one" for the core tools. (Not true for database connectivity though! You can choose from among multiple PostgreSQL client libraries!) 
{: .note }

![]({{ site.images }}/2022/layers1.jpg)

I don't know how to end this except to say it feels like my whole career has been spent watching geological layers of technology pack down on each other, layer upon layer upon layer, and that the result seems, in aggregate, completely unapproachable. 

I wait for some kind of **simplifying moment**. 

![]({{ site.images }}/2022/layers4.jpg)

The repeated theme year after year after year has been that "encapsulation" and "abstraction" will at least allow us to ignore the lowest layers. To some extent that is true -- I have made it through a whole career without having to learn assembler, and I probably will never need to. 

But so many of the other promises have failed to play out. 

**Object orientation** did not result in a new world of stringing together opaque components. The insides still matter intensely and people still have to understand the parts.

**Containers** have flattened out the need to worry about dependency chains, but the chains are still there inside the containers, and managing the production deployment of containers is now a career defining field in its own right.

## An Expanding Universe

It's possible that most of this apparent exponential complexity explosion is just due to the ever widening scope of what "working with computers" means.

The number of things you can do with computers is just orders of magnitude larger than when I started working with them. So the number of tools is similarly orders of magnitude larger. Dog bites man.

However, I have had the privilege of seeing most of the layers laid down, so I didn't have to learn them all at once to become productive. Each piece came along in its time, and added a little to the stack. 

So, I stand amazed at newly minted technologists who can start, and get productive, in this intellectual garbage tip we call a "profession". We couldn't have built a less enjoyable or consistent collection of tools if we had tried, and yet you persevere and exceed all of us. Hats off to all of you!

![]({{ site.images }}/2022/layers5.jpg)

