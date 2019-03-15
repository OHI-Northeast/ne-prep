## Ocean Health Index - US Northeast: Wild-Caught Fisheries

This folder describes the methods used to prepare data for the Wild-Caught Fisheries sub-goal for the US Northeast OHI assessment.

Two data layers are used in this goal. Click on a layer to see data preparation:

#### [Stock status](https://ohi-northeast.github.io/ne-prep/prep/fis/stock_scores.html)
- This layer is derived from NOAA stock assessment data and the [RAM legacy database](https://www.ramlegacy.org/). This layer is created using three scripts:
```
-- `stock_status_noaa.Rmd`
-- `stock_status_ram.Rmd`
-- `stock_scores.Rmd`
```

#### [Catch](https://ohi-northeast.github.io/ne-prep/prep/fis/noaa_spatial_fish_catch.html)
- The catch layer is derived from [OAA Landings data.


**Note**
All data from NOAA was provided via email. While NOAA does maintain an online database for landings, it is presented as an aggregated landings database - to the state level. We used disaggregated landings data that is more spatially explicit.


More information about this goal is available [here](http://ohi-science.org/goals/#food-provision).

Please see our [citation policy](http://ohi-science.org/citation-policy/) if you use OHI data or methods.

Thank you!
