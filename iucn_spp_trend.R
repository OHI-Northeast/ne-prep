#get population trend for all species from IUCN


#load the library that accesses the IUCN API
library(rredlist)

spp_list    <- read_csv("prep/bio/spp/data/1_iucn_spp_in_ne.csv") %>%
      select(common_name, sciname, iucn_sid) %>%
      distinct()

#forloop for each species to grab status and trend

df_iucn <- data.frame()

for(i in 631:nrow(spp_list)){
  
  print(i)
  sp <- as.character(spp_list[i,2]) #grab scientific name
  
  tr <- rl_search(sp)$result$population_trend
  
  if(is.null(tr)){
  
  df2 <- data.frame(sciname = sp,
                    trend = NA)
  }else{
    df2 <- data.frame(sciname = sp,
                      trend = tr)
  }
  
  df_iucn <- rbind(df_iucn, df2)
}


write.csv(df_iucn, file = "prep/bio/spp/data/iucn_population_trends.csv")

