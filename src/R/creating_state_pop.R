# Script creating the data for the population totals in each state from the 2010 US Census. MA is not split into two because we do not have a way of determining how to split the whole inland state in two.

library(dplyr)

rgn_data_merge <- rgn_data %>% 
  select(-state, -area_km2)
  
  
state_pop <- read_csv(file.path(dir_anx, "_raw_data/US_Census/nst-est2018-alldata.csv")) %>% 
  select(NAME, CENSUS2010POP) %>% 
  filter(NAME %in% c("Maine", "Connecticut", "New York", "Rhode Island", "New Hampshire", "Massachusetts")) %>% 
  rename(state_name = NAME) %>% 
  rename(pop_total = CENSUS2010POP) %>% 
  left_join(rgn_data_merge, by = c("state_name"))
  
write.csv(state_pop, file = "src/tables/state_pop.csv")
