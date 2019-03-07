# create a fish lookup table to match species from NMFS catch data, RAM database and NMFS stock assessment data. The stock assessment species are not identical to the species listed in the catch data so we need to make sure they match.

library(tidyverse)

#grab species names from each
nmfs_catch <- read.csv("prep/fis/data/nmfs_spatial_catch_by_ohi_rgn.csv") %>%
  select(species) %>%
  distinct()
nmfs_stock_ass <- read.csv("prep/fis/data/nmfs_stock_assessment_data.csv") %>%
  select(stock) %>%
  distinct()
ram_stock_ass <- read.csv("prep/fis/data/ram_stock_assessment_data.csv") %>%
  select(commonname, areaname) %>%
  distinct()

#grab all species from NMFS catch data and get them, as well as their alternative names, cleaned up

nmfs_catch_sp <- nmfs_catch %>%
  mutate(species_low = tolower(species),
         not_ident = ifelse(str_detect(species_low, "not specified"), 1, 0)) %>%
  filter(!str_detect(species_low, "bushel")) %>% #remove species that are reported by bushel. These are also reported just in regular pounds
  separate(species_low, into = c("species1", "species2", "species3"), sep = ",", remove = FALSE) %>%
  mutate(species2 = trimws(gsub("\\/.*","", species2))) %>%
  separate(species_low, into = c("alt_name1", "alt_name2","alt_name3"), sep = "/", remove = FALSE) %>%
  mutate(nmfs_catch = str_replace_all(paste0(species3, " ", species2, " ", species1), "NA ", ""),
         nmfs_catch = trimws(gsub("\\/.*","", nmfs_catch)),
  nmfs_catch_alternate = case_when(
    !is.na(alt_name2) ~ alt_name2,
    TRUE ~ NA_character_
  ),
  nmfs_catch_alternate_2 = case_when(
    !is.na(alt_name3) ~ alt_name3,
    TRUE ~ NA_character_
  )) %>%
  select(nmfs_catch, nmfs_catch_alternate, nmfs_catch_alternate_2) %>%
  mutate(nmfs_catch2 = ifelse(str_detect(nmfs_catch_alternate, "mixed"), paste0(nmfs_catch, " ", nmfs_catch_alternate), NA),
         nmfs_species = ifelse(!is.na(nmfs_catch2), tolower(nmfs_catch2), tolower(nmfs_catch)),
         nmfs_species_alternate = trimws(ifelse(str_detect(nmfs_catch_alternate, "mixed"), NA, tolower(nmfs_catch_alternate)), "both"),
         nmfs_species_alternate_2 = trimws(tolower(nmfs_catch_alternate_2)), "both") %>% 
  select(nmfs_species, nmfs_species_alternate, nmfs_species_alternate_2) %>%
  mutate(species = nmfs_species)

#get nmfs stock assessment data species now - relatively easy
nmfs_stock_sp <- nmfs_stock_ass %>%
  separate(stock, into = c("species", "location"), sep = " - ") %>%
  mutate(species = tolower(species),
         source = "NMFS")
  
#get ram stock species
ram_sp <- ram_stock_ass %>%
  mutate(species = tolower(commonname),
         source      = "RAM",
         location = as.character(areaname)) %>%
  select(-commonname, -areaname) #create a duplicate column "species" to match with noaa


# First I want to combine the RAM and NMFS Stock assessment data since they have location data too

stock_matching <- nmfs_stock_sp %>%
  bind_rows(ram_sp)


#Now combine catch species with stocks. Lots of data wrangling here to get these species to matchup correctly

comb <- stock_matching %>%
  left_join(nmfs_catch_sp) %>%
  select(species, location, source, nmfs_species) %>%
  left_join(nmfs_catch_sp, by = c("species" = "nmfs_species_alternate")) %>%
  mutate(nmfs_species = ifelse(is.na(nmfs_species.x), nmfs_species.y, nmfs_species.x)) %>%
  select(species, location, source, nmfs_species) %>%
  left_join(nmfs_catch_sp, by = "nmfs_species") %>%
  select(-species.y) %>%
  rename(species = species.x) %>%
  mutate(nmfs_species_fix = case_when(  #manually making some fixes for species that are found in both but aren't matching
    species == "atlantic bluefin tuna" ~ "bluefin tuna",
    species == "bigeye tuna" ~ "big eye tuna",
    species == "atlantic surfclam" ~ "surf clam",
    species == "atlantic cod" ~ "cod",
    species == "red deepsea crab" ~ "red crab",
    species == "american plaice" ~ "american plaice flounder",
    species == "atlantic menhaden" ~ "menhaden",
    species == "goosefish" ~ "monkfish",
    species == "acadian redfish" ~ "redfish",
    species == "little skate" ~ "little (summer) skate",
    species == "winter skate" ~ "winter (big) skate", #we still see winter and little skate wings reported in catch...
    species == "thorny skate" ~ "thorny skate wings", #the only thorny skate catch reported is for wings.
    species == "atlantic wolffish" ~ "wolffish",
    species == "longfin inshore squid" ~ "squid", #the NMFS catch data has longfin and shortfin (loligo and illex). but stock assessment data just has longfin
    TRUE ~ NA_character_
  ),
  nmfs_species = ifelse(is.na(nmfs_species), nmfs_species_fix, nmfs_species),
  nmfs_species_alternate = ifelse(nmfs_species == 'squid', "loligo", nmfs_species_alternate)) %>%
  select(stock_assessment_species_name = species, 
         stock_assessment_species_location = location,
         source,
         nmfs_catch_species_name = nmfs_species, 
         nmfs_catch_species_name2 = nmfs_species_alternate_2)


#save
write.csv(comb, file = "prep/fis/data/species_lookup_table_catch_stock_assessments.csv")





         