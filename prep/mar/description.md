# Aquaculture

Aquaculture is one of two sub-goals of the Food Provision Goal. The aim of this sub-goal is to maximize the sustainable production of farmed seafood. Higher scores reflect significant growth of food provisioning of farmed species in a sustainable manner. With limited information about regional targets for aquaculture production in the Northeast, an annual production growth rate of 4% is used. Information on sustainability of farmed species is used to weight production in a manner where less sustainable species (i.e. Atlantic salmon) contribute less to the overall production score than more sustainable species (i.e. oysters).

## Data Layers

The species **production** layer was compiled by hand from many different sources and required conversion to a single unit, pounds. Requirements for reporting vary state by state, and confidentiality clauses can limit the amount of available data. This layer is a results of best efforts to piece together production information from publically available sources.

**Primary data sources by state**
Maine: [Maine Department of Marine Resources Aquaculture Harvest Data](https://www.maine.gov/dmr/aquaculture/harvestdata/index.html)
*Note: Maine does not provide Atlantic salmon production data beyond 2010 due to confidentiality but it is clear that production has been occurring since 2010*
Rhode Island: Coastal Resources Management Council [annual status reports](http://www.crmc.ri.gov/aquaculture.html) on Aquaculture in Rhode Island
Connecticut: Department of Agriculture [Oyster and Clarm Market Harvest Data](https://portal.ct.gov/DOAG/Aquaculture1/Aquaculture/Oyster-and-Clam-Market-Harvest-Data)
Massachusetts: Department of Fish & Game Marine Fisheries Annual Reports
New York: Long Island Sound Study [production data](http://longislandsoundstudy.net/ecosystem-target-indicators/shellfish-harvested/)
New Hampshire: NH Fish and Game - direct correspondance and [biennial reports](https://wildlife.state.nh.us/about/biennial-reports.html).

![](https://github.com/OHI-Northeast/ne-prep/blob/gh-pages/prep/mar/figs/prod_by_species-1.png)

The production data layer required gapfilling for missing years. Black dots in the following plot indicate years where data was available for that species.

![](https://github.com/OHI-Northeast/ne-prep/blob/gh-pages/prep/mar/figs/missing_years-1.png)

Data was gapfilled either using a linear model, or carrying the first or last value forward. To confirm whether or not production of each species existed previous to available data, or is still happening as in teh case of Maine salmon, we talked with experts in each state familiar with the industry.

**Gapfilled roduction data**

![](https://github.com/OHI-Northeast/ne-prep/blob/gh-pages/prep/mar/figs/gapfilled_production-1.png)

The **sustainability** layer is derived from the Monterey Bay Aquarium Seafood Watch sustainable scores. Seafood Watch scores the sustainability of farmed species on a 0-10 scale based on [10 criteria](https://www.seafoodwatch.org/-/m/sfw/pdf/criteria/aquaculture/mba_seafood%20watch_aquaculture%20standard_version%20a2.pdf?la=en). These scores are used to weight aquaculture production.

|Species|Seafood Watch Score|
|---|---|
|Hard Clam|8.39|
|Soft Shell Clam|7|
|Blue Mussel|8.11|
|Oysters|7.98|
|Scallops|8.86|
|Atlantic Salmon|4.82|
|Trout|4.82|

---

## Model

Production data at the species level is multiplied by the species sustainability score which is on a 0 (least sustainable) to 1 (most sustainable) scale. The weighted production data is aggregated by region and compared to last years production. If annual production has increased by at least 4% compared to last years, the region scores 100. 


