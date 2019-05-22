### buffer_polygons.R
### 20190522 - Jamie Afflerbach

source('~/github/ne-prep/src/R/common.R')

library(sf)

dir_spatial <- path.expand("~/github/ne-prep/spatial/shapefiles")
buffer_seed_layer <- 'ne_eez'
### expand this basic EEZ file (1 region covering entire EEZ) outward
buffer_slice_layer <- 'states_and_state_waters'
### intersect resulting buffer with this shapefile to slice it into regions
dst <- 'ohine_inland_3km'
### save the result here...
proj_units  <- 'm'
buffer_dist <- 3000

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

buffer_trimmed  <- st_difference(buffer_intersected, buffer_seed)

### NOTE: Regardless of order (difference, then intersection, or intersection
### then difference), the first step seems to go very quickly then the next
### takes forever.

write_sf(buffer_trimmed, paste0("~/github/ne-prep/spatial/shapefiles/", dst, ".shp"))
