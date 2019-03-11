# create a fish lookup table to match species from NMFS catch data, RAM database and NMFS stock assessment data. The stock assessment species are not identical to the species listed in the catch data so we need to make sure they match.

library(tidyverse)

#grab species names from each
nmfs_catch <- read.csv("prep/fis/data/nmfs_spatial_catch_by_ohi_rgn.csv") %>%
  mutate(nmfs_original_species = as.character(species),
         species_low = tolower(species)) %>%
  select(nmfs_original_species, species_low) %>%
  distinct()
nmfs_stock_ass <- read.csv("prep/fis/data/nmfs_stock_assessment_data.csv") %>%
  select(stock) %>%
  distinct()
ram_stock_ass <- read.csv("prep/fis/data/ram_stock_assessment_data.csv") %>%
  select(commonname, areaname) %>%
  distinct()

#grab all species from NMFS catch data and get them, as well as their alternative names, cleaned up

nmfs_catch_sp <- nmfs_catch %>%
  filter(!str_detect(species_low, "bushel")) %>% #remove species that are reported by bushel. These are also reported just in regular pounds
  separate(species_low, into = c("species1", "species2", "species3"), sep = ",", remove = FALSE) %>%
  mutate(species2 = trimws(gsub("\\/.*","", species2))) %>%
  separate(species_low, into = c("alt_name1", "alt_name2","alt_name3"), sep = "/", remove = FALSE) %>%
  mutate(nmfs_catch = str_replace_all(paste0(species3, " ", species2, " ", species1), "NA ", ""),
         nmfs_catch = trimws(gsub("\\/.*","", nmfs_catch)),
         nmfs_catch_alternate = case_when(
          !is.na(alt_name2) ~ alt_name2,
          TRUE ~ NA_character_),
         nmfs_catch_alternate_2 = case_when(
          !is.na(alt_name3) ~ alt_name3,
          TRUE ~ NA_character_)) %>%
  select(species_low, nmfs_catch, nmfs_catch_alternate, nmfs_catch_alternate_2) %>%
  mutate(nmfs_catch2              = ifelse(str_detect(nmfs_catch_alternate, "mixed"), 
                                         paste0(nmfs_catch, " ", nmfs_catch_alternate), NA),
         nmfs_species             = ifelse(!is.na(nmfs_catch2), tolower(nmfs_catch2), tolower(nmfs_catch)),
         nmfs_species_alternate   = trimws(ifelse(str_detect(nmfs_catch_alternate, "mixed"), NA, 
                                                tolower(nmfs_catch_alternate)), "both"),
         nmfs_species_alternate_2 = trimws(tolower(nmfs_catch_alternate_2)), "both") %>% 
  select(species_low, nmfs_species, nmfs_species_alternate, nmfs_species_alternate_2) %>%
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
  select(species_low, species, location, source, nmfs_species) %>%
  left_join(nmfs_catch_sp, by = c("species" = "nmfs_species_alternate")) %>%
  mutate(nmfs_species = ifelse(is.na(nmfs_species.x), nmfs_species.y, nmfs_species.x)) %>%
  select(species_low = species_low.x, species, location, source, nmfs_species) %>%
  left_join(nmfs_catch_sp, by = "nmfs_species") %>%
  mutate(species_low = ifelse(is.na(species_low.x), species_low.y, species_low.x)) %>%
  select(-species.y, -species_low.y, -species_low.x) %>%
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
    species == "winter skate" ~ "winter (big) skate", #we still see winter and little skate wings reported in catch...fixed below
    species == "atlantic wolffish" ~ "wolffish",
    species == "longfin inshore squid" ~ "squid", #the NMFS catch data has longfin and shortfin (loligo and illex). but stock assessment data just has longfin
    TRUE ~ NA_character_
  ),
  nmfs_species = ifelse(is.na(nmfs_species), nmfs_species_fix, nmfs_species),
  nmfs_species_alternate = ifelse(nmfs_species == 'squid', "loligo", nmfs_species_alternate)) %>%
  select(species_low, 
         stock_assessment_species_name = species, 
         stock_assessment_species_location = location,
         source,
         nmfs_catch_species_name = nmfs_species, 
         nmfs_catch_species_name2 = nmfs_species_alternate_2) %>%
  mutate(species_low = case_when(
    nmfs_catch_species_name == "cod" ~ "cod",
    nmfs_catch_species_name == "big eye tuna" ~ "tuna, big eye",
    nmfs_catch_species_name == "bluefin tuna" ~ "tuna, bluefin",
    nmfs_catch_species_name == "american plaice flounder" ~ "flounder, american plaice /dab",
    nmfs_catch_species_name == "surf clam" ~ "clam, surf",
    nmfs_catch_species_name == "red crab" ~ "crab, red",
    nmfs_catch_species_name == "menhaden" ~ "menhaden",
    nmfs_catch_species_name == "monkfish" ~ "monkfish / anglerfish / goosefish",
    nmfs_catch_species_name == "redfish" ~ "redfish / ocean perch",
    nmfs_catch_species_name == "little (summer) skate" ~ "skate, little (summer)",
    nmfs_catch_species_name == "winter (big) skate" ~ "skate, winter (big)",
    nmfs_catch_species_name == "wolffish" ~ "wolffish / ocean catfish",
    nmfs_catch_species_name == "squid" ~ "squid / loligo",
    TRUE ~ as.character(species_low)
  )) %>%
  left_join(nmfs_catch) %>% #add in the original catch (uppercase)
select(nmfs_original_species, stock_assessment_species_name, stock_assessment_species_location, source)


# fixing the skate wings and monk fish pieces matching. Skates and Monkfish are reported in NMFS catch as full fish as well as pieces (wings, livers, heads). I'm sure there is a nice way to incorporate these species names into the data above but I'm doing it manually here...

add_species <- data.frame(stock_assessment_species_name = c("little skate", "winter skate", "smooth skate", "goosefish", "goosefish", "goosefish", "goosefish", "goosefish", "goosefish", "tilefish", "tilefish"),
                          stock_assessment_species_location = c("Georges Bank / Southern New England | Asmt & Status", 
                                                                "Georges Bank / Southern New England | Asmt & Status",
                                                                "Gulf of Maine | Asmt & Status",
                                                                "Gulf of Maine / Northern Georges Bank",
                                                                "Gulf of Maine / Northern Georges Bank",
                                                                "Gulf of Maine / Northern Georges Bank",
                                                                "Southern Georges Bank / Mid-Atlantic",
                                                                "Southern Georges Bank / Mid-Atlantic",
                                                                "Southern Georges Bank / Mid-Atlantic",
                                                                "Mid-Atlantic Coast",
                                                                "Mid-Atlantic Coast"),
                          source = "NMFS",
                          nmfs_original_species = c("SKATE WINGS, LITTLE (SUMMER)", "SKATE WINGS, WINTER (BIG)", "SKATE, SMOOTH", 
                                                    "MONK HEADS", "MONK LIVERS", "MONK TAILS", "MONK HEADS", "MONK LIVERS", "MONK TAILS", "TILEFISH, BLUELINE", "TILEFISH, GOLDEN"))

#combine the two datasets to get the full lookup table
full_df <- comb %>%
  bind_rows(add_species)

###NEED TO ADD STOCK NAMES AND STOCK IDS FROM NMFS CATCH TO THE FINAL TABLE


#save
write.csv(full_df, file = "prep/fis/data/species_lookup_table_catch_stock_assessments.csv")





         