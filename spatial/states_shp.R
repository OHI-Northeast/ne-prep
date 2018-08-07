# Making a land shapefile

source('~/github/ne-prep/src/R/common.R')

#downloaded from US Census Bureau on 12-30-2016: https://www.census.gov/geo/maps-data/data/cbf/cbf_state.html
states <- st_read(dsn = file.path(dir_anx,'spatial/cb_2015_us_state_500k'),layer = 'cb_2015_us_state_500k')%>%
  st_crop(wgs_ext) %>%
  filter(NAME %in% c("Massachusetts", "New Hampshire", "Rhode Island", "Pennsylvania",
                     "Connecticut", "New Jersey", "New York", "Maine", "Vermont")) %>%
  dplyr::select(-STATEFP,-STATENS,-GEOID,-LSAD,-ALAND,-AWATER) %>%
  st_crop(ne, xmin = -75, xmax = -66.9, ymin = 40.2, ymax = 47.5) %>%
  st_transform("+proj=aea +lat_1=29.5 +lat_2=45.5 +lat_0=37.5 +lon_0=-96 +x_0=0 +y_0=0
+ellps=GRS80 +datum=NAD83 +units=m +no_defs +towgs84=0,0,0") #us_alb proj

plot(states[1])

st_write(states, dsn = 'spatial/shapefiles', layer = 'states.shp', driver = 'ESRI Shapefile', delete_layer = TRUE)
