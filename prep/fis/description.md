# Wild-Caught Fisheries

The aim of this goal is to maximize the sustainable harvest of seafood in regional waters from wild-caught fisheries. Wild caught fisheries harvests must remain below levels that would compromise the resource and its future harvest, but the amount of seafood harvested should be maximized within the bounds of sustainability, i.e., maximum sustainable yield (MSY). In short, regions are rewarded for maximizing the amount of sustainable food provided and penalized for unsustainable practices and/or underharvest. In order to measure progress towards this goal, information about where species are caught (i.e. catch data) and stock assessment data are combined. A region may deliberately underharvest resources for conservation or other purposes, in which case its score for food provision would decrease, but its score for other goals (e.g., biodiversity, sense of place) might increase.

## Data Layers

The **stock status** layer was derived from stock assessment information provided by the National Marine Fisheries Service or RAM Legacy  Stock Assessment Database. The metrics B/Bmsy and F/Fmsy (when available) were used to score each stock between 0 (least sustainable) and 1 (most sustainable).

The **catch** layer was derived from the NOAA Fisheries (NMFS) Commercial Landings data. This data was provided by statistical area for the years 1996-2017. The amount of Atlantic herring, mackerel and skate caught for bait were removed. Catch data is used to weight stock scores by their proportional contribution to regional catch.

## Model

Each harvested species in the region is assigned a sustainability *stock score* between 0 (worst) and 1 (best) according to B/Bmsy and F/Fmsy.

The target is a B/Bmsy between 0.8 and 1.2 and a F/Fmsy between 0.66 and 1.2.


