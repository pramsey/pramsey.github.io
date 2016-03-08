---
layout: post
title: Proprietary software is not the future you think it is...
date: '2011-08-12T14:03:00.000-07:00'
author: Paul Ramsey
tags:
- common sense
- proprietary software
- industry
modified_time: '2013-05-01T09:48:57.566-07:00'
blogger_id: tag:blogger.com,1999:blog-14903426.post-4749333090783635772
blogger_orig_url: http://blog.cleverelephant.ca/2011/08/proprietary-software-is-not-future-you.html
comments: True
---

OK, so this morning James Fee tweeted [this nugget](http://web.archive.org/web/20120225002937/http://stratus.pbbiblogs.com/2011/08/12/open-source-is-not-the-future-you-think-it-is%E2%80%A6/) of late 90's "open minded thinking about open source" from a proprietary vendor. 

And if you think I can leave that alone... you just don't know me that well! 

I'd go through and work on the arguments point-by-point, but there's hardly any argument there. It's almost all innuendo and unsupported assertion. So I just re-wrote it from the opposite point of view largely using search-and-replace. It holds up pretty well, because there's no content, just bluster. My favourite part is the paragraph on PostGIS, which I left unchanged, since it's actually a pretty powerful argument against proprietary software (your pro-proprietary argument is that Oracle is going to kick your ass if you use open source? awesome!)  

Enjoy. 

------------------------------------------------------------------------

**Proprietary software is not the future you think it is...**

Read those words carefully. Read what they are, and understand what they are not. It could mean “open source zealot dismisses proprietary software”. It doesn’t. What it means is that while many preach the virtues of proprietary software, meaning supported, reliable, and guaranteed uptime with no technical expertise required – I do not subscribe. Closed platforms, be it maps or software, are fantastic and I believe a part of the IT industry as far as we can see into the future. OpenGeo, for example, uses proprietary software in its own products so the likes of the OpenGeo Suite connect easily to an ESRI ArcSDE server. But let me give you a couple of examples where I am coming from. 

I saw a presentation a couple of years ago from a older gentleman – about my age  – who had a 30 minute slot at a conference. For 25 minutes he exalted the virtues of his product, and how he can take this piece of  software, and solve all kinds of business problems with just the touch of a button and you – yes you – can touch that button too. But he was also pushing his wares, and spent the final five minutes telling you how his product would be even more useful if you also bought all this other products. So the end result in that case was: this tool is great, but to be actually useful you have to buy all the other stuff. Come again? You mean its good, but I can only unlock the value by standardizing on your whole platform? But you just spent 25 minutes telling me how great this new stuff is and now I’m still being asked to open my wallet even more? Heckling ensued from the peanut gallery. 

Let’s take another scenario. You have decided to invest in an standard vendor solution. To put this all together you decide to employ one or two low-end hacks from a technical training farm. Over the following 12 months these guys struggle (because they aren't very bright) but in the end you have something that works, and only requires a nightly reboot. 

But a year or two down the line, your management decides they need the system to support ten times as many users, and provide 99.9% up-time. Maybe you don't have the budget to license that many cores. Now you've got to re-architect and re-write the system to scale and not require reboots anymore. And there's a problem. Your low-end hacks can't figure out how to do anything that's not in the "introduction" section of the manual or can't be done with the GUI. Given the choice between learning how to script a solution and spending 5 hours clicking the same buttons over and over, they choose the latter. Any why not? They are on salary, after all.  You can see where this is going. 

The point of course, is that proprietary software is not 100% reliable or scalable with zero effort. And proprietary software may not even be the best engineered solution. I am not asking you to ignore proprietary software and only use open source, because that in some ways puts you back to square one. Proprietary software has credible value to both system integrators providing sustainable solutions and individual organizations implementing systems.  

Take Oracle as an example. It has been the industry standard for years, and is in many instances a credible alternative to the likes of PostgreSQL. But are you going to pay more or less for that Oracle DBA over the PostgreSQL DBA? Assuming it’s the same, or perhaps a little more for a specialist, then we’re into pure software licensing. I can guarantee Oracle aren’t about to roll over because of pricing. If a company has a site agreement with Oracle are you free to pick up another database? Even if it is free – or free to download? As some people say “spatial is special” we are increasingly seeing that IT departments disagree. Spatial is increasingly not viewed as special and won’t be treated as such. 

I’ve already seen firsthand, organizations that have tried and given up on building a sustainable product to sell based entirely on proprietary software, and organizations do a complete U-turn on what they were told were "off-the-shelf" systems because of spiralling costs and concerns over maintenance. It’s not to say you shouldn’t take that path, but it is to say, it’s not easy, and in the long run it might not even be possible. The crux behind all of this is money. If we all had loads it wouldn’t matter so much. We’d buy whatever system we wanted, and lots of consultants to wire the black boxes together. But now more than ever we don’t have money. If an offer seems too good to be true, then it probably is. Proprietary software will continue to evolve and grow and I’ve no doubt more and more individuals and organizations will participate. Some organizations will use proprietary software for the press releases and "president's leadership" awards, others for the free lunches with sales reps. I still believe we are looking for products which give us the best of both worlds. Extensibility where we are comfortable, but somehow reducing the risk and ongoing support to minimal predictable cost. 

A couple of weeks ago I said a more informed decision is likely to be a better one. Next time someone tells you proprietary software is cheaper overall and more reliable, have a little think about it. Use what is right, not what someone else says might be cheap. 

Paul R 

PS – This blog is using blogger – we use it because it’s a great tool for the job, not just because it’s closed and proprietary!