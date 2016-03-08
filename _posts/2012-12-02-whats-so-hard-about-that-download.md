---
layout: post
title: What's so hard about that download?
date: '2012-12-02T12:11:00.001-08:00'
author: Paul Ramsey
tags:
- open data
- ftp
- bc
- data warehouse
modified_time: '2012-12-02T17:02:50.871-08:00'
thumbnail: http://3.bp.blogspot.com/-Cc6Ypt44BoY/ULuwt3iuqrI/AAAAAAAAAF0/ah_M4BR-NBU/s72-c/screenshot_01.png
blogger_id: tag:blogger.com,1999:blog-14903426.post-3695649142587843748
blogger_orig_url: http://blog.cleverelephant.ca/2012/12/whats-so-hard-about-that-download.html
comments: True
---

Twitter is a real accountability tool. This post is penance for moaning about things in public.

Soooo.... last Friday, while cooling my heels in Denver on the way home, I took another stab at Chad Dickerson's [electoral district clipping problem](http://blogs.vancouversun.com/2012/11/29/crowdsourcing-a-better-b-c-election-map/), and came up with this version.

<img src="http://postmediavancouversun.files.wordpress.com/2012/11/ramsey-second-edit.png" width="520" />

I ended up taking the old 1:50K "3rd order watershed" layer, using `ST_Union` to generate maximal provincial outline, using `ST_Dump` and `ST_ExteriorRing` to get out just the land boundaries (no lakes or wide rivers), used [ST_Buffer to and ST_Simplify to get a reduced-yet-still-attractive version](http://blog.opengeo.org/2010/11/22/removing-complexities/), differenced this land polygon from an outline polygon to get an "ocean" polygon, then ([as I did previously](http://blog.opengeo.org/2012/11/16/simple-sql-gis/)) differenced that ocean from the electoral districts to get the clipped results. Phew.
{: .note }

And then I complained on the Twitter about the webstacle that now exists for anyone like me who wants to access those old 1:50K GIS files.

<img border="0" height="97" width="305" src="http://3.bp.blogspot.com/-Cc6Ypt44BoY/ULuwt3iuqrI/AAAAAAAAAF0/ah_M4BR-NBU/s320/screenshot_01.png" />

<img border="0" height="92" width="304" src="http://1.bp.blogspot.com/-me3RMkGiyJ8/ULuxEjRF5nI/AAAAAAAAAGA/SfXz9d_5lT4/s320/screenshot_02.png" />

<img border="0" height="86" width="293" src="http://2.bp.blogspot.com/-qJz_ds6S5Fk/ULuxIes7LlI/AAAAAAAAAGM/hCCLIptyrT4/s320/screenshot_3.png" />

And the OpenData folks in BC, to their credit, wonder what I'm on about.

<img border="0" height="82" width="299" src="http://4.bp.blogspot.com/-MBSki7RPt9M/ULuxTvM0CeI/AAAAAAAAAGY/kNYCJ75PDLY/s320/screenshot_04.png" />

<img border="0" height="90" width="295" src="http://3.bp.blogspot.com/-AIAQXMh96p0/ULuxUHdZD_I/AAAAAAAAAGk/UfxPqDPOxD0/s320/screenshot_05.png" />

So, first of all, caveats: 

* The obstacles to access to this data were constructed years before open data existed as an explicit government initiative in BC. This is not a problem with the work the open data folks have done.
* It could certainly be a whole lot **harder** to access, it is still theoretically available for download, I don't need to file an FOI or go to court or anything like that to get this data.

This is a story of contrasts and "progress".

Back when I actually downloaded these GIS files, in the early 2000s, I was able to access the whole dataset like this (the fact that I can still type out the process from memory should be indicative of how useful I found the old regime):

    ftp ftp.env.gov.bc.ca
    cd /dist/arcwhse/watersheds/
    cd wsd3
    mget *.gz

Here's how it works now.  

I don't know where this data is anymore, so I go to [data.gov.bc.ca](http://data.gov.bc.ca). This is an improvement, I don't have to (a) troll through Ministry sites first trying to figure out which one holds the data or (b) not troll though anything because I have no idea the data exists.

<img border="0" width="520" src="http://4.bp.blogspot.com/-4mBC-FV5aM4/ULux4qkEzsI/AAAAAAAAAGw/pCm58bNWaKU/s400/screenshot_06.png" />

Due to the magic of inflexible design standards, the data.gov.bc.ca site has **two search boxes**, one that does what I want (the smaller one, below), and one that just does a google search of all the gov.bc.ca sites (that larger one, at the top). Ask me how I figured that out.

So, I type "[watersheds](http://www.data.gov.bc.ca/dbc/search/result.page?ms=url%3Aapps.gov.bc.ca&keyword=watersheds&search.x=0&search.y=0&search=Search)" into the search box and get 10 results. Here I have to lean on my domain knowledge and go to #10, which is the old 3rd order watersheds layer.

<img border="0" width="520" src="http://1.bp.blogspot.com/-nUdnewysyko/ULuyFldFCdI/AAAAAAAAAG8/_LlK3O3I91Q/s400/screenshot_08.png" />

The dataset record is pretty good, my only complaint would be that unlike the old FTP filesystem there's no obvious indication that there are other related data sets that together form a collection of related data, the watershed atlas. The keywords field gets towards that intent, but a breadcrumb trail or something else might be clearer. I think the idea of a data collection made of parts is common to a lot of data domains, and might help people organically discover things more easily.

Anyhow, here's where things get "fun", because here we leave the domain of open data and enter the domain of the "GIS data warehouse". I click on the "SHP" download link:

<img border="0" width="520" src="http://3.bp.blogspot.com/-uSfstrFUfZk/ULuyOdd0a-I/AAAAAAAAAHI/hHdp4Ha9CMg/s400/screenshot_09.png" />

The difference between hosting data on an FTP site and hosting it in a big ArcSDE warehouse is that the former has very few moving parts, is really simple, and practically never does down, while the latter is the opposite of that.

Let's just skip the convenient direct open data link, and try to download the data directly from the warehouse. Go to the warehouse distribution service entry page:

<img border="0" width="520" src="http://4.bp.blogspot.com/-qGTLMLXDmdU/ULuyXFD2rYI/AAAAAAAAAHU/BorX34ZAF4E/s400/screenshot_10.png" />

I like ad for Internet Explorer, that's super stuff. It's almost like these pages are put up and never looked at again. We'll enter as a guest.

<img border="0" width="520" src="http://4.bp.blogspot.com/-H4gTlO7ylBo/ULu1QjT8qpI/AAAAAAAAAJA/D8vO6rHIBMA/s400/screenshot_20.png" />

Two search boxes again, but at least this time the one we're supposed to use is the big one. Thanks to our trip through the data.gov.bc.ca system, we know that typing "WSA" is the thing most likely to get us the "watershed atlas".

Boohyah, it's even the top set of entries. Let's compare the [metadata](https://apps.gov.bc.ca/pub/geometadata/metadataDetail.do?recordUID=43756&amp;recordSet=ISO19115) for fun (click on the "Info" (i)).

<img border="0" width="520" src="http://2.bp.blogspot.com/-QnSxUo_3gDM/ULuyn8gJenI/AAAAAAAAAHs/EMTeDmnahIs/s400/screenshot_11.png" />

Pretty voluminous, and there's a tempting purple download button up there... hey, this one works!

<img border="0" width="520" src="http://2.bp.blogspot.com/-xQl-JGlm2MQ/ULuyzWLv9rI/AAAAAAAAAH4/6PeeLzpLwfI/s400/screenshot_12.png" />

Hm, it wants my email address and for me to assent to a license... I wonder what the license is?

<img border="0" width="520" src="http://3.bp.blogspot.com/-o2GvkdtyH0E/ULuy_PEBYiI/AAAAAAAAAIE/q95TZ4UJc40/s400/screenshot_13.png" />

Why make people explicitly assent to a license that is only implicitly defined? Fun. Ok, fine, have my email address, and I assent to something or other. I **Submit** (in both senses)!

And now I wait for my e-mail to arrive...

<img border="0" width="520" src="http://1.bp.blogspot.com/-pvBkJQh18Ek/ULuzIbCON8I/AAAAAAAAAIQ/gt78Iq7RewQ/s400/screenshot_15.png" />

Hey presto, it's alive! (Sunday 11:27AM) But no data yet.

<img border="0" width="520" src="http://3.bp.blogspot.com/-1OA9cNCMfac/ULuzObK8lAI/AAAAAAAAAIc/3zHGQPtVtPY/s400/screenshot_16.png" />

W00t! Data is ready! (Sunday 11:30AM)

<img border="0" width="520" src="http://1.bp.blogspot.com/-KpWxiPWtwmg/ULuza8DINII/AAAAAAAAAIo/oSK51UwnzPc/s400/screenshot_17.png" />

<img border="0" height="197" width="400" src="http://2.bp.blogspot.com/-qSO7SDC7hZY/ULuzbaR_UYI/AAAAAAAAAI0/Dnc9OzPAxs0/s400/screenshot_18.png" />

Uh, oh, something is wrong here. My browser perhaps? Let's try wget.

    wget ftp://slkftp.env.gov.bc.ca/outgoing/apps/lrdw/dwds/LRDW-1235441-Public.zip
    --2012-12-02 11:33:10--  ftp://slkftp.env.gov.bc.ca/outgoing/apps/lrdw/dwds/LRDW-1235441-Public.zip
               => ‘LRDW-1235441-Public.zip’
    Resolving slkftp.env.gov.bc.ca (slkftp.env.gov.bc.ca)... 142.36.245.171
    Connecting to slkftp.env.gov.bc.ca (slkftp.env.gov.bc.ca)|142.36.245.171|:21... connected.
    Logging in as anonymous ... Logged in!
    ==> SYST ... done.    ==> PWD ... done.
    ==> TYPE I ... done.  ==> CWD (1) /outgoing/apps/lrdw/dwds ... 
    No such directory ‘outgoing/apps/lrdw/dwds’.

This is awesome. OK, back to the FTP client!

    Connected to slkftp.env.gov.bc.ca.
    220-Microsoft FTP Service
    220 This server slkftp.env.gov.bc.ca is for British Columbia Government business use only.
    500 'AUTH GSSAPI': command not understood
    Name (slkftp.env.gov.bc.ca:pramsey): ftp
    331 Anonymous access allowed, send identity (e-mail name) as password.
    Password:
    230 Anonymous user logged in.
    Remote system type is Windows_NT.
    ftp> dir
    200 PORT command successful.
    150 Opening ASCII mode data connection for /bin/ls.
    dr-xr-xr-x   1 owner    group               0 Jul 23  2010 MidaFTP
    dr-xr-xr-x   1 owner    group               0 Aug 25  2010 outgoing
    226 Transfer complete.
    ftp> cd outgoing
    250 CWD command successful.
    ftp> dir
    200 PORT command successful.
    150 Opening ASCII mode data connection for /bin/ls.
    dr-xr-xr-x   1 owner    group               0 Jul  2  2010 apps
    226 Transfer complete.
    ftp> cd apps
    250 CWD command successful.
    ftp> dir
    200 PORT command successful.
    150 Opening ASCII mode data connection for /bin/ls.
    d---------   1 owner    group               0 Jul  2  2010 lrdw
    d---------   1 owner    group               0 Jul  2  2010 mtec
    226 Transfer complete.
    ftp> cd lrdw
    550 lrdw: Access is denied.

So, the anonymous FTP directory where the jobs are landing is not readable (by anyone). Oh, and serious demerits for running an FTP server on Windows (NT!).

The whole data warehouse/data distribution thing substantially pre-dates open data, and actually one of the reasons it (a) exists and (b) is so f***ing terrible is because at the time it was conceived and designed BC was still trying to **sell** GIS data, so the distribution system has crazy layers of security and differentiation between free and non-free data (even though it still forces you to go through "checkout" for free data (which all data now is)).

My request was for only 50Mb of data, and the system is (theoretically) willing to give it to me in one chunk. If I had wanted to access all of TRIM (the 1:20 BC planimetric base map product) I would be, as the French say, "up sh** creek".

The current process is also, clearly, not amenable to automation. If I wanted to regularly download a volatile data set, I would also be, as in the German proverb, FUBAR.

So, there you go, open data folks. I am fully cognizant that the problem is 100% *Not Of Your Design or Doing*, I watched it happen in real time (and even won a contract to maintain the system after it was built! gah!) But it is also, still, now many years on, a Problem. 

Remember, I originally got the data like this.

    ftp ftp.env.gov.bc.ca
    cd /dist/arcwhse/watersheds/
    cd wsd3
    mget *.gz

It ain't Rocket Science, we've just made it seem like it is.

