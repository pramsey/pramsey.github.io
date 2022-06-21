---
layout: post
title: 'Some More PostGIS Users'
date: '2022-06-21T00:00:00-08:00'
author: Paul Ramsey
category: technology
tags:
- postgis
comments: True
image: "2022/elemap.jpg"
---

The question of why organizations are shy about their use of open source is an interesting one, and not completely obvious.

Open source luminary [Even Roualt](https://twitter.com/evenrouault?s=21) [asks](https://twitter.com/evenrouault/status/1538970569907003392?s=21):

> is there some explanation why most institutions can't communicate about their PostGIS use ? 
> just because it is a major hurdle for technical people to get their public relationship department approve a communication ? 
> people afraid about being billed about unpaid license fees 🤣 ?

There's really very little **upside** to publicizing open source use. There's no open source marketing department to trumpet the brilliance of your decision, or invite you to a conference to [give you an award](https://www.esri.com/about/newsroom/announcements/esri-awards-gis-users-for-innovation-and-global-contribution/). On the other hand, if you have made the mistake of choosing an open source solution over a well-known proprietary alternative, there is surely a **local sales rep** who will call your boss to tell them **that you have made a big mistake**. (You do have a good relationship with your boss, I hope.)

These reverse incentives can get pretty strong. [Evendiagram](https://twitter.com/evendiagram?s=21) [reports](https://twitter.com/evendiagram/status/1538990653262155782?s=21):

> Our small group inside a large agency uses postgis. We don't talk about it, even internally, to avoid the C-suite forcing everyone back to oracle. RHEL repos allow us a lot of software that would otherwise be denied.

This reminds me of my years consulting for the British Columbia government, when technical staff would run data processing or even full-on public web sites from PostgreSQL/PostGIS machines under their desktops.

They would tell their management it was "just a test system" or "a caching layer", really anything other than "it's a database", because if they uttered the magic word "**database**", the system would be slated for migration into the blessed realm of *enterprise Oracle systems*, never to be heard from again.


## Logos

<img src="{{ site.images }}/2022/iowa-state-cyclones-logo.png" style="float:right;padding-left:10px;" />Meanwhile, [Daryl Herzmann](https://twitter.com/akrherz) reminds us that the [Iowa Mesonet](https://mesonet.agron.iastate.edu/) has been on **Team PostGIS** [since 2003](https://lists.osgeo.org/pipermail/postgis-users/2003-February/002038.html).

> Iowa Environmental Mesonet, Iowa State University<br/>
> - Data being managed in the database<br/>
> Meteorological Data, "Common" GIS datasets (roads, counties), Current and 
Archived NWS Tornado/Flash Flood/Thunderstorm Warnings, Historical Storm 
Reports,  Current and Archived precipitation reports.  Climate data<br/>
> - How the data is being accessed / manipulated<br/>
>From mapserver!  Manipulated via Python and PHP.<br/>
> - Why you chose to use PostGIS for the application<br/>
> Open-Source.  Uses my favorite DB, Postgres.  Easy integration with 
mapserver.  The support community is fantastic!

<img src="{{ site.images }}/2022/ua.jpg" style="float:right;padding-left:10px;" />Further afield, the GIS portals of governments throughout Ukraine are running on [software built on PostGIS](https://cadastre-com-ua.translate.goog/pro-nas?_x_tr_sl=uk&_x_tr_tl=en&_x_tr_hl=en&_x_tr_pto=wapp&_x_tr_sch=http). 

[Jørgen Larsen de Martino](https://twitter.com/DocDemar) notes [that](https://twitter.com/docdemar/status/1539160848475766784?s=21):

> <img src="{{ site.images }}/2022/sdfi.jpg" style="float:right;padding-left:10px;" />The [Danish Agency for Data Supply and Infrastructure](https://eng.sdfe.dk) uses PostGIS extensively - and have  been using it for the last 10 years - we would not have had the success we have was it not for @PostGIS.

<img src="{{ site.images }}/2022/ugrc.png" style="float:right;padding-left:10px;" />The [Utah Geospatial Resource Center](https://gis.utah.gov/about/) uses PostGIS to provide access to multiple spatial layers for **direct access** in a cloud-hosted PostGIS database called the "[Open SGID](https://gis.utah.gov/sgid/open-sgid/)". (I can hear DBA heads exploding around the world.) 


## Counterpoint

While self-reporting is nice, sometimes just a little bit of dedicated searching will do. Interested in PostGIS use in the military? Run a search for "[postgis site:mil](https://www.google.com/search?q=postgis+site:mil)" and see what pops up!

<img src="{{ site.images }}/2022/af-logo-seal.png" style="float:right;padding-left:10px;" />The 108th wing of the Air Force! Staff Sgt. Steve De Leon is [hard at it](https://www.108thwing.ang.af.mil/News/Features/Display/Article/2685701/knowledge-outweighs-rank-for-national-guardsman-in-charge-of-amc-phoenix-oracle/)!

> “I’m taking all the data sources that AMC and A2 compile and indexing them into the PostgreSQL/PostGIS data and then from there trying to script Python code so the website can recognize all the indexed data in the PostgreSQL/PostGIS database,” said the De Leon.

<img src="{{ site.images }}/2022/ca-dnd.png" style="float:right;padding-left:10px;" />The Canadian Department of National Defense is building [Maritime Situational Awareness Research Infrastructure](https://apps.dtic.mil/sti/pdfs/AD1017571.pdf) with a PostgreSQL/PostGIS standard database component.

> PostgreSQL with its PostGIS extension is the selected DBMS for MSARI. To ease mainte-
nance and access, if more than one database are used, PostgreSQL will be selected for all
databases.

<img src="{{ site.images }}/2022/uscg.jpg" style="float:right;padding-left:10px;" />The Coast Guards "Environmental Response Management Application (ERMA)" is [also running PostGIS](https://homeport.uscg.mil/Lists/Content/Attachments/75962/ERMA%20Basic%20User%20Guide.pdf).

> The application is based on open source software (PostgreSQL/PostGIS, MapServer, and OpenLayers), that meet Open Geospatial Consortium (OGC) specifications and standards used across federal and international geospatial standards communities. This ensures ERMA is compatible with other commercial and open-source GIS applications that can readily incorporate data from online data projects and avoids licensing costs. Open-source compatibility supports data sharing, leverages existing data projects, reduces ERMA’s maintenance costs, and ensures system flexibility as the technology advances. Because ERMA is open source, it can easily be customized to meet specific user requirements.


## More logos?

Want to appear in this space? [Email me!](mailto:pramsey@cleverelephant.ca)





