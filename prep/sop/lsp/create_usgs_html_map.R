
#Create and save an interactive .html map to show the different layers.


#libraries
library(tidyverse)
library(sf)
library(mapview)

source('~/github/ne-prep/src/R/common.R')

#load buffers
inland_buffer <- read_sf("~/github/ne-prep/spatial/shapefiles/ohine_inland_1km.shp")
offshore_buffer <- rgns %>% filter(rgn_id > 4)


st_layers(file.path(dir_anx, "_raw_data/USGS/PADUS2_0_GDB_Arc10x/PADUS2_0.gdb"))

#load land layers
desig <- read_sf(dsn = file.path(dir_anx, "_raw_data/USGS/PADUS2_0_Shapefiles/PADUS2_0Designation.shp")) %>%
  st_transform(us_alb) %>%
  st_crop(rgns) %>%
  st_intersection(inland_buffer)

ease <- read_sf(dsn = file.path(dir_anx, "_raw_data/USGS/PADUS2_0_Shapefiles/PADUS2_0Easement.shp")) %>%
  st_transform(us_alb) %>%
  st_crop(rgns)  %>%
  st_intersection(inland_buffer)

#fee is causing geometry errors. so i filter just for our states first and the error goes away. The error must exist outside or region of interest
fee <- read_sf(dsn = file.path(dir_anx, "_raw_data/USGS/PADUS2_0_Shapefiles/PADUS2_0Fee.shp")) %>%
  filter(State_Nm %in% c("NY", "RI", "CT", "MA", "NH", "ME")) %>%
  st_transform(us_alb) %>%
  st_crop(rgns)  %>%
  st_intersection(inland_buffer)

#load marine layers
marine <- read_sf(dsn = file.path(dir_anx, "_raw_data/USGS/PADUS2_0_Shapefiles/PADUS2_0Marine.shp")) %>%
  st_transform(us_alb) %>%
  st_crop(rgns)  %>%
  st_intersection(offshore_buffer) %>%
  filter(!Loc_Ds %in% c("Fishery Management Area", "Closure Area", "Fishery Management Areas", "Shellfish Management Area", "Essential Fish Habitat Conservation Area", "Conservation Area", "Gear Restricted Area", "Special Area Management Plan"), #the Conservation Areas are for Mussel Seed
         !is.na(Loc_Ds)) 

usgs_data <- mapview(proc, col.regions = "red") + mapview(desig, col.regions = "yellow") + mapview(ease, col.regions = "green") + mapview(marine, col.regions = "blue") +mapview(fee, col.regions = "orange")

## save interactive map
mapshot(usgs_data, url = "usgs_map.html")
