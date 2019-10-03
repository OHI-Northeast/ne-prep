`iucn_spp_shp_filepaths.csv` is a subset of the [`spp_marine_maps_2018-1.csv`](https://github.com/oharac/spp_risk_dists/blob/master/_data/spp_marine_maps_2018-1.csv) from Casey O'Hara's spp_risk_dists repo. This subset is filtered in `get_ne_iucn_spp.R` script and is used to identify shapefiles on `git-annex` for species maps for the Northeast

`natureserve_spp_status.csv` lists all species from the IUCN list that have a [NatureServe status](http://explorer.natureserve.org/nsranks.htm), along with state and US specific conservation status. This dataset was created in `4_get_natureserve_data.Rmd`

`iucn_spp_in_ne.csv` was created in `get_ne_iucn_spp.R` and is a list of all IUCN species maps that are in our region. There are additional columns manually added by Emily Shumchenia identifying species that have maps in the Northeast Ocean Data Portal

`cell_id_by_rgn.csv` 