### buffer_polygons.R
### 20190528 - Jamie Afflerbach


source('~/github/ne-prep/src/R/common.R')

library(sf)


dir_spatial <- path.expand("~/github/ne-prep/spatial/shapefiles")
buffer_seed_layer <- 'ne_eez'
### expand this basic EEZ file (1 region covering entire EEZ) outward
buffer_slice_layer <- 'states_and_state_waters'
### intersect resulting buffer with this shapefile to slice it into regions
dst <- 'ohine_inland_1km'
### save the result here...
proj_units  <- 'm'
buffer_dist <- 1000

buffer_seed <- read_sf(dir_spatial, layer = buffer_seed_layer) %>%
  select(geometry) %>%
  st_transform(us_alb)

buffer_expanded <- st_buffer(buffer_seed, buffer_dist)

### Intersect the trimmed buffer with the 'slice' layer to divide it into
### OHI Northeast regions.
buffer_slice       <- read_sf(dir_spatial, layer = buffer_slice_layer)
buffer_intersected <- st_intersection(buffer_expanded, buffer_slice)


### Subtract the original shape from the expanded shape to get just the
### buffer region.

buffer_trimmed  <- st_difference(buffer_intersected, st_combine(buffer_seed)) %>%
  filter(is.na(rgn_id))

# MA is not split up in two yet. Here I use our Ecological Production Unit shapefile, which has the split, and expand it with a buffer then intersect with the inland MA buffer and split into two.

# get just gulf of maine EPU and add buffer
epu <- st_read(file.path(dir_anx, 'spatial/data_for_rgn_options/Extended_EPU'), 'EPU_extended', quiet=T) %>%
  st_transform(us_alb) %>%
  filter(EPU == "GOM") %>%
  mutate(longname = 'Gulf of Maine') %>%
  st_buffer(6000) #going 6km not 1km to be conservative and make sure we overlap at least all the coastline


#intersect expanded epu and MA gulf of maine inland buffer
ma_gom <- st_intersection(epu, buffer_trimmed %>% filter(state == "MA")) %>%
  select(state) %>%
  mutate(rgn_id = 7)

#now get inland buffer for MA virginian
ma_v <- st_difference(buffer_trimmed %>% filter(state == "MA"), st_combine(ma_gom)) %>%
  select(state) %>%
  mutate(rgn_id = 8)

#remove MA from buffer_trimmed and add in ma_gom and ma_v
inland_buffer <- buffer_trimmed %>%
  filter(state != "MA") %>%
  select(state, rgn_id) %>%
  rbind(ma_gom) %>%
  rbind(ma_v) %>%
  mutate(rgn_id = case_when(
    state == "NH" ~ 9,
    state == "CT" ~ 5,
    state == "NY" ~ 10,
    state == "ME" ~ 6,
    state == "RI" ~ 11,
    TRUE ~ as.numeric(rgn_id)
  )) %>%
  left_join(rgn_data, by = "rgn_id") %>%
  select(-area_km2, -state.y) %>%
  rename(state = state.x) %>%
  mutate(area = st_area(geometry)) 

#save
write_sf(inland_buffer, paste0("~/github/ne-prep/spatial/shapefiles/", dst, ".shp"))

########

### 3 nm offshore buffer

dst <- 'ohine_offshore_3nm'
### save the result here...
proj_units  <- 'm'
buffer_dist <- 5556 #equal to three nautical miles


buffer_seed <- ne_states %>%
  select(geometry)

buffer_expanded <- st_buffer(buffer_seed, buffer_dist)

### Intersect the trimmed buffer with the 'slice' layer to divide it into
### OHI Northeast regions.
buffer_intersected <- st_intersection(buffer_expanded, rgns %>% filter(rgn_id > 4)) #only state waters

### Subtract the original shape from the expanded shape to get just the
### buffer region.

buffer_trimmed  <- st_difference(buffer_intersected, buffer_seed)

dissolved <- buffer_trimmed %>%
  group_by(rgn_id, rgn_name, state) %>%
  summarise(area_km2 = mean(area_km2))

#mapview::mapview(dissolved)
write_sf(dissolved, "spatial/shapefiles/ohine_offshore_3nm.shp")
