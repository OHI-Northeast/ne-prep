#create an expanded northeast shapefile that combines state waters and states

source('~/github/ne-prep/src/R/common.R')

library(sf)

#rgns are our rgns

#filter just for coastal states
states <- ne_states %>%
  mutate(state = STUSPS) %>% 
  filter(!state %in% c("VT", "PA", "NJ")) %>%
  select(state, geometry)

#combine states and state waters
all <- rgns %>%
  filter(!is.na(state)) %>%
  select(state, geometry) %>%
  rbind(states) %>%
  st_union(by_feature = TRUE)

#save shapefile

write_sf(all,  "~/github/ne-prep/spatial/shapefiles/states_and_state_waters.shp")
