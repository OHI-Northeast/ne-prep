## Spatial data for OHI Northeast

`create_ne_regions.Rmd` is the script that creates the 10 regions for the Northeast Ocean Health Index

`clean_state_waters.R` cleans the state waters shapefile that was edited in QGIS to remove rivers in Maine. After cleaning in QGIS, orphan holes remained so the cleangeo package here takes care of the orphan holes.

`ma_counties.R` assigns Massachussetts counties to OHI regions. Since MA splits between two biogeographical regions, and a lot of our data will be at the county level, we will have to manually assign the counties to each region. What makes this complicated is that a couple counties are found in both.

`master_rasters.R` creates base rasters for use in the OHI-Northeast data prep.

`ne_coastal_counties.R` script to save northeast coastal counties as a shapefile for use in maps

`simplify_rgns.R` simplifies the OHI NE Regions shapefile for faster plotting

`states_shp.R` makes a shapefile for state borders (on land)

`ocean_rasters` contain rasters

`shapefiles` is a folder where all shapefiles are kept


