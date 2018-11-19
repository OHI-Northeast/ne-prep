## this script produces a large (!) .csv file that lists each cellID and species id for species in the region.

source('~/github/ne-prep/src/R/common.R')

cellid_rast <- raster("~/github/ne-prep/spatial/ocean_rasters/ne_cellids.tif")

#dataframe that links cellIDs with the OHI region they are in
rgn_cells <- read.csv("spatial/rgn_cellids.csv") %>%
  select(-X)

files <- list.files(file.path(dir_anx, "bio/spp_presence_rasters"), full.names = T)

## this function maps each species presence/absence raster and overlays the cellIDs to return a dataframe of cellIDs where the species is found, and a column with SID (species ID)
sid_extract <- function(file){
  # update the progress bar (tick()) and print progress (print())
  pb$tick()$print()
  #get SID (species ID)
  sid <- as.numeric(substr(file, 69, nchar(file)-4))
  df <- data.frame(pres = 1, id = sid)
  
  #read in raster
  r <- raster(file)
  
  #swap out 1 for SID simply by multiplying since we have 1 identifying presence (could also use subs but I think this is faster)
  s <- r*sid
  
  #use the raster::zonal() function to get a dataframe that contains cellids and SID as two columns
  z <- zonal(s, cellid_rast, na.rm=T) %>%
    as.data.frame() %>%
    filter(!is.na(mean)) %>%
    rename(cellID = zone,
           SID = mean) %>%
    inner_join(rgn_cells)
}

pb <- progress_estimated(length(files)) #progress bar
sid_cells <- purrr::map_df(files[1:100], sid_extract)
sid_cells2 <- purrr::map_df(files[101:300], sid_extract)
sid_cells3 <- purrr::map_df(files[301:500], sid_extract)
sid_cells4 <- purrr::map_df(files[501:length(files)], sid_extract)

out <- bind_rows(sid_cells, sid_cells2, sid_cells3, sid_cells4)

#save to mazu because of file size (2.5 GB!)
#write.csv(out, file = file.path(dir_anx, "bio/sid_cells.csv"))




