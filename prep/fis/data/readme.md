## `data` folder directory

`fish_catch_food_prop_rgn.csv` and `fish_catch_food_prop_by_state.csv` are created in `1_prop_catch_food_bait.Rmd`.
- `fish_catch_food_prop_rgn.csv` is for the entire OHI region (does not split out by sub-regions or states)
- `fish_catch_food_prop_by_state.csv` splits out proportion of catch destined for food or non-food uses by state

`nmfs_spatial_catch_by_ohi_rgn.csv` created in `2_noaa_spatial_fish_catch.Rmd`
- contains species catch by OHI region over time
- this file is used in fis_species_lookuptable.Rmd to create the species lookup table

`nmfs_stock_assessment_data.csv` created in `3_stock_status_noaa.Rmd`
- all stocks in the Northeast and Midatlantic that have B/Bmsy and F/Fmsy metrics

`nmfs_stock_scores.csv` created in `3_stock_status_noaa.Rmd`
- stock scores (0 to 1) for each assessed stock, including B/Bmsy and F/Fmsy

`ram_stock_assessment_data.csv` created in `4_stock_status_ram.Rmd`
- stock assessment data for the 14 stocks in the RAM database that are in our region but aren't managed by NOAA so not in the NOAA stock assessment data

`ram_stock_scores.csv`
- stock scores (between 0 and 1) for the RAM stocks

`assessed_species_lookup_table.csv` created in `5_assessed_species_lookuptable.Rmd`
- this table lists all assessed species that are reported in the NOAA catch data. There is a source column that identifies where the stock assessment information comes from, either NOAA/NMFS or RAM.

`all_species_caught_assessment_summary.csv` created in `5_assessed_species_lookuptable.Rmd`
- this table lists all species caught in the Northeast, and their assessment status (yes = assessed)

`nmfs_lobster_state_landings.csv` was downloaded from the [NMFS Commercial Landings website](https://foss.nmfs.noaa.gov/apexfoss/f?p=215:200:15792138817166::NO:::) on Deceber 9, 2017. These data are landings for commercially caught American Lobster from 2000 to 2017. These will be used to replace the lobster catch data by statistical area. After doing comparisons of the landings by stat area data for lobster with the landings reported in the 2015 stock assessment, it's clear that a lot of landings are done in state waters and somehow not captured in the statistical area data. 