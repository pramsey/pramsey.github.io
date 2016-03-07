---
layout: post
title: Removing Complexities
date: '2010-11-22T15:14:00.001-08:00'
author: Paul Ramsey
tags:
- postgis
- buffer
- jts
modified_time: '2010-11-22T15:24:31.240-08:00'
thumbnail: http://farm6.static.flickr.com/5207/5199928430_eee923c599_t.jpg
blogger_id: tag:blogger.com,1999:blog-14903426.post-8821408962584031694
blogger_orig_url: http://blog.cleverelephant.ca/2010/11/removing-complexities.html
---

My co-worker Alyssa Wright just asked me an interesting question: Vancouver Island is a pretty crinkley island, how would we simplify it to remove the crinkley bits?

[<img src="http://farm6.static.flickr.com/5207/5199928430_eee923c599_m.jpg" width="240" height="183" alt="Original Island" />](http://www.flickr.com/photos/92995391@N00/5199928430/" title="Original Island by pwramsey3, on Flickr)

Notice the big fjords and other fine work by [Slartibartfast](http://en.wikipedia.org/wiki/Slartibartfast). [ST_Simplify](http://postgis.net/documentation/manual-svn/ST_Simplify.html) will not do what we need, since it removes *redundant* vertices within a tolerance. So the fjords will have fewer vertices, but they'll still be there.

However, it turns out there is a solution, and I didn't even need a long walk in the snow to figure it out. If we buffer by a large amount, then reverse the buffer by the same amount, we'll get something that has a similar shape to the original, but without the crinkly bits.

[<img src="http://farm6.static.flickr.com/5208/5199334325_34346f3c4c_m.jpg" width="240" height="185" alt="Buffered by 4km" />](http://www.flickr.com/photos/92995391@N00/5199334325/" title="Buffered by 4km by pwramsey3, on Flickr)

Buffer out, and the crinkley bits get melted away. But now the island is too big. So buffer inwards.

[<img src="http://farm5.static.flickr.com/4088/5199334381_814ba89170_m.jpg" width="240" height="184" alt="Negative Buffer by 4km" />](http://www.flickr.com/photos/92995391@N00/5199334381/" title="Negative Buffer by 4km by pwramsey3, on Flickr)

And now we have something we can use. We could now even run ST_Simplify on this result to drop some unneeded vertices and make it smaller yet.

[<img src="http://farm6.static.flickr.com/5002/5199928610_6883ab9265_m.jpg" width="240" height="186" alt="Simple Island" />](http://www.flickr.com/photos/92995391@N00/5199928610/" title="Simple Island by pwramsey3, on Flickr)

Looking closer, you can see how we have melted away all the crinkley bits while still following the original (mostly). Note that the new shape is still a strict superset of the original.

[<img src="http://farm6.static.flickr.com/5083/5199951910_619d381539_m.jpg" width="240" height="212" alt="Saanich Peninsula" />](http://www.flickr.com/photos/92995391@N00/5199951910/" title="Saanich Peninsula by pwramsey3, on Flickr)