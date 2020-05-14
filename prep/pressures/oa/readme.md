## Ocean Health Index - US Northeast: Ocean Acidification

This folder describes the methods used to prepare data for ocean acidification data layer that is a part of the climate change pressure layer calculation for the US Northeast OHI assessment. 

#### OA Pressure data comparisons (`oa_pressure_data_comparisons.Rmd`)
- This script compares two data sources. Global modeled OA data from WHOI based on Feely et al. (2009) is the OA data used for the global assessment, and NOAA's East Coast Ocean Acidification Product Suite is another OA data source specifically looking at the Western Atlantic Ocean. Some GIFs were created in this markdown for visual comparison, and are located in the `comparison_GIFs` folder.

The comparison revealed significant differences in the region and thus led us to use the more regionally appropriate ECOAPS data, although this does limit the time series to 2014-2017.

#### [pressure_layer_oa_prep](https://ohi-northeast.github.io/ne-prep/prep/pressures/oa/pressure_layer_oa_prep.html)
- This pressure layer is derived from NOAA's East Coast Ocean Acidification Product Suite data source that we decided to use after doing a data comparison.

#### GIFs
- Aragonite_Concentraion_gif is a visual showing the raw aragonite saturation data over time
- mean_annual_arag_gif is a visual showing the mean aragonite saturation over time
- OA_Pressures_scores.gif is a visual showing the calculated pressure scores over time

