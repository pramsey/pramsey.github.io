---
layout: post
title: Not-so-free Client Libraries
date: '2006-12-10T15:51:00.000-08:00'
author: Paul Ramsey
tags: 
modified_time: '2006-12-10T16:24:55.229-08:00'
blogger_id: tag:blogger.com,1999:blog-14903426.post-6104994144553622178
blogger_orig_url: http://blog.cleverelephant.ca/2006/12/not-so-free-client-libraries.html
comments: True
---

While at the [FOSS4G](htthttp://beta.blogger.com/img/gl.link.gifp://www.foss4g2006.org) event this fall I had the opportunity to talk at length with Xavier Lopez, the product manager for Oracle Spatial.  

He was at the event to talk up more open source use of Oracle's products, and he asked me what Oracle could do to help open source, short of shovelling money at it.

"Make your client libraries freely redistributable." I answered, citing the pains that [Geotools](http://www.geotools.org) (and by extension [Geoserver](http://geoserver.sourceforge.net) and [uDig](http://udig.refractions.net)) have to go to in supporting Oracle servers while not distributing the actual Oracle JDBC JAR files.  Because we can't include Oracle libraries with our builds, end users have to independently download the JARs and copy them into the right places themselves -- it is not a user-friendly situation at all.

"But", Xaviar replied, "they **are** redistributable."

This did not match my understanding of the situation, but he *is* the expert. So I said I would look into it and get back to him.

The source of our mutual misunderstanding turned out to be (surprise!) based on legaleze.  As Xaviar said, the client JDBC JARs **are** freely redistributable... but there is a catch.  You can only get the JARs in the first place by accepting a license, and the [license](http://www.oracle.com/technology/software/htdocs/distlic.html?url=http://www.oracle.com/technology/software/tech/java/sqlj_jdbc/htdocs/jdbc_10201.html) says that you are allowed to redistribute them only if you do so under the same terms as those given in the original Oracle license.

Among the restrictions which any open source project would have to place on its users if they wanted to redistribute the Oracle client libraries are:

> * You are not a citizen, national, or resident of, and are not under control of, the government of Cuba, Iran, Sudan, Libya, North Korea, Syria, nor any country to which the United States has prohibited export.
> * You will not download or otherwise export or re-export the Programs, directly or indirectly, to the above mentioned countries nor to citizens, nationals or residents of those countries.
> * You are not listed on the United States Department of Treasury lists of Specially Designated Nationals, Specially Designated Terrorists, and Specially Designated Narcotic Traffickers, nor are you listed on the United States Department of Commerce Table of Denial Orders.
> * You will not download or otherwise export or re-export the Programs, directly or indirectly, to persons on the above mentioned lists.

To abide by the  license, not only would we have to to (somehow) ensure that none of the people downloading our builds met the conditions above, but we would also have to get them to promise in turn not to distribute to such people. Forcing the users to copy the JARs by hand starts to look a whole lot better all of a sudden.

(Stop. Take a moment to contemplate the lush absurdity of the idea that placing a piece of software behind such a click-through license materially assists the enforcement of export controls in any way. Breath in. Breath out. Ahhhh.)

Open source cannot place restrictions on use or redistribution.  It is the ethos.  It is the way things work.  It is not because the restrictions in this case are oddball notions from the national security state.  Any such restrictions are anathema.  My favourite case of this was a piece of Geotools, which had to be re-written when it turned out that a component was licensed under a "public domain except for military use" clause.  Everyone gets to download, use and redistribute open source.  The US Department of Defense, Cuba, Peace Now, the Marine Corps, the lunatic down the street, even me.