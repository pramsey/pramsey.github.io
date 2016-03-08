---
layout: post
title: GIS "Data Models"
date: '2015-04-27T09:17:00.000-07:00'
author: Paul Ramsey
category: technology
tags:
- rant
- gis
modified_time: '2015-04-27T09:17:32.962-07:00'
thumbnail: http://1.bp.blogspot.com/-pfiwJjLhL1o/VT5gmjPW9EI/AAAAAAAAAfY/dX6WtAst4Z8/s72-c/screenshot_269.png
blogger_id: tag:blogger.com,1999:blog-14903426.post-2661395897126409101
blogger_orig_url: http://blog.cleverelephant.ca/2015/04/gis-data-models.html
comments: True
---

Most IT professionals have some expectation, having received a basic education on relational data modelling, that a model for a medium sized problem might look like this:

<img src="http://lecture.cs.buu.ac.th/~piya/StudyWork/E-Commerce/All_diagram/ER%20Diagram/ER%20Diagram.jpg" width=500 /> 

Why is it, then, that production GIS data flows so consistently produce models that look like this:

<img border="0" src="http://1.bp.blogspot.com/-pfiwJjLhL1o/VT5gmjPW9EI/AAAAAAAAAfY/dX6WtAst4Z8/s1600/screenshot_269.png" />

What is wrong with us?!?? I bring up this rant only because I was just told that some users find the PostgreSQL 1600 column limit **constraining** since it makes it hard to import the Esri census data, which are "modelled" into tables that are presumably wider than they are long.