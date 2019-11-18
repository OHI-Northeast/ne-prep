## This script creates a single shapefile that represents the entire region

library(tidyverse)
library(sf)

#the state waters
rgns <- read_sf("spatial/shapefiles/ne_ohi_rgns.shp") %>%
  filter(rgn_id > 4)

#use st_union to combine and dissolve boundaries
state <- st_union(rgns)

#NE ocean plan boundary
ne_sa <- st_read(dsn = "spatial/shapefiles", layer = "ne_region_plus_states", quiet = T) %>%
  st_transform(crs ="+proj=aea +lat_1=29.5 +lat_2=45.5 +lat_0=37.5 +lon_0=-96 +x_0=0 +y_0=0 +ellps=GRS80 +units=m +no_defs")

all <- st_union(state, ne_sa) %>%
  st_sf() %>%
  mutate(rgn_name = "Northeast",
         state_abv = NA,
         state_name = NA,
         rgn_id = 12)

all$area_km2 <- st_area(all)/100000

write_sf(all, "spatial/shapefiles/northeast_rgn.shp")
