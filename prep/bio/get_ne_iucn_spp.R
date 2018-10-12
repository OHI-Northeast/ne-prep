# get a list of the species in the Northeast that we have from the IUCN maps.

# a lot of this code dips into the spp_risk_dists repo from Casey O'Hara: https://github.com/jafflerbach/spp_risk_dists

library(sf)
library(raster)

#ne region
ne_shp <- st_read(dsn = '~/github/ne-prep/spatial/shapefiles',layer = 'ne_ohi_rgns_simp', quiet = T) 

#cells
cells <- raster("~/github/spp_risk_dists/_spatial/cell_id_rast.tif")

#reproject ne region to the cells crs
ne_reproj <- st_transform(ne_shp, crs = "+proj=cea +lon_0=0 +lat_ts=45 +x_0=0 +y_0=0 +ellps=WGS84
+units=m +no_defs")

#extract cell ids for NE region
ne_cells <- extract(cells, ne_reproj) %>%
  unlist()

#
spp_maps <- read_csv(file.path(dir_data, sprintf('~/github/spp_risk_dists/_data/spp_marine_maps_%s.csv', api_version)),
                     col_types = 'ddciccc')

taxa_cells_file <- file.path('~/github/spp_risk_dists/data_explore', 'taxa_spp_cells.csv')

#file with species information to link to iucn_sid at the end
spp_info <- read_csv("/home/ohara/git-annex/spp_risk_dists/iucn/spp_info_from_api_2018-1.csv")

taxa <- spp_maps$dbf_file %>%
    unique() %>%
    str_replace('\\....$', '')
  
taxa_cells_list <- vector('list', length = length(taxa))
  
for(i in seq_along(taxa)) { ### i <- 5
    taxon <- taxa[i]
    
    spp_ids_in_taxon <- spp_maps %>%
      filter(str_detect(dbf_file, taxon)) %>%
      .$iucn_sid
    cat(sprintf('processing %s spp in %s...\n', length(spp_ids_in_taxon), taxon))
    
    spp_cells <- parallel::mclapply(spp_ids_in_taxon, mc.cores = 32,
                                    FUN = function(x) { ### x <- spp_ids_in_taxon[1]
                                      f <- file.path(dir_o_anx, 'spp_rasters',
                                                     sprintf('iucn_sid_%s.csv', x))
                                      if(file.exists(f)) {
                                        y <- read_csv(f, col_types = 'di') %>%
                                          mutate(iucn_sid = x) %>%
                                          select(-presence)  %>%
                                          filter(cell_id %in% ne_cells)
                                      } else {
                                        y <- data.frame(cell_id = NA,
                                                        iucn_sid = x, 
                                                        f = f, error = 'file not found')
                                      }
                                      return(y)
                                    }) %>%
      bind_rows() %>%
      mutate(spp_gp = taxon)
    
    taxa_cells_list[[i]] <- spp_cells
}
  
taxa_cells_df <- taxa_cells_list %>%
    bind_rows()  %>%
    filter(!is.na(cell_id)) %>%
    select(cell_id, iucn_sid, spp_gp) %>%
    select(iucn_sid) %>%
    distinct() %>%
    left_join(spp_info)

# no common names! trying rfishbase to get common names

library(rfishbase)

sp <- validate_names(c(taxa_cells_df$sciname))  
fb_list <- species(sp) %>%
  select(sciname, FBname)

#add back in common names

out <- taxa_cells_df %>%
  left_join(fb_list) %>%
  rename(common = FBname) %>%
  select(iucn_sid, common, sciname, population, category)

write_csv(out, "~/github/ne-prep/prep/bio/data/iucn_spp_in_ne.csv")



