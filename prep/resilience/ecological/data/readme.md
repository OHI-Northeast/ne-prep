#Ecological Resilience Data Details
##Juliette Verstaen
## `data` folder directory

******************************************************************
Data created in the `water_pollution.Rmd`

All pieces of this resilience layer come from the raw data from the ECHO database. 

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

******************************************************************

Data created in the `fishing_pressure.Rmd`

Regulation:
`assessment_score.csv` Contains scores for percent of species landed that have stock assessments, by NEOHI Region not over time

`marine_protected_by_rgn.csv` Contains spatial data for areas in all 11 regions that have regulations that will prevent fish biomass extraction. Used USGS data 

Filter out:

A. Location Designations (Loc_Ds)
1. Fishery Management Area
2. Fishery Management Areas
3. Shellfish Management Area
4. Conservation Area
5. Gear Restricted Area
6. Essential Fish Habitat Conservation Area
7. Special Area Management Plan
8. Closure Area")

B. Fishing Restrictions (Fish_Rstr)
1. No Site Restrictions
2. Restrictions Unknown #only keeping areas with recreational or commercial fishing is restricted or prohibited

C. Keep Constancy == Year-round

`protected_score.csv` Scores for protected areas preventing fish biomass. Used a target of 30% protection

`percent_assessed_by_region.csv` Calculates the percent of species that are caught that have stock assessments

`percent_adeq_ass.csv` Calculates species with stocks assessment that are adequately assessed by region (ie: assessed every 5 or less years) 

`fisheries_reg_score` Consolidates scores from `protected_score.csv`, `percent_assessed_by_region.csv`, `percent_adeq_ass.csv` and calculates a fisheries regulation score

Implementation/ Enforcement and Effectiveness/Compliance::

`fish_ob_score.csv` Uses fisheries observer data to calculate enforcement scores by taking the number of actual seadays/ number of allocated seadays

`ole_scores.csv` Uses OLE data to calculate implementation/enforcement and effectiveness/compliance scores. Enforcement uses Number of staff, number of patrols, number of outreach events OLE and compares each year to the maximum value over time. Compliance uses number of investigations/number of enforcement actions OLE and compares each year to the maximum value over time

`fish_res_score.csv` Consolidates scores from regulation, implementation/enforcement, and effectiveness/compliance for one overall fisheries resilience score

******************************************************************











