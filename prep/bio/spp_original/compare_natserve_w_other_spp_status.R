## compare regional status values for species from different data sources
##
## We have regional status information pulled down for regional species from Nature Serve. We also have an Excel spreadsheet
## that lists species with status information by state, sent to us by Emily. In that data, status' are listed as SC (species of concern),
## T (threatened) or E (endangered). 
##
## Here I compare those statuses with the ones provided by NatureServe. If they are similar, we can stick with the NatureServe data. 


#pull in the regional status data which gives status information for species in the ne data portal
ne_sp_status<- readxl::read_excel(file.path(dir_anx, "_raw_data/species/KLW_ES_Data_gaps_Northeast_species_list_9.29.16.xlsx"),
                                  sheet = "all species",
                                  skip = 1) %>%
  select(common = `Species - common name`, 
         status = `E, T, SC`) %>%
  filter(!is.na(status))


ne_dataportal_sp_rgns_scores <- ne_sp_status %>%
  separate(col = status, into = c("states", "status1", "status2"), sep = ";") %>%
  separate(col = states, into = c("state1", "stat"), sep = "[(]") %>%
  separate(col = status1, into = c("state2", "stat2"), sep = "[(]") %>%
  separate(col = status2, into = c("state3", "stat3"), sep = "[(]") 

#create three separate dfs and work within them
df1 <- ne_dataportal_sp_rgns_scores %>%
  select(common, state1, stat) %>%
  mutate(status = str_remove(.$stat, "[)]")) %>%
  separate(state1, into = c("state1", "state2", "state3", "state4", "state5", "state6"), sep = " ") %>%
  select(-stat) %>%
  gather(-common, -status, key = delete, value = state) %>%
  select(-delete) %>%
  mutate(state = str_remove(.$state, ",")) %>%
  filter(!state %in% c("", NA))


df2 <- ne_dataportal_sp_rgns_scores %>%
  select(common, state = state2, stat2) %>%
  mutate(status = str_remove(.$stat2, "[)]")) %>%
  separate(state, into = c("state1", "state2", "state3"), sep = " ") %>%
  select(-stat2) %>%
  gather(-common, -status, key = delete, value = state) %>%
  select(-delete) %>%
  mutate(state = str_remove(.$state, ",")) %>%
  filter(!state %in% c("", NA))


df3 <- ne_dataportal_sp_rgns_scores %>%
  select(common, state = state3, stat3) %>%
  filter(!is.na(state)) %>%
  mutate(status = str_remove(.$stat3, "[)]")) %>%
  select(-stat3) 

full_df <- bind_rows(df1, df2, df3)

#I want to add scientific names using taxize

sci_names <- full_df %>%
  mutate(scientific = taxize::comm2sci(common, db = "itis")) %>%
  unnest(scientific) 

### bring in nature serve data


#list of IUCN species with rangemaps that are found in the OHI Northeast region
ne_spp <- read_csv("data/iucn_spp_in_ne.csv")

#status of each species in the NatureServe database plus region (state/USA/IUCN)
natserv_stat <- read.csv("data/natureserve_spp_status.csv") %>%
  select(-X) %>%
  rename(natserv_status = status)


#natureserve status & scores (no spp info here)
status_scores  <- read_csv("~/github/ne-prep/prep/bio/data/natserv_status_scores.csv") %>% select(-X1)


#Massachusetts dataframe to include both rgn ids for MA
ma <- data.frame(state = c("MA", "MA"),
                 rgn = c(7,8))

t <- ne_spp %>%
  left_join(natserv_stat, by = c("sciname" = "species")) %>%
  mutate(spp_status = 
           case_when(
             is.na(natserv_status) ~ category,
             natserv_status %in% c("DD-Data deficient", "NU", "NNR", "NNA", NA) ~ category,
             TRUE ~ as.character(natserv_status))) 


#join the other species status data to make comparisons. This assigns a score between 0 and 1 for all species using the natureserve/IUCN status and the status from Emily.
x <- t %>%
  left_join(sci_names, by = c("sciname" = "scientific", "state")) %>%
  filter(!is.na(status)) %>%
  left_join(status_scores, by = c("spp_status" = "status")) %>%
  mutate(status_score_from_emily = 
           case_when(
             status == "SC" ~ 0.2,
             status == "T"  ~ 0.4,
             status == "E"  ~ 0.6
           )) 

#return just those species that have higher (more worrisome) statuses 

h <- x %>%
  filter(status_score_from_emily < score) %>%
  select(common.x, sciname, state, natureserve = spp_status, natureserve_score = score, status, status_score = status_score_from_emily)

View(h)



