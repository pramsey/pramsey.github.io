---
layout: post
title: Architecture of Evil
date: '2009-05-06T17:25:00.000-07:00'
author: Paul Ramsey
tags:
- postgis
- javascript
- evil
- architecture
- openlayers
modified_time: '2009-05-06T22:46:30.321-07:00'
thumbnail: http://farm4.static.flickr.com/3599/3509124316_2d43d395bb_t.jpg
blogger_id: tag:blogger.com,1999:blog-14903426.post-1548359478209145558
blogger_orig_url: http://blog.cleverelephant.ca/2009/05/architecture-of-evil.html
comments: True
---

<img src="http://farm4.static.flickr.com/3599/3509124316_2d43d395bb.jpg" />

**Update:** I think the magnitude of the evil can only be appreciated if you see the JSP (yep, that's all of it, that's my "middleware"):<pre><br />&lt;%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %&gt;<br />&lt;%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %&gt;<br />&lt;%@ page contentType="text/x-json" %&gt;

&lt;sql:query var="rs" dataSource="jdbc/postgisdb"&gt;<br />${param.sql}<br />&lt;/sql:query&gt;

{"type":"FeatureCollection",<br /> "features":[<br />&lt;c:forEach var="row" items="${rs.rows}"&gt;<br /> {"type":"Feature",<br />  "geometry":&lt;c:out value="${row.st_asgeojson}" escapeXml="false" /&gt;,<br />  "properties":{<br />  &lt;c:forEach var="column" items="${row}"&gt;<br />   &lt;c:if test="${column.key != 'st_asgeojson'}"&gt;<br />    "&lt;c:out value="${column.key}" escapeXml="false" /&gt;":<br />    "&lt;c:out value="${column.value}" escapeXml="false" /&gt;",<br />   &lt;/c:if&gt;<br />  &lt;/c:forEach&gt;<br />}},<br />&lt;/c:forEach&gt;<br />]}<br /></pre><br />**Update 2:** Yes, I am being a bit sarcastic. Being able to compress the layer between the Javascript and the database into something this narrow is diabolical, and only possible because there is so much smarts in OpenLayers. I, for one, welcome our new hipster Javascript overlords.

**Update 3:** The "evil" is passing SQL unmediated from your browser directly into your database. It's fun in a workshop (which is what I wrote this abomination for) but it's not to be let out of the lab, lest global pandemic ensue.

