# Wild-Caught Fisheries

The aim of this goal is to maximize the sustainable harvest of seafood in regional waters from wild-caught fisheries. Wild caught fisheries harvests must remain below levels that would compromise the resource and its future harvest, but the amount of seafood harvested should be maximized within the bounds of sustainability, i.e., maximum sustainable yield (MSY). In short, regions are rewarded for maximizing the amount of sustainable food provided and penalized for unsustainable practices and/or underharvest. In order to measure progress towards this goal, information about where species are caught (i.e. catch data) and stock assessment data are combined. A region may deliberately underharvest resources for conservation or other purposes, in which case its score for food provision would decrease, but its score for other goals (e.g., biodiversity, sense of place) might increase.

## Data Layers

The **stock status** layer was derived from stock assessment information provided by the National Marine Fisheries Service or RAM Legacy  Stock Assessment Database. The metrics B/Bmsy and F/Fmsy (when available) were used to score each stock between 0 (least sustainable) and 1 (most sustainable).

The **catch** layer was derived from the NOAA Fisheries (NMFS) Commercial Landings data. This data was provided by statistical area for the years 1996-2017. The amount of Atlantic herring, mackerel and skate caught for bait were removed. Catch data is used to weight stock scores by their proportional contribution to regional catch.

## Model

### Spatial allocation of catch to regions

A total of 154 species are reported to be caught within the Northeast region between 1996 and 2017. This includes names such as "CONFIDENTIAL SPECIES", "OTHER INVERTEBRATES", and "CLAM, SPECIES NOT SPECIFIED". Importantly, only catch for species that have stock assessment information are included in the Wild-Caught Fisheries score. Data on where species were caught were shared by statistical area. 

![](https://github.com/OHI-Northeast/ne-prep/blob/gh-pages/prep/fis/figs/statistical_areas-1.png)

In order to aggregate species catch to the 11 Ocean Health Index Northeast regions, statistical areas were intersected with the OHI regions, and the amount of catch in each statistical area was assigned to the OHI region according to the proportional area of overlap.

![](https://github.com/OHI-Northeast/ne-prep/blob/gh-pages/prep/fis/figs/ohi_stat_areas-1.png)

For example, statistcal area 522 is 55% in the George's Bank region, and 45% in the Gulf of Maine. All catch reported in area 522 is split according to the 55%/45% proportion between the George's Bank and Gulf of Maine OHI regions.

After aggregating to OHI regions, a three-year rolling mean of species catch was calculated to account for any significant year-to-year variability that may not be indicative of the average annual catch. 

![](https://github.com/OHI-Northeast/ne-prep/blob/gh-pages/prep/fis/figs/total_catch_by_ohi_region-1.png)

The significant decrease seen around 2009 is due to a large drop in Atlantic herring catch meant for human consumption. 

----

### Removing catch from bait fisheries

Bait fisheries are an important industry in the Northeast and make up a significant portion of total catch in the region, especially Atlantic herring. Since the Wild-Caught Fisheries sub-goal is meant to measure how well sustainable seafood is being provided for human consumption, all catch meant for non-human consumption (e.g. bait, pet food) is removed. Catch data by market was provided via data request from the National Marine Fisheries Service.

![](https://github.com/OHI-Northeast/ne-prep/blob/gh-pages/prep/fis/figs/tot_catch_as_bait-1.png)

----

### Stock status

Stock assessment information was provided for 50 individual stocks via data request from the National Marine Fisheries Service for all stocks in the greater Northeast region. Specifically, the metrics B/Bmsy and F/Fmsy (when available) were provided.

![](https://github.com/OHI-Northeast/ne-prep/blob/gh-pages/prep/fis/figs/stock_assesment_span_plot-1.png)

Additional stock assessment information for species not in the NMFS stock assessment database were available in the RAM Legacy Stock Assessment database. Many of these are highly migratory species, but this list also includes American lobster and striped bass.

![](https://github.com/OHI-Northeast/ne-prep/blob/gh-pages/prep/fis/figs/ram_span_plot-1.png)

#### Gapfilling

Stock assessments are not performed every year for every managed stock in a region. This necessitates some gapfilling for years where information is not provided. A simple linear model was used to gapfill B/Bmsy and F/Fmsy values for years where they are missing.

![](https://github.com/OHI-Northeast/ne-prep/blob/gh-pages/prep/fis/figs/nmfs_stock_assessment_indicators_over_time_by_stock-1.png)
![](https://github.com/OHI-Northeast/ne-prep/blob/gh-pages/prep/fis/figs/ram_metrics_over_time-1.png)

#### Stock scores

After gapfilling time series of stock assessment metrics, each stock is assigned a score from 0 (least sustainable) to 1 (most sustainable).

**Rescaling B/B<sub>MSY</sub>**  
Rescaled biomass score B' for each stock is calculated based on B/B<sub>MSY</sub>, with a score of 1 indicating B/B<sub>MSY</sub> between 0.8 and 1.2, decreasing to 0 as B/B<sub>MSY</sub> approaches 0 (overfished), with an increasing penalty for B/B<sub>MSY</sub> above 1.2 (underfished), with a minimum underfished score of 0.25 for B/B<sub>MSY</sub> ≥ 3.0.

**Rescaling F/F<sub>MSY</sub>**  
Rescaled fishing mortality F' for each stock is calculated based on F/F<sub>MSY</sub>, smoothed using a rolling three-year mean. A rolling-mean is only applied to F' because B is a less sensitive metric since it relies on biological processes. F' can fluctuate significantly in a short amount of time in response to a management decision. F' depends on B/B<sub>MSY</sub>. If a stock is overfished (B/B<sub>MSY</sub> < 0.8) but F/F<sub>MSY</sub> is reduced to account for rebuilding, this can result in a stock score of 1.

F' is equal to 0 when B/B<sub>MSY</sub> is below a threshold of 0.5, and increases to 1 as F/F<sub>MSY</sub>Y = 1 for B/B<sub>MSY</sub> ≥ 0.8. Our calculation allows a buffer around this to account for uncertainty in setting annual management targets, and incorporates an overfishing penalty (F' = 0 for F/F<sub>MSY</sub> ≥2) as well as an underfishing penalty to account for lost opportunity for additional sustainable catch.

When both B/B<sub>MSY</sub> and F/F<sub>MSY</sub> are available, the final Stock Score (SS) is equal to the product of F' and B'. If only B/B<sub>MSY</sub> is available, the Stock Score is equal to B'.

Here is an example of how B/B<sub>MSY</sub> and F/F<sub>MSY</sub> values are turned into stock scores between 0 and 1 for a few regional stocks.

![](https://github.com/OHI-Northeast/ne-prep/blob/gh-pages/prep/fis/figs/unnamed-chunk-4-7.png)

--- 

## Turning stock scores into OHI scores

The proportional catch within each region is used to weight the contribution of stock scores to the final score. For example, if 80% of a region's catch is lobster (which has a stock score of 0.73), and 20% is White hake (stock score of 0.86), the final score will be (0.8 x 0.73) + (.2 x 0.86) = 0.756. Since scores are translated to a 0-100 scale, this region would get a score of 75.6 for Wild-Caught Fisheries.






