---
layout: post
title: 'Simple SQL GIS'
date: '2019-07-31T00:00:00-08:00'
author: Paul Ramsey
category: technology
tags:
- intersection
- union
- postgis
- postgresql
comments: True
image: "2019/simple2.png"
---

And, late on a Friday afternoon, the plaintive cry was heard!

<blockquote class="twitter-tweet"><p lang="en" dir="ltr">Anyone got a KML/Shapefile of B.C. elxn boundaries that follows the water (Elections BC&#39;s KML has ridings going out into the sea)</p>&mdash; Chad Skelton (@chadskelton) <a href="https://twitter.com/chadskelton/status/269579044692049920?ref_src=twsrc%5Etfw">November 16, 2012</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script> 

And indeed, into the sea they do go!

<img src="{{ site.images }}/2019/simple1.png" />

And ‘lo, the SQL faeries were curious, and gave it a shot!

```bash
##### Commandline OSX/Linux #####

# Get the Shape files
# http://www.elections.bc.ca/index.php/voting/electoral-maps-profiles/
wget http://www.elections.bc.ca/docs/map/redis08/GIS/ED_Province.exe

# Exe? No prob, it's actually a self-extracting ZIP
unzip ED_Province

# Get a PostGIS database ready for the data
createdb ed_clip
psql -c "create extension postgis" -d ed_clip

# Load into PostGIS
# The .prj says it is "Canada Albers Equal Area", but they
# lie! It's actually BC Albers, EPSG:3005
shp2pgsql -s 3005 -i -I ED_Province ed | psql -d ed_clip

# We need some ocean! Use Natural Earth...
# http://www.naturalearthdata.com/downloads/
wget http://www.naturalearthdata.com/http//www.naturalearthdata.com/download/10m/physical/ne_10m_ocean.zip
unzip ne_10m_ocean.zip

# Load the Ocean into PostGIS!
shp2pgsql -s 4326 -i -I ne_10m_ocean ocean | psql -d ed_clip

# OK, now we connect to PostGIS and start working in SQL
psql -e ed_clip
```

```sql
-- How big is the Ocean table?
SELECT Count(*) FROM ocean;

-- Oh, only 1 polygon. Well, that makes it easy... 
-- For each electoral district, we want to difference away the ocean.
-- The ocean is a one big polygon, this will take a while (if we
-- were being more subtle, we'd first clip the ocean down to 
-- a reasonable area around BC.)
CREATE TABLE ed_clipped AS
SELECT 
  CASE 
  WHEN ST_Intersects(o.geom, ST_Transform(e.geom,4326))
  THEN ST_Difference(ST_Transform(e.geom,4326), o.geom)
  ELSE ST_Transform(e.geom,4326)
  END AS geom,
  e.edabbr,
  e.edname
FROM ed e, ocean o;

-- Check our geometry types...
SELECT DISTINCT ST_GeometryType(geom) FROM ed_clipped;

-- Oh, they are heterogeneous. Let's force them all multi
UPDATE ed_clipped SET geom = ST_Multi(geom);
```

```bash
# Dump the result out of the database back into shapes
pgsql2shp -f ed2009_ocean ed_clip ed_clipped
zip ed2009_ocean.zip ed2009_ocean.*
mv ed2009_ocean.zip ~/Dropbox/Public/
```

No more districts in oceans!

<img src="{{ site.images }}/2019/simple2.png" />

And the faeries were happy, and uploaded their polygons!

Update: And the lamentations ended, and the faeries also rejoiced.

<blockquote class="twitter-tweet"><p lang="en" dir="ltr"><a href="https://twitter.com/pwramsey?ref_src=twsrc%5Etfw">@pwramsey</a> OK, that&#39;s frickin&#39; amazing! Thank you! Thought I was in store for hours spent editing polygons by hand in Google Earth.</p>&mdash; Chad Skelton (@chadskelton) <a href="https://twitter.com/chadskelton/status/269598610428162048?ref_src=twsrc%5Etfw">November 17, 2012</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script> 

