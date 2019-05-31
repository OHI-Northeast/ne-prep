library(raster)
library(rnaturalearth)

#get mercator world map
merc_world <- ne_coastline() %>%
  spTransform(CRS("+proj=merc +ellps=GRS80"))

arctic_tern <- raster(file.path(dir_anx, "_raw_data/DUKE_NE_Data_Portal/OHI_PA_Data/Avian_PA/Richness_PA_arctic_tern_normalized.tif"))

plot(merc_world, main = "Arctic Tern")
plot(arctic_tern, add = T)

#this looks off! Should be in the Northeast but we see it over west Africa...Let's try with another bird


black_scoter <- raster(file.path(dir_anx, "_raw_data/DUKE_NE_Data_Portal/OHI_PA_Data/Avian_PA/Richness_PA_black_scoter_normalized.tif"))

plot(merc_world, main = "Black scoter")
plot(black_scoter, add = T)

