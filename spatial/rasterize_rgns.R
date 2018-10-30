## Creating a 0.5 degree raster for OHI-Northeast regions

source("~/github/ne-prep/src/R/common.R")

#rasterize regions
library(fasterize)

r <- fasterize(rgns, ocean_ne, field = "rgn_id")

writeRaster(r, filename = "~/github/ne-prep/spatial/ocean_rasters/ne_rgns_rast.tif")
