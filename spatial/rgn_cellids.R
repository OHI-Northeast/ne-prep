## Creating a raster with unique CellIDs

source("~/github/ne-prep/src/R/common.R")

library(raster)

r <- raster(nrows = 900, ncols = 800, crs = crs(ocean_ne), ext = extent(ocean_ne), resolution = 1000)
r[] <- 1:ncell(ocean_ne)

#save just the cell id raster
writeRaster(r, filename = "~/github/ne-prep/spatial/ocean_rasters/ne_cellids.tif", overwrite = T)

#now I want a lookup table in .csv form that links OHI NE regions to cell ids
rgn_cells <- r %>%
  raster::extract(rgns, df = TRUE) %>%  #using the rgns shapefile to extract what cells are in what rgns
  rename(rgn = ID,
         cellID = layer)

length(rgn_cells$cellID[duplicated(rgn_cells$cellID)]) #there are 130 cells that are in two regions. Likely border cells. Leaving for now as I think this is ok.

write.csv(rgn_cells, file = "~/github/ne-prep/spatial/rgn_cellids.csv")
