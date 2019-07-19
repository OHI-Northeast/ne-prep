# Assigning Massachussetts counties to OHI regions

# Since MA splits between two biogeographical regions, and a lot of our data will be at the county level, we will have to manually assign the counties to each region.
# What makes this complicated is that a couple counties are found in both.

ma_cntys <- c('Barnstable','Barnstable','Bristol','Nantucket','Dukes','Plymouth','Plymouth','Norfolk','Essex','Suffolk')

df <- data.frame(County = ma_cntys,
                 rgn_name = c('Massachusetts-North',
                              'Massachusetts-South',
                              'Massachusetts-South',
                              'Massachusetts-South',
                              'Massachusetts-South',
                              'Massachusetts-South',
                              'Massachusetts-North',
                              'Massachusetts-North',
                              'Massachusetts-North',
                              'Massachusetts-North'
                              ),
                 rgn_id = c(7,8,8,8,8,8,7,7,7,7))

write.csv(df,file = '~/github/ne-prep/src/tables/MA_counties.csv')
