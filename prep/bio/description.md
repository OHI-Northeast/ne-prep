# Biodiversity

People value biodiversity in particular for its existence value. The risk of species extinction generates great emotional and moral concern for many people. As such, this goal assesses the conservation status of species based on the best available global data through two sub-goals: species and habitats. Species were assessed because they are what one typically thinks of in relation to biodiversity. Because only a small proportion of marine species worldwide have been mapped and assessed, we also assessed habitats as part of this goal, and considered them a proxy for condition of the broad suite of species that depend on them. For the species sub-goal, we used species risk assessments from both NatureServe and the International Union for Conservation of Nature (IUCN 2016) for a wide range of taxa to provide a geographic snapshot of how total marine biodiversity is faring, even though it is a very small sub-sample of overall species diversity (Mora et al. 2011). For the habitats sub-goal we look to measure the status of key foundational habitats in the region: Salt Marsh, eelgrass, and Seabed Habitats (full list of habitats included below). We calculate each of these subgoals separately and weight them equally when calculating the overall goal score.

## Data Layers

### Habitats

The habitat subgoal measures the average condition of marine habitats present in each region that provide critical habitat for a broad range of species (salt marsh, eelgrass, and seabed habitats). This subgoal is considered a proxy for the condition of the broad suite of marine species that rely on these habitats.

Data availability remains a major challenge for species and habitat assessments. We compiled and analyzed the best available data in both cases, but key gaps remain. Although several efforts have been made in recent years to create or compile the data necessary to look at the status and trends of marine habitats, most efforts are still hampered by limited geographical and temporal sampling (Joppa et al. 2016). In addition, most marine habitats have only been monitored since the late 1970s at the earliest, many sites were only sampled over a short period of time, and very few sites were monitored before the late 1990s so establishing reference points was difficult. eelgrasses were the most data-limited of the habitats included in the analysis.

For **salt marsh** habitats we used NOAA's Coastal Change Analysis Program data (C-CAP) to derive an estimate of salt marsh loss from 1996 through 2010 and a collection of historical loss estimates to estimate the overall loss of salt marsh habitat coverage since ~1880. The NOAA C-CAP data are land cover raster data (.img format) available for the years 1996, 2001, 2006 and 2010 for each state. To measure salt marsh habitats coverage in each of these years we included the following C-CAP land classifications: Estuarine Forested Wetland (16), Estuarine Scrub/Shrub Wetland (17), Estuarine Emergent Wetland (18), Estuarine Aquatic Bed (23). For each time step we remove all land cover cells that are not in those four categories. We then calculated the % gained or lost within each of these classifications in each time step, using a linear interpolation between all time steps. We then incorporate the historical areas lost estimates to represent the full loss of salt marsh habitat since ~1850s.

Data available to measure the extent and condition of **eelgrass** habitats in the Northeast through time is quite limited. As such we developed a model to assess the water quality condition in areas that are home to eelgrass habitats as a proxy for the condition of eelgrasses across the region. To gauge the extent of eelgrass across all Northeast States we first used the spatial Past Eelgrass Surveys data layer from the Northeast Data Portal to identify all locations where eelgrass has been in the past (1980 forwards). We then overlaid this location information with the EPA's National Coastal Condition Assessment Water Quality Index which measures Phosphorus, Nitrogen, Dissolved Oxygen, Water Clarity, and Chlorophyll a for each site monitored by the EPA across the region. The Water Quality Index provides data in categories of "Good", "Fair" and "Poor" for each monitoring site. We assign the following scores to each of these categories: Good = 100, Fair = 50 and Poor = 0. We then intersect the Water Quality Index monitoring sites with the current and past eelgrass beds as identified in the Northeast Data Portal using a 10km buffer to determine the water quality values where eelgrass are present. We only use sites where eelgrass presence data and water quality monitoring sites overlap within our 10km buffer and take the average score based on all overlapping points. 

For **seabed habitats** we utilized the Fishing Effects model developed by the New England Fishery Management Council which measures the impacts placed on seabed habitats from fishing activity as percent disturbance based on a scale of 0 - 1, with a score of 1 representing the most disturbed. These data are available at a 5x5 km grid spatial scale for each month from 1996 - 2017. For our purposes we took the mean percent disturbance across each region and year to measure the status of the seabed habitats included in the model (see table below for all seabed habitats included in the Model). Regions with the least amount of disturbance from fishing scored the highest in this model.
Seabed habitats included in the Fishing Effects Model:

* Amphipods
* Anemones
* Ascidians
* Brachiopods
* Bryozoans
* Corals & sea pens
* Hydroids
* Macroalgae
* Scallops
* Mussels
* Polychaetes
* Sponges
* Sediment
* Biogenic burrows
* Biogenic depressions
* Bedforms
* Gravel
* Shell deposits

### Species

Species range maps were collected from two different sources: the Northeast Data Portal and the The International Union for Conservation of Nature’s (IUCN). When species range maps were available for the same species from both data sources we prioritized the Northeast Data Portal maps as they were developed by regional experts and can thus be assumed to be more accurate for the assessment region. 

Species conservation status data were collected from two different sources: NatureServe and the International Union for Conservation of Nature’s (IUCN). When species status information was available for the same species from both data sources we prioritized the NatureServe assessments as they were developed by regional experts and can thus be assumed to be more accurate for the assessment region. 

## Model

The Biodiversity goal status is calculated as the average of the condition of marine and coastal associated species (Species subgoal) and biodiversity-supporting marine and coastal habitats (Habitats subgoal).

The **Habitats model** is calculated as the average score for each of the three habitat classes assessed: Salt marsh, eelgrass, and seabed habitats.

The **Species model** measures the average threat status, defined by NatureServe state-level threat assessments where available and IUCN Red List threat assessments elsewhere, of all species found in each region. The upper reference point for the Species sub-goal is to have all species at a risk status of Least Concern. As in OHI global assessments, we scale the lower end of the goal to be 0 when 75% of species are extinct, a level comparable to the five documented mass extinctions that would constitute a catastrophic loss of biodiversity.

Threat weights were assigned based on the IUCN threat categories status of each species following the weighting schemes developed by Butchart et al. (2007). For the purposes of this analysis, we included only data for extant species for which sufficient data were available to conduct an assessment. We did not include the Data Deficient classification as assessed species following previously published guidelines for a mid-point approach (Schipper et al. 2008; Hoffmann et al. 2010)


## References

Schipper, Jan, et al. "The status of the world's land and marine mammals: diversity, threat, and knowledge." Science 322.5899 (2008): 225-230.
