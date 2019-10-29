# Clean Waters

People value marine waters that are free of pollution and debris for aesthetic and health reasons. Contamination of waters comes from oil spills, chemicals, eutrophication, algal blooms, disease pathogens (e.g., fecal coliform, viruses, and parasites from sewage outflow), floating trash, and mass kills of organisms due to pollution. People are sensitive to these phenomena occurring in areas they access for recreation or other purposes as well as for simply knowing that clean waters exist. This goal scores highest when contamination from all potential sources is zero.

We include four measures of pollution in the clean waters goal: pathogens, trash, water quality, and sediment quality. This decision was meant to represent a comprehensive list of the contamination categories that are commonly considered in assessments of coastal clean waters (Borja et al. 2008) and for which we could obtain data (see data layers below).

## Data Layers

Human-derived **pathogens** are found in coastal waters primarily from sewage discharge or direct human defecation. This layer is derived from EPA Beach Closure data. We use the number of days a beach is closed per year due to pathogens in the water as a proxy for the impact of pathogens in coastal waters. Data is provided at the beach level and aggregated to the region level. Our reference point is 100 days free of closures, representing the average length of the swimming season for the region.

The status of **trash pollution** was estimated using data from the Coastal Conservancy on pounds of trash collected per person on each International Coastal Cleanup Day every year from 2007 to 2016. The target reference point for this goal is zero pounds of trash collected per person and the limit reference point (maximum possible which would warrant a zero score) was set to reflect the highest trash collected over the same time period across all states on the US East Coast (Maryland with 94.5 pounds of trash per person) plus a 10% buffer, as we do not think that the highest recorded historical level of trash collected necessarily reflects the highest potential trash that could be collected across the region in future years. 

The **water quality** and **sediment quality** layers are derived from the EPA Coastal Condition report which has regional data available for 2010, 2006 and 2001. The Report consists of four indices: Biological Benthic Index, Water Quality Index (Phosphorus, Nitrogen, Dissolved Oxygen, Water Clarity, Chlorophyll a), Sediment Quality Index (contaminants & toxicity), Fish Quality Index. For our water quality layer we use only the Water Quality Index component of the report which measures Phosphorus, Nitrogen, Dissolved Oxygen, Water Clarity, and Chlorophyll a for each monitoring site. For the sediment quality layer we use the Sediment Quality Index component of the report which measures contaminants & toxicity. Both the Water Quality and Sediment Quality indices provide data in categories of "Good", "Fair" and "Poor". We assign the following scores to each of these categories: Good = 100, Fair = 50 and Poor = 0. These scores are then aggregated for each region each year based on EPA-determined weights for contribution to the entire regional score. A separate score is calculated for the water quality and sediment quality layers.

## Model

The Clean Waters goal model assesses the amount of pollution that is present in US Northeast Waters by measure the status of four different components that significantly contribute to the pollution of coastal waters: pathogens, trash, water quality, and sediment quality. The status of this goal is calculated as the geometric mean of the four data layers included.

We used a geometric mean, as is commonly done for water quality indices (Liou et al. 2004), because a very bad score for any one subcomponent would pollute the waters sufficiently to make people feel the waters were ‘too dirty’ to enjoy for recreational or aesthetic purposes (e.g., a large oil spill trumps any other measure of pollution). However, in cases where a subcomponent was zero, we added a value of 0.01 (on a scale of 0 to 1) to prevent the overall score from going to zero. Given that there is uncertainty around our pollution estimates, a zero score resulting from one subcomponent seemed too extreme.

Although clean waters are relevant and important anywhere in the ocean, coastal waters drive this goal both because the problems of pollution are concentrated there and because people predominantly access and care about clean waters in coastal areas. The nearshore area is what people can see and where beach-going, shoreline fishing, and other activities occur. Furthermore, the data for high seas areas is limited and there is little meaningful regulation or governance over the input of pollution into these areas. We therefore calculate this goal only for the first 3 nm of ocean for each country’s EEZ. We chose 3 nm for several reasons, but found the status results to be relatively insensitive to different distances.

## References

Liou, Shiow-Mey, Shang-Lien Lo, and Shan-Hsien Wang. "A generalized water quality index for Taiwan." Environmental Monitoring and Assessment 96.1-3 (2004): 35-52.

Borja, Angel, et al. "Overview of integrative tools and methods in assessing ecological integrity in estuarine and coastal systems worldwide." Marine pollution bulletin 56.9 (2008): 1519-1537.


