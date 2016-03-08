---
layout: post
title: Why SDIs Fail
date: '2006-09-27T15:28:00.000-07:00'
author: Paul Ramsey
tags: 
modified_time: '2006-10-21T11:22:58.118-07:00'
blogger_id: tag:blogger.com,1999:blog-14903426.post-115939687031638737
blogger_orig_url: http://blog.cleverelephant.ca/2006/09/why-sdis-fail.html
comments: True
---

My colleague [Jody Garnett](http://weblogs.java.net/blog/jive/) recently got to participate in a workshop on Spatial Data Infratructures (SDIs) at the United Nations, and he brought back a nice overview document written by a consultant to the UN.  It lays out all the various national and sub-national SDI initiatives, and their strategies, and it all seems like very reasonable stuff.

Except that none of them are succeeding.  

Some of them have been at it for over 10 years (like the [NSDI](http://www.fgdc.gov/nsdi/nsdi.html) work in the United States).  Some of them have even been backed by some reasonable funding (like the [CGDI](http://www.geoconnections.org) in Canada).  None of them really have public penetration.  Not on the level of [Google](http://maps.google.com) or [Yahoo](http://maps.yahoo.com) or [Mapquest](http://www.mapquest.com) or [MS Virtual Earth](http://live.local.com).

Is this success?  It doesn't feel like it.  Even within the cognoscenti of GIS professionals the SDI initiatives have less intellectual traction than the consumer portals.

So perhaps this is failure.  Why?

### The Missing Incentive

SDIs make the virtuous and correct assertion that if everyone shared their data, nearest to the point of creation, using various technical tricks and standards, then distribution and integration cost for everyone would go down. We would all be winners.

It is a classic case of global accounting.  Sum up everyone's bottom line, and behold: in aggregate everyone is better off!  

But not everyone is equally better off.

The operational folks, the guys actually building parcel fabrics and tenuring layers and physical infrastructure databases, are not doing it for fun, and they aren't doing it to share.  They are doing it to meet particular operational goals that are specific to themselves and themselves only.  

Publishing their data to the rest of the world is a pure cost center for them.  It is a small cost center, publishing the data is not hard, but it is still a cost. Publishing provides them no substantial business benefit.  It provides **other people** with a huge benefit, hence the positive global bottom line, but for the **most important people to the process**, the data creators, it is just a pain in the ass.

I call this problem the "operational/analytical divide", because it happens everywhere, from accounting registers to airline reservation systems.  The needs of the people operationally working with the data do not align with the needs of the people driving up analysis to decision makers.  Hence a million data marts bloom, and various other strategies to give the analysts the data they need without impeding the operational folks.

Note that the folks pushing SDI are almost exclusively coming from the analytical, decision support side of the equation.  This is a recipe for frustration, particularly when trying to build something as loosely coupled as an SDI.  So most SDI implementations still lack access to some of the most informative, up-to-date information, the operational information maintained and updated regularly by land managers.

This is not a recipe for relevance.

### It Gets Worse

Often the local solution to the problem of operational disinterest is for the analytical side to take on the whole cost of integration and provide a single analytical environment for their jurisdiction.

Aha! Solution! These enlightened analysts will then take their integrated data and publish **it** out to the SDI and thus the world.  Except the analysts suffer the same disease as the operational folks, just with larger borders.

In British Columbia, the analytical response to data integration problems was to build, over several years, a [data warehouse](http://lrdw.ca) which holds all the operational and inventory data, updated in real time.  Cool stuff, and quite useful to them! But is this data available to the national SDI?  Only a handful of layers.

Why? For the British Columbia analytical folks, providing data to the national SDI has little or no return-on-investment. So while they will acknowledge that it is a nice idea (it **is** a nice idea!), they will also acknowledge that it is not a high priority.  What's in it for them?

### Users? What users?

On the technical side, even where data is available, the user experience has not been well served.  The implementation of SDI technology thus far still seems "proof of concept", getting as far as "does this idea work?", but not as far as "can we make this work well?"

So, even where large quantities of data are published online (in the case of, for example the [GeoBase LandSat](http://www.geobase.ca/geobase/en/data/ldsat7.html) data made available by the Canadian CGDI effort), the access is sufficiently slow to deter all but the most avid users.  Specifications for response time (where they exist, and they often do not) are absurdly slow (perhaps they were written in the mid-1990s).  Less than 5 seconds to return a map might be OK if I only want one map, but any interactive application will require me to request numerous maps in the course of exploring the data, and those 5 seconds really pile up.

Why was Google Maps a sensation, while Mapquest remained a yawn?  Google optimized the part of the process most annoying to users, the interactive exploration part.  Why did Google do this and not SDIs?  One can only assume it was because building the system is the goal of SDI efforts (and not to be diminished, the system is very hard!) not thinking about the end user.

But (I can hear them yelling) the consumer space is not what SDIs are about! Then who are they about, because I cannot think of a market segment well served by SDI efforts to date.  Not GIS professionals, they cannot abide the forest of web-mapping obstacles that have been erected in front of various data bases over the years.  Not general public consumers, as noted above.  Not decision makers, they can't use the tools provided, and the professionals who serve them are still doing the same song-and-dance-and-secret-handshake number they were doing 10 years ago to achieve data access.

Attending a talk this year about the emergency response in British Columbia to bird flu, I was struck that despite all the state-of-the-art technology being used (ArcMap, SDE, LANs and wireless) the fundamental business architecture (madly collect big pile of data, madly print maps) is no different than if the talk were given 10 years ago.  No SDI in sight, despite the near-constant pitch of SDI as a cure-all for integration in critical response settings.

### Oh, And the Unpleasant Matter of the Bill

Of course, no discussion of the impotence of SDI efforts could fail to acknowledge the pivotal role of data cost recovery policies in blunting the sharing of information between organizations and levels of government.

The most valuable information for sharing and decision making is the most volatile, because direct close-to-source access assures timeliness and accuracy.  But volatile data is also perceived (correctly) as having the most intrinsic value.  And so the creators hold it close, and only share it in traditional ways (file shipping, protected download) using traditional business models (pay to play).

### Did I Mention Metadata?

And you thought you could get out without being subjected to yet another discussion of metadata.

Metadata is the core of the SDI vision, since a distributed system of resoures requires a searchable registry of available resources in order to direct people to the information they need.

But, like basic sharing itself, metadata creation suffers from missing incentives, because metadata is all about **other** people (not important people, like **me**).  I don't need to write metadata about my data, **I already know all about my data!**.  There are no awards for good meta-data writing, except karmic ones, and karma doesn't pay the bills.  

This may sound overly harsh, but a quick review of the contents of the public capabilities files of [web services currently online](http://www.google.ca/search?hl=en&q=inurl%3Arequest%3Dgetcapabilities) should dispell most people's notions of metadata quality.

### Loosely Coupled Things Are Easy To Break

One of the ironies of the SDI-for-crisis-response sales pitch is that it holds up the classic centralized solution as having a "single point of failure" (boo! shame!).  Unspoken is the fact that the SDI solution has N points of failure, where N is the number of nodes.

Our company had the fortune to have the opportunity to build a [client portal](http://aardvark.gov.bc.ca/apps/coin/) that used SDI resources to provide an integrated viewing and data searching capability.  It was "SDI come to life", and a great learning experience.  Though our code worked fine, our delivery was a nightmare.

* The map application was too slow.  Well, that wasn't our code's fault, one of the servers we referenced for base mapping was really slow. Eventually we found a faster one.
* The search service(s) returned really terse results.  Well, that was what the metadata server returned, we had no control over that.  (Actually we did, we could obtain more verbose results but then the search took several minutes to return. Pick your poison.)
* The search service was really slow.  Again, ask a slow server a question, get a slow answer.
* And finally the *coup de gr&#226;ce*.  After delivery, the application kept breaking.  Or rather, the services it depended on kept breaking.  Or changing their API just a little.  But since we were the client-facing part of the whole system, it was us who got the service calls.

Reliability is not something any part of the SDI infrastructure takes overall responsibility for, so any component can drag down any of the others.  In the end, it all gets delegated to the last link in the loosely coupled chain, the client software.  But the architecture is supposed to make getting data easy, and instead it makes it really hard, because the client has to keep track of all the servers and their reliability.  

Some SDI server providers make an effort to provide really high uptimes and great performance, but it only takes **one** crappy server to make the user experience terrible.  So the whole system reliability problem gets delegated to the client.  That makes for a lot of work on systems which are supposed to be relatively lightweight.

### We're Doomed! Doomed!

So, to sum up:

* Data creators have no incentive to join SDIs;
* Data analyzers have incentive, but once they have all the data **they** need, they're done;
* The user experience is pretty uniformly worse than what commercial outfits  provide;
* Data pricing policies are locking up much of the "good" data, even if people were interested in sharing;
* Even the people who **are** sharing aren't doing a very good job of it, since their metadata is garbage; and,
* When put into operation, the whole system is unbelievably brittle, leading to yet more bad user experiences.

Is there no good news at all?  Sure, and tomorrow I will write about that.