#Ecological Resilience Data Details
##Juliette Verstaen
## `data` folder directory

******************************************************************
Data created in the `water_pollution.Rmd`

All peices of this resilience layer come from the raw data from the ECHO database. 

**ECHO** is a data portal by the EPA that details water discharge facilities activities.

Data URL: https://echo.epa.gov/tools/data-downloads 

`dmr_submissions.csv` and `dmr_gapfill_submissions.csv` 
To create:
(1) Merge all states and years permit activities and actions
(2) Select by EPA Region (CT, ME, MA, RI, NH)
(3) Additional Filtering - selected years 2009 - 2016 (2005-2005 are not reported)
(4) Identified which permits had submitted reports and those that had not
(5) Downloaded as a `dmr_submissions.csv`

For `dmr_gapfill_submissions.csv` the scores from 2009 in each state were used to backfill years 2005-2008

`violations.csv` 
To create:
(1) Merge violations history with facilities list
(2) Select by EPA Region (CT, ME, MA, RI, NH)
(3) Additional Filtering - selected years 2005 - 2016 
(4) Identified which facilities had violations and those that had not
(5) Downloaded as a .csv

`facilities_inspected.csv` 
To create:
(1) Merge inspection history with facilities list
(2) Select by EPA Region (CT, ME, MA, RI, NH)
(3) Additional Filtering - selected years 2005 - 2016 
(4) Identified which facilities been inspected and those that had not
(5) Downloaded as a .csv

`wp_res_metrics.csv` 
All water pollution layers in one file with the their respective targets 

`wp_res_score.csv` 
Water pollution metrics converted into scores based on targets


