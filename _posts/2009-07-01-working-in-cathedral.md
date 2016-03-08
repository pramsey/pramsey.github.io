---
layout: post
title: Working in the Cathedral
date: '2009-07-01T08:00:00.000-07:00'
author: Paul Ramsey
tags:
- postgis
- cathedral
- regression
- 1.4.0
modified_time: '2011-10-24T09:00:43.677-07:00'
blogger_id: tag:blogger.com,1999:blog-14903426.post-7445244052071049254
blogger_orig_url: http://blog.cleverelephant.ca/2009/07/working-in-cathedral.html
comments: True
---

<img src="http://photos.igougo.com/images/p152562-Salisbury-Salisbury_Cathedral.jpg" style="float:right;padding-left:10px;padding-bottom:5px;width:174px;height:237px;" />In February, at the [Toronto Code Sprint](http://wiki.osgeo.org/wiki/Toronto_Code_Sprint_2009), the PostGIS team looked each other in the eye (for the first time) and committed to get the [1.4 release](http://svn.osgeo.org/postgis/trunk/NEWS) out by late April.

Well, it's late June now. It seems very likely that I will get to cut 1.4.0RC1 tomorrow morning.

My personal preference has always been to release early and often. In the hacker ethic, this sounds like a good thing, it's the "bazaar" model that [Eric Raymond promoted](http://catb.org/esr/writings/cathedral-bazaar/cathedral-bazaar/) over the "cathedral" model of development. In the bazaar, you dump out regular releases, and let the community dictate whether they are of quality ("don't use 2.31.2a, it's garbage!"). I still remember being told by a more knowledgeable Linux user that I could upgrade to 1.1.53 (?), but not any further than that, because the succeeding releases were unstable.  In the cathedral, you release no wine before its time, aiming for a polished diamond of a release.

So, 1.4.0 has taken much longer than expected, the confluence of a development team that is now unwilling to accept the existence of any "crasher" bugs at all (no matter how unlikely they are to be exercised) and a growing comprehensiveness in the test suite, which is now covering all the functions, in most every combination of inputs. Because of the enhanced testing, we discovered crashers we didn't know we had &ndash; and then we had to fix them.

Despite chafing to release! release! release! I have come to appreciate our new conservatism. Among my favorite feedbacks on PostGIS is the users who say "it just works, install it and forget about it, rock solid". That feels good, and to keep things that way, our new austerity is only going to help.

The maturation of PostGIS into a product you can just "install and forget" has been multi-stage. 

Prior to the 1.0 release, [Sandro Santilli](http://strk.keybit.net/) added [the first regression tests](http://trac.osgeo.org/postgis/log/trunk/regress/regress.sql). These tests have been growing ever since and have been invaluable in ensuring that old bugs don't re-enter the code base, and that new features don't break old features.

For the 1.4 release, the [documentation](http://postgis.refractions.net/documentation/manual-svn/) was upgraded substantially, by adding a great deal of extra structuring to the reference section. [Regina Obe](http://www.paragoncorporation.com/team.aspx) discovered that a side effect of the extra structure was that she could automatically generate a test for most every documented function using [XSLT](http://en.wikipedia.org/wiki/XSL_Transformations) on the docbook XML.  This new "garden test" found a number of previously undetected bugs, that have since been removed.

For the 1.4 release, I added the start of a [CUnit test suite](http://svn.osgeo.org/postgis/trunk/liblwgeom/cunit/) that exercises the PostGIS functions without requiring a database back-end. Even in it's early state, it has saved me from a couple booboos already. For future releases, this extra regression suite is going to help keep things stable.

For the 1.4 release, [Mark Cave-Ayland](http://www.ilande.co.uk/) re-worked the logging and debugging infrastructure, to make the coding cleaner and easier to maintain during debugging cycles. He also split out the underlying geometry implementations, which are now used in the loader/dumper utilities, for a more consistent approach to geometry handling.

These are all under-the-covers improvements that end-users never see. But they all contribute to that "it just works, it just runs" end-user experience that I have come to treasure even more than the sensation of slamming out a point release at 2am. I hope everyone tries out RC1 so that we can slay any remaining bugs before the 1.4.0 release!

