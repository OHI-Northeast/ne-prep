
# Summary

# This script creates scored rasters for each species depending on their conservation status and location. These rasters are primarily going to be used to create an aggregate species conservation risk map for the OHI Northeast region.

# Setup

source('~/github/ne-prep/src/R/common.R')


# Rasterize

# Load data


iucn_cells <- data.table::fread(file.path(dir_anx, "bio/iucn_sid_cells.csv")) %>%
  select(-V1)
dp_cells   <- data.table::fread(file.path(dir_anx, "bio/ne_dataportal_spp_cells.csv")) %>%
  select(-V1) %>%
  mutate(common = tolower(str_replace_all(species, "_", " ")),
         common = str_replace(common, " normalized", "")) 


#Load species rgn scores information

spp_rgn_scores <- read_csv("~/github/ne-scores/region/layers/spp_status_scores.csv")



#Read in rasters

portal_list <- list.files(file.path(dir_anx, "bio/portal_spp_rasters"), full.names = T)
#iucn rasters
iucn_rasters <- list.files(file.path(dir_anx, "bio/spp_presence_rasters"), full.names = T)

#remove all rasters we don't want. I know this is ugly!
iucn_list <- iucn_rasters[substr(iucn_rasters, 69, nchar(iucn_rasters)-4) %in% spp_rgn_scores$iucn_sid]


#Function to score IUCN species maps


cellid_rast <- raster("~/github/ne-prep/spatial/ocean_rasters/ne_cellids.tif")

score_iucn_spp <- function(file){
  
  sid <- substr(file, 69, nchar(file)-4)
    
  sid_cells <- iucn_cells %>%
    filter(SID == sid) %>%
    left_join(spp_rgn_scores, by = c("SID" = "iucn_sid", "rgn" = "rgn_id")) %>%
    select(cellID, score) %>%
    distinct()
  
  status_raster <- subs(cellid_rast, sid_cells, by = 1, which = 2)
  writeRaster(status_raster, paste0(file.path(dir_anx), "/bio/scored_rasters/iucn_", sid, "_scored.tif"), overwrite = T)
  
}


#Function to score NE data portal species maps


score_dp_spp <- function(file){
  
  sp <- substr(file, 58, nchar(file)-4)
    
  sp_cells <- dp_cells %>%
    filter(species == sp) %>%
    left_join(spp_rgn_scores, by = c("common", "rgn" = "rgn_id")) %>%
    select(cellID, score) %>%
    distinct()
  
  status_raster <- subs(cellid_rast, sp_cells, by = 1, which = 2)
  writeRaster(status_raster, paste0(file.path(dir_anx), "/bio/scored_rasters/dp_", sp, "_scored.tif"), overwrite = T)
  
}

#Apply

lapply(iucn_list, score_iucn_spp)
lapply(portal_list, score_dp_spp)


# create species risk map
l <- list.files(file.path(dir_anx, "bio/scored_rasters"), full.names = T) %>% 
  stack()

species_risk_map <- sum(l, na.rm = T)

## how many species per cell
dp_count <- dp_cells %>%
  group_by(cellID) %>%
  count()

iucn_count <- iucn_cells %>%
  group_by(cellID) %>%
  count()

sp_per_cell <- iucn_count %>%
  bind_rows(dp_count) %>%
  group_by(cellID) %>%
  summarize(num_species = sum(n))

#rasterize 

sp_per_cell_ras <- subs(cellid_rast, sp_per_cell, by = 1, which = 2)

sp_risk_map <- species_risk_map/sp_per_cell_ras

writeRaster(species_risk_map, filename = "~/github/ne-prep/prep/bio/spp/data/spp_status_risk.tif", overwrite = T)
