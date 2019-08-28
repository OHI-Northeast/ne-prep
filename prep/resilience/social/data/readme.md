#data details
##Juliette Verstaen


`bhi_scores.csv`

Data URL: http://beaconhill.org/economic-competitiveness/

**Beacon Hill Annual State Competitiveness Report** This report has been published since 2001. Compiles state business climate indices: 

(1) fiscal policy
(2) security
(3) infrastructure
(4) human resources
(5) technology
(6) biz incub.
(7) openness
(8) environment

`oi_score.csv` Calculates the resilience scores from the opportunity index scorecards

`county_missing.csv` A csv file with the communites from the NOAA vulnerabiltiy indices that don't match up with a county name. The missing county information was then filled in manually by searching community locations

`svi_overall` Calculates the resilience scores based off of the NOAA social vulnerability index for each of the regions of interest

`lcv_scores` Uses the League of Conservation Voters Scorecard on each memeber of congress to calcualte a resilience score for each of the regions of interests

`social_resilience_scores` Consolidates `bhi_scores.csv` `oi_score.csv` `svi_overall` and `lcv_scores` and calucated one social resilience score with each peice weighted equally









