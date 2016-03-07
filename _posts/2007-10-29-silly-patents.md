---
layout: post
title: Silly Patents
date: '2007-10-29T09:46:00.000-07:00'
author: Paul Ramsey
tags: 
modified_time: '2007-10-29T10:50:53.867-07:00'
blogger_id: tag:blogger.com,1999:blog-14903426.post-978119062185635758
blogger_orig_url: http://blog.cleverelephant.ca/2007/10/silly-patents.html
---

If you word things right, even pre-existing concepts can be re-packaged as bright original ideas.  Google has [filed a patent](http://appft1.uspto.gov/netacgi/nph-Parser?Sect1=PTO2&Sect2=HITOFF&u=%2Fnetahtml%2FPTO%2Fsearch-adv.html&r=1&p=1&f=G&l=50&d=PG01&S1=20070250477&OS=20070250477&RS=20070250477) on an indexing method that is nothing but a specialization of a quad-tree, and a packing of level/row/column information into a 64-bit address space.

The specialization of quad-tree is to always use powers-of-two: cut your parents into four identical children; ensure the children are at a scale exactly half that of the parents.  This yields nice behavior in the row/column, you can traverse to the parent row/column of a cell just be dividing the current row/column by two.

The packing of the information into a cell id is not completely clearly explained, because there is some talk of compacting and stop bits, to fit 31 levels, but even without compacting a 64-bit space can hold 29 levels quite easily (5 bits of level information, 29 bits of row address, 29 bits of column address).

I am a bit incredulous at the implied assertion that no one thought of chopping up the map of the world in descending powers-of-two before.  The specific claims about the packing method might indeed be "original" but in such a trivial way as to be unimportant.

The whole process of software patenting reminds me of the historical acts of [enclosure](http://en.wikipedia.org/wiki/Enclosure) in England.

<blockquote>*They hang the man, and flog the woman,<br />That steals the goose from off the common;<br />But let the greater villain loose,<br />That steals the common from the goose.*<br />&mdash Oliver Goldsmith</blockquote>

