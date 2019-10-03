# status scores
#
# This script takes the status or rank values assigned to species by NatureServe or IUCN and gives them the appropriate score

natserv_stat <- read.csv("prep/bio/data/natureserve_spp_status.csv") %>%
  select(-X)


#get unique status values

vals <- unique(natserv_stat$status)

#create lookup table that links each unique status to a score. This link shows the different status values from natureserve: http://explorer.natureserve.org/nsranks.htm. We use this 2014 paper that crosswalks ESA, IUCN and NatureServe Conservation Assessment (CSA) rankings

tab <- data.frame(status = vals) %>%
        mutate(score = 
                 case_when(
                   status %in% c("LC - Least concern", "N5", "N5B,N4N", "S5", "S5N", "N5N", "N5B", "N5B,N5N", "N4N,N5B", "S5B,S5N", "S5B", "S4N,S5B", "S3N,S5B") ~ 0,
                   status %in% c("S4S5N", "S4S5B", "N4N5", "S4S5B,S4S5N", "N4N5B,N4N", "S4N,S4S5B") ~ 0.1,
                   status %in% c("NT - Near threatened", "S4N", "S4B", "S4B,S5N", "S4", "N4", "S4B,S4N", "N4B", "N4B,N4N", "N4B,N5N", "S4B,S5M") ~ 0.2,
                   status %in% c("S3S4", "N3N4N", "S3S4N", "S3S4B", "N3N4", "S3S4B,S5N") ~ 0.3,
                   status %in% c("VU - Vulnerable", "S3", "N3B", "N3", "S3B,S3N", "S3B,S3S4N", "S3?B", "N2N,N3B", "S3B,S1N", "S3N", "N3N", "N3?B", "S3B", "S3B,S4N", "S3B,S5N", "S3B,SNRN", "S3,SNRN") ~ 0.4,
                   status %in% c("S2S3B", "N2N3N", "S2S3", "S2S3N", "S2S3B,SNRN", "S2S3B,S2N", "N2N3B,N3N") ~ 0.5,
                   status %in% c("EN - Endangered", "S2?B", "S2B", "S2B,S3N", "S2", "S2B,S2N", "S2N", "N2", "N2B", "S1S2N,S2B", "S2B,S5M", "S2B,S4N", "S1S3N", "S2B,S5N", "N1N3") ~ 0.6,
                   status %in% c("S1S2N", "S1S2B", "N1N2B,N2N3N", "S1S2B,S3N") ~ 0.7, 
                   status %in% c("CR - Critically endangered", "N1B", "S1", "N1N", "S1B,S4M",  "N1", "S1B,S1N", "S1B,S5M", "S1B,S3?N", "S1B,S1S2N", "S1B", "S1?N", "S1N", "S1B,S3N", "S1B,S2N", "S1B,S5N", "S1B,S3S4N", "N1B,N3N", "N1B,N4N", "S1B,S4N", "S1?B,S3N") ~ 0.8,
                   status %in% c("EX - Extinct", "SH", "SX", "NX", "SHB", "SXN", "NXN", "SXB, S1N", "SHB,S1N", "SXB,S2N", "SXB,S3S4N", "SXB,S1N", "SXB,S3N") ~ 1
                 ))

#combine with a simple IUCN one (without the long names)

iucn <- data.frame(status = c("LC", "NT", "VU", "EN", "CR", "EX", "DD"),
                   score  = c(0, 0.2, 0.4, 0.5, 0.8, 1, NA))

out <- bind_rows(tab, iucn)

## it seems that whenever there are different assessments for different segments of the population we use the breeding population as the score. For example, "S1B,S3N" means the (B)reeding population is Critically endangered, but the (N)on-breeding population is Vulnerable. So in this case we assign 0.8 for the Breeding population preference. But in cases where we just don't know like "S2S3N" (which indicates unsure of what rank the Non breeding population is), we average those scores so this would get 0.5 (average of 0.6 for S2 and 0.4 for S3)

write.csv(out, file = "prep/bio/data/natserv_status_scores.csv")
