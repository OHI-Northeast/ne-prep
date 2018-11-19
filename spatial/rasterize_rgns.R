## Creating a 1km2 degree raster for OHI-Northeast regions

source("~/github/ne-prep/src/R/common.R")

#rasterize regions
library(fasterize)

#rasterizing each region to the same res as ocean_ne (1km2 cells)
r <- fasterize(rgns, ocean_ne, field = "rgn_id")

writeRaster(r, filename = "~/github/ne-prep/spatial/ocean_rasters/ne_rgns_rast.tif")
