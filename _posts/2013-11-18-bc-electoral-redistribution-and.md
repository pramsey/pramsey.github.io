---
layout: post
title: BC Electoral Redistribution and Population Dispersion
date: '2013-11-18T00:30:00.002-08:00'
author: Paul Ramsey
tags:
- postgis
- gis
- politics
- bc
modified_time: '2014-01-09T09:27:33.804-08:00'
thumbnail: http://4.bp.blogspot.com/_QotpOLPsmaY/TMXyNFCkTsI/AAAAAAAAANM/hqne5U3LYcQ/s72-c/Gerrymander_MD3.jpg
blogger_id: tag:blogger.com,1999:blog-14903426.post-2480534284702500790
blogger_orig_url: http://blog.cleverelephant.ca/2013/11/bc-electoral-redistribution-and.html
comments: True
---

<p>**2013/01/09 Update:** I have converted this blog post into a document and [submitted it as a comment](http://www.ag.gov.bc.ca/legislation/ebca/) on the [white paper](http://www.ag.gov.bc.ca/legislation/ebca/pdf/WhitePaper.pdf).</p><ul><li>[Comments on the White Paper](http://s3.cleverelephant.ca.s3.amazonaws.com/Ramsey_EBCA_Comments_20130110.pdf)</li><li>[Supporting Data](http://s3.cleverelephant.ca.s3.amazonaws.com/Ramsey_EBCA_Comments%2020130110.xlsx)</li></ul><br/><hr/> <p>I've been asked by my technical readers to stop writing so much about politics, but I cannot help myself, and this week I have the perfect opportunity to apply my technical skills to a local political topic. </p><h2>History and Background</h2><p>Like Britain and the USA (and very few other jurisdictions anymore), British Columbia has a first-past-the-post representative electoral system. The province is divided up into "electoral districts" (also known as "ridings" in the British tradition) and each district returns a single member to the Legislature. In each district, the candidate with the most votes wins the district, even if they only obtain a [plurality](http://en.wikipedia.org/wiki/Plurality_(voting)). In the Legislature, the party with most seats forms government. 

In such a system, the geographical layout of the districts has a great deal of importance, because it is possible for a party to win a majority of votes in the province, but a minority of seats in the legislature, if the votes are concentrated in particular seats. This **actually happened** in [British Columbia in 1996](http://en.wikipedia.org/wiki/British_Columbia_general_election,_1996). It also happened in the USA in the [2000 Presidential election](http://en.wikipedia.org/wiki/United_States_presidential_election,_2000), since their presidential [Electoral College](http://en.wikipedia.org/wiki/Electoral_College_(United_States)) effectively acts like a weighted version of a first-past-the-post Legislature. 

In a representative democracy, it's important that everyone's vote have the same weight, which means ensuring that the each district has **approximately the same number of people** in it. As relative populations grow in some regions and shrink in others, districts can become unbalanced, and districts need to be redrawn. In the USA, this "[redistricting](http://en.wikipedia.org/wiki/Redistricting)" process is often driven by partisan considerations, and can lead to districts like this (try out this awesome [gerrymandered districts puzzle game](http://www.slate.com/articles/news_and_politics/map_of_the_week/2013/08/gerrymandering_jigsaw_puzzle_game_put_the_congressional_districts_back_together.html)): </p><img src="http://4.bp.blogspot.com/_QotpOLPsmaY/TMXyNFCkTsI/AAAAAAAAANM/hqne5U3LYcQ/s1600/Gerrymander_MD3.jpg"/><p>Fortunately, since 1989 British Columbia's districts have been drawn every 10 years by non-partisan "[Electoral Boundaries Commissions](http://www.elections.bc.ca/index.php/maps/electoral-boundaries-commission-reports/)", and the primary consideration has been creating districts that are as equal in population as possible while allowing for effective representation. </p><h2>Effective Representation</h2><p>BC is a big place and a place of extremes. The smallest district in BC is in downtown Vancouver (*Vancouver-West End*), with an area of under 500 hectares: it takes less than 30 minutes to walk across it and 48,500 people live there.  

The largest district is in the north-west of the province (*Stikine*), with an area of almost 20,000,000 hectares: about the size of Ireland, Switzerland, Denmark and the Netherlands, **combined**. Just over 20,000 people live in it. When you're dealing with areas this sparsely populated "effectiveness of representation" begins to have some concrete meaning. 

On the other hand, the principle of "one person, one vote" is the corner-stone of democracy, and the goal of an electoral boundary re-distribution is to try to achieve it, as far as possible. There is a tension inherent in the process. </p><h2>2008 Commission Catastrophe</h2><p>Population growth in BC over the last generation has been concentrated in the south: mostly in Vancouver and its suburbs, with some in Vancouver Island and Kelowna. Commissions have dealt with this growth through a combination of increasing the number of seats in the Legislature (to suppress the growth of the average seat size), and slowly increasing the size of the rural districts (to keep defensibly close to the average). 

In 2008, this process reached a tipping point, as the Commission recommended two new seats, and the transfer of three seats from rural areas to urban areas. Rural BC exploded in anger, and the government of the day rushed in legislation directing the Commission to add more seats than recommended and to avoid removing seats from certain rural areas. 

At this point, though the process remained **non-partisan** (both parties in the Legislature supported the new plan), it had become **thoroughly politicized** (the carefully considered deliberations of the Commission had been hastily overturned by politicians for public relations purposes). </p><h2>Formalization of Politicization</h2><p>No doubt remembering the tumult of the 2008 experience, the current government of BC has [released a proposal](http://www.ag.gov.bc.ca/legislation/ebca/pdf/WhitePaper.pdf) for the rules governing the next Electoral Boundary commission. The proposal aims to avoid a messy politicization of the process at the end, by politicizing quietly it in advance:  </p><ul><li>The Commission may not recommend adding any further seats to the Legislature</li><li>The Commission may not remove seats from three protected regions: North, Columbia-Kootenay, and Cariboo-Thompson</li></ul><p>The protected regions look like this. 

[readily available as GIS files online](http://3.bp.blogspot.com/-j4cylpmcQec/Uom50Q_2ciI/AAAAAAAAAGc/6cNoPu0E3WY/s1600/screenshot_03.jpg" imageanchor="1" ><img border="0" width="700" src="http://3.bp.blogspot.com/-j4cylpmcQec/Uom50Q_2ciI/AAAAAAAAAGc/6cNoPu0E3WY/s1600/screenshot_03.jpg" /></a>

Note that the Okanagan region is isolated from the rest of the "unprotected" areas of the province, making it impossible to juggle population into or out of the region. That means the Okanagan can either gain or lose a whole seat, but never lose a "half" a seat by having population juggled in or out via boundary changes. 

Anyone with a passing familiarity with BC electoral geography will recognize that this proposal entrenches an already large and growing deviation from the principle of one-person-one-vote, but I want to calculate just how large, and also to measure the "fairness" of this particular proposal. </p><h2>Population</h2><p>The electoral district boundaries of BC are <a href="http://www.elections.bc.ca/index.php/maps/electoral-maps-profiles/geographic-information-system-spatial-data-files-2012/), but do not have population information attached (and would be out of date if they did, since they pre-date the most recent census). 

Similarly, the StatsCan [boundary files](http://www12.statcan.gc.ca/census-recensement/2011/geo/ref/att-eng.cfm) can be downloaded, and the attribute file giving the [census 2011 population in each block](http://www12.statcan.gc.ca/census-recensement/2011/geo/bound-limit/bound-limit-2011-eng.cfm) is also available. There are about 500-800 blocks in each electoral district, making for a very fine-grained profile of where people are concentrated in each district. 

I loaded the GIS files into a [PostGIS](http://postgis.net) spatial database for analysis. Once the electoral districts (<code>ed</code>) and dissemination blocks (<code>db</code>) were loaded, calculating the electoral district population in PostGIS was a simple spatial join query: </p><pre><br />SELECT ed.edabbr, ed.edname, sum(db.popn) as popn<br />FROM ed, db<br />WHERE ST_Intersects(ed.geom, db.geom) <br />AND ST_Contains(ed.geom, ST_Centroid(db.geom))<br /></pre><p>The results of this calculation and others in this article can be seen in the [spreadsheet](http://s3.cleverelephant.ca.s3.amazonaws.com/Ramsey_EBCA_Comments%2020130110.xlsx) I've placed online. 

A quick summary of the population results shows that, among other things: </p><ul><li>The current distribution is extremely lopsided, with the most heavily populated riding (Surrey-Cloverdale, 73042) having well over 3 times the population of the least populated (Stikine, 20238)</li><li>The current provincial average population is 51765 per riding</li><li>The average population in the 17 "protected" ridings is 35609, 31% less that the provincial average</li><li>The average population in the 68 "unprotected" ridings is 55804, 8% higher than the provincial average</li><li>A vote in the protected regions will be over 1.5 times more "powerful" than one in the unprotected regions</li><li>Of the 85 ridings, 26 are below average and 59 are above average, indicating that the problem of underpopulation is concentrated in a minority of ridings</li></ul><p>There is no doubt that the government proposal will enshrine the regional imbalance in representation, and further worsen it as continued migration into the south pushes the balance even further out of line. </p><h2>"Fair" Imbalances</h2><p>Legal challenges to imbalanced representation have [resulted in court decisions](http://www.elections.ca/res/eim/article_search/article.asp?id=68&lang=e&frmPageSize=10) that indicate that it is constitutional **within limits**, and with **reasonable justification**. The limits generally accepted by the courts are +/- 25% of the provincial average, and the starting point of this proposal already exceeds that **on average**--some individual ridings (like Stikine) will be much worse. Political commentators in BC are [already musing](http://www.vancouversun.com/news/voter+vote+some+pack+more+punch/9169881/story.html) about whether ridings built under this scheme would survive a court challenge. 

Of more analytical interest is whether the scheme of selecting "protected regions" is a good one for choosing which ridings should receive preferential treatment. 

"Representing" a riding involves being available to your constituents, meeting with other orders of government in your riding (cities, school boards), and attending local events. Representation is very much tied up with **being where the people are**.  </p><ul><li>If the people are **all in one place**, near together, then representing them is **easy**.</li><li>If the people are spread out, in **many different localities**, then representing them is **hard**.</li></ul><p>Can we measure the "spreadoutness" of people? Yes, we can! </p><h2>Calculating Dispersion</h2><p>Each riding contains several hundred census dissemination blocks, each of which has a population associated with it. Imagine measuring the distance between each block, and all the other blocks in the riding, and weighting that distance by the population at each end. 

For *Vancouver-Fairview*, the picture looks like this.

[ spreadsheet](http://4.bp.blogspot.com/-0UO8vHe62tQ/UonCkMcqdgI/AAAAAAAAAGs/gHpBXFCWbKE/s1600/screenshot_02.png" imageanchor="1" ><img border="0" width="550" src="http://4.bp.blogspot.com/-0UO8vHe62tQ/UonCkMcqdgI/AAAAAAAAAGs/gHpBXFCWbKE/s1600/screenshot_02.png" /></a>

The blocks are fairly regular, the population is all very close together, and the dispersion is not very high.

For *Skeena*, the picture looks like this.

<a href="http://3.bp.blogspot.com/-W6c3K6QIDMA/UonC-ksRJ6I/AAAAAAAAAG0/lxrG-gj2cHA/s1600/screenshot_01.png" imageanchor="1" ><img border="0" width="550" src="http://3.bp.blogspot.com/-W6c3K6QIDMA/UonC-ksRJ6I/AAAAAAAAAG0/lxrG-gj2cHA/s1600/screenshot_01.png" /></a>

The population is concentrated in two centers (Terrace and Kitimat) reasonably far apart, giving a much higher dispersion than the urban ridings. 

In mathematical terms, the formula for "dispersion" looks like this. 

<a href="http://2.bp.blogspot.com/-roQEplqg67M/UonEy5JJRcI/AAAAAAAAAHA/h5p6cc3a9BU/s1600/gif-1.latex.gif" imageanchor="1" ><img border="0" src="http://2.bp.blogspot.com/-roQEplqg67M/UonEy5JJRcI/AAAAAAAAAHA/h5p6cc3a9BU/s400/gif-1.latex.gif" /></a>

In the database, after creating a table of census blocks that are coded by riding, the calculation looks like this. </p><pre><br />WITH interim AS (<br /> SELECT <br />  a.ed,<br />  max(a.edname) AS edname,<br />  sum(b.popn * a.popn * st_distance_sphere(a.pt, b.pt)) AS score,<br />  sum(b.popn * a.popn) AS p2<br /> FROM popn a, popn b<br /> WHERE a.ed = b.ed<br /> GROUP BY a.ed<br />)<br />SELECT ed, edname, score/p2/1000 AS score <br />FROM interim;<br /></pre><p>Taking the ratio of the distance scaled populations against the unscaled populations allows populations that are far apart to dominate ones that are close together. Scaling the final result down by 1000 just makes the numbers more readable. 

 As before, the results of this calculation and others in this article can be seen in the <a href="http://s3.cleverelephant.ca.s3.amazonaws.com/Ramsey_EBCA_Comments%2020130110.xlsx). </p> <h2>Is Regional Protection "Fair"</h2><p>Using the measure of dispersion allows us to evaluate the government proposal on its merits: does protecting the North, Kootenays, Cariboo and Thompson protect those ridings that are most difficult to represent? 

In short, **no**. 

The regional scheme protects **some** difficult ridings (*Stikine*) but leaves others (*North Island*) unprotected. It also protects ridings that are **not particularly dispersed** at all (*Kamloops-South Thompson*), while leaving more dispersed ridings (*Powell River-Sunshine Coast*, *Boundary-Similkameen*) unprotected. 

Among the larger ridings, *Skeena* is notable because even though it is the 10th largest riding by area, and 10th sparsest by population density, it's only the 17th most dispersed. There are many smaller ridings with more dispersion (*Powell River-Sunshine Coast*, *Nelson-Creston*, *Boundary-Similkameen*). This is because most of the people in *Skeena* live in Terrace and Kitimat, making it much easier to represent than, say, *North Island*. Despite that, *Skeena's* population is 43% below the average, while *North Island's* is 5% above. 

*Kamloops-South Thompson* is the least dispersed (score 15.2) protected riding, and it's worth comparing it to the similar, yet unprotected, *Nanaimo-North Cowichan* (score 16.2). 

*Kamloops-South Thompson* (protected) consists of a hunk of Kamloops, and a string of smaller communities laid out to the east for 50KM along Highway 1.

[proposal to amend the Redistribution Act](http://2.bp.blogspot.com/-3eHP9gcwKo4/UonJOkLA8hI/AAAAAAAAAHM/AhNKREQsMs0/s1600/screenshot_04.jpg" imageanchor="1" ><img border="0" width="700" src="http://2.bp.blogspot.com/-3eHP9gcwKo4/UonJOkLA8hI/AAAAAAAAAHM/AhNKREQsMs0/s1600/screenshot_04.jpg" /></a>

*Nanaimo-North Cowichan* (unprotected) consists of a hunk of Nanaimo, and a string of smaller communities laid out to the south for 45KM along Highway 1 (and some settled islands).

<a href="http://1.bp.blogspot.com/-4L4d73jnyOU/UonJu0t8e6I/AAAAAAAAAHU/CtfIdlU2QeQ/s1600/screenshot_05.jpg" imageanchor="1" ><img border="0" width="700" src="http://1.bp.blogspot.com/-4L4d73jnyOU/UonJu0t8e6I/AAAAAAAAAHU/CtfIdlU2QeQ/s1600/screenshot_05.jpg" /></a>

What is it about *Kamloops-South Thompson* that recommends it for protected status along with truly dispersed difficult ridings like *Stikine*? Nothing that I can determine. </p><h2>Let the Commission Work</h2><p>The intent of the government's <a href="http://www.ag.gov.bc.ca/legislation/ebca/pdf/WhitePaper.pdf) is clearly to avoid the firestorm of protest that accompanied the 2008 Commission report, and it's good they are thinking ahead.  

They need to think **even further ahead**: the consequences of having the boundaries enacted, then **reversed in court**, will be far more disruptive than allowing the Commission to proceed with the necessary work of redistributing BC's districts to **more fairly reflect our actual population distribution**. 

The end result of an unconstrained Commission will be fair boundaries that still reflect the representation needs of dispersed ridings by giving them lower populations **within the limits already acknowledged by the courts**: +/- 25% with a handful of exceptions (I'm looking at you, *Stikine*). 

I encourage you to explore the data on dispersion, and how it relates to the regional "protection" scheme, in the [spreadsheet](http://s3.cleverelephant.ca.s3.amazonaws.com/Ramsey_EBCA_Comments%2020130110.xlsx). </p><br/>