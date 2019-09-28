#Water Pollution Resilience Data Details
##Juliette Verstaen
## `data` folder directory

******************************************************************
All pieces of this resilience layer come from the raw data from the ECHO database. 

**ECHO** is a data portal by the EPA that details water discharge facilities activities.

Data URL: https://echo.epa.gov/tools/data-downloads 

`facilities_violations.csv` 
To create:
1. Merge violations history with facilities list
2. Select by EPA Region (CT, ME, MA, RI, NH)
3. Additional Filtering - selected years 2005 - 2017 
4. Identified which facilities had violations and those that had not
5. Downloaded as a .csv


******************************************************************
`facilities_inspected.csv` 
To create:
1. Merge inspection history with facilities list
2. Select by EPA Region (CT, ME, MA, RI, NH)
3. Additional Filtering - selected years 2005 - 2017 
4. Identified which facilities been inspected and those that had not
5. Downloaded as a .csv


******************************************************************
`reports_submitted.csv` 
To create:
1. Merge inspection history with facilities list
2. Select by EPA Region (CT, ME, MA, RI, NH)
3. Additional Filtering - selected years 2005 - 2017 
4. Count how many facilities have RNC_DETECTION_CODE=N  (N = Non-Receipt of DMR/Schedule Report)
5. Calculate the percentage of facilities with an N code and divide by total
6. Downloaded as a .csv

