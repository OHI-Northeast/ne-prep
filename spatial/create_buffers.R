### buffer_polygons.R
### 20190605 - Jamie Afflerbach


source('~/github/ne-prep/src/R/common.R')

library(sf)


#take our state waters

state_waters <- rgns %>%
  filter(rgn_id > 4) %>%
  mutate(dissolve = 1)

## add a buffer

state_buffer <- st_buffer(state_waters, 1000) 

#combine state waters to use in st_difference
state_waters_combine <- st_combine(state_waters)
state_waters_combine <- state_waters %>%
  group_by(dissolve) %>%
  summarize()


## subtract state waters from buffer. I use st_buffer(.,0) because I ketp getting topology
## errors and this is the suggested way to fix it. 

combine <- st_difference(state_buffer, st_buffer(state_waters_combine,0))

#need to remove offshore piece of the buffer. Maybe we just use the other rgns?

offshore <- rgns %>% 
  filter(rgn_id < 5) %>% 
  st_combine() %>%
  st_buffer(.,1000)

inland_buffer <- st_difference(combine, st_buffer(offshore,0))

### load the states and state waters shapefile

dataportal_state_wa <- read_sf(file.path(dir_anx, "_raw_data/NEOceanDataPortal/Administrative/AdministrativeBoundaries.gdb"), layer = "States") %>%
  st_transform(us_alb)

#intersect with the states/state waters shapefile in order to split the overlapping edges between regions

final_inland_buffer <- st_intersection(inland_buffer, dataportal_state_wa) %>%
  filter(state_name == NAME10) %>%
  select(rgn_name, state_abv, state_name, rgn_id) %>%
  mutate(area = st_area(geometry))


##save
write_sf(final_inland_buffer, "~/github/ne-prep/spatial/shapefiles/ohine_inland_1km.shp", delete_layer = TRUE)

