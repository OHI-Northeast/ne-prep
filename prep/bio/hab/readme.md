## Ocean Health Index - US Northeast: Habitats sub-goal

This folder describes the methods used to prepare data for the Habitats sub-goal for the US Northeast OHI assessment.

Click on a habitat to see data preparation:

#### [Salt Marsh](https://ohi-northeast.github.io/ne-prep/prep/hab/salt_marsh.html)
- This layer is derived from [NOAA's Coastal Change Analysis Program (C-CAP) data](https://coast.noaa.gov/digitalcoast/data/ccapregional.html).

#### [Eelgrass](https://ohi-northeast.github.io/ne-prep/prep/hab/eelgrass.html)
- Without spatial data on where eelgrass beds are *and* how their health and locations have changed over time, we rely on proxy measures to evaluate the status of eelgrass in the Northeast. We use two indicators from the [EPA's National Coastal Condition Assessment Water Quality Index (WQI) data](https://www.epa.gov/national-aquatic-resource-surveys/ncca), specifically the *Dissolved Inorganic Nitrogen* and *Water Clarity* measurements for 2005/2006 and 2010 time periods. This same data is used in our [Clean Waters goal](https://github.com/OHI-Northeast/ne-prep/tree/gh-pages/prep/cw#ocean-health-index---us-northeast-clean-waters-goal).

#### [Offshore Habitats](https://ohi-northeast.github.io/ne-prep/prep/hab/offshore_habitats.html)
- This layer is derived from SASI v2.0


- `eelgrass.Rmd` uses spatial data from the Northeast Ocean Data Portal that identifies current and historic eelgrass beds in the region to create a single spatial dataset that is then used in `eelgrass_layer.Rmd`


Please see our [citation policy](http://ohi-science.org/citation-policy/) if you use OHI data or methods.

