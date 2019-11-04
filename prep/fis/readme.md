## Ocean Health Index - US Northeast: Wild-Caught Fisheries

This folder describes the methods used to prepare data for the Wild-Caught Fisheries sub-goal for the US Northeast OHI assessment.

Two data layers are used in this goal. Click on a layer to see data preparation:

### [Catch](https://ohi-northeast.github.io/ne-prep/prep/fis/2_noaa_spatial_fish_catch.html)
- The catch layer is derived from NOAA Landings data.

```
-- `1_prop_catch_food_bait.Rmd`
-- `2_noaa_spatial_fish_catch.Rmd`
```

### [Stock status](https://ohi-northeast.github.io/ne-prep/prep/fis/stock_scores.html)
- This layer is derived from NOAA stock assessment data and the [RAM legacy database](https://www.ramlegacy.org/). This layer is created using three scripts:
```
-- `3_stock_status_noaa.Rmd`
-- `4_stock_status_ram.Rmd`
-- `6_stock_scores.Rmd`
```

The script `5_assessed_species_lookuptable.Rmd` creates two useful datasets that link NOAA/NMFS species with RAM species.

The `data` folder contains derived datasets that are used throughout the Wild-Caught Fisheries workflow.

**Note** 

All data from NOAA, for both catch and stock assessments, was provided via email. While NOAA does maintain an online database for landings, it is presented as an aggregated landings database - to the state level. We used disaggregated landings data that is more spatially explicit.

More information about this goal is available [here](https://github.com/OHI-Northeast/ne-prep/blob/gh-pages/prep/fis/description.md#wild-caught-fisheries).

Please see our [citation policy](http://ohi-science.org/citation-policy/) if you use OHI data or methods.

