## Ocean Health Index - US Northeast: Livelihoods sub-goal

This folder contains scripts that prepare data layers used in the Livelihoods sub-goal (one half of the Livelihoods & Economies goal).

More information about this goal is available [here](http://ohi-science.org/goals/#livelihoods-and-economies).

There are three scripts in this folder:  
1. `clean_noep_data.Rmd` cleans the raw data from the [National Ocean Economics Program](http://www.oceaneconomics.org/)  
2. `jobs.Rmd` creates the jobs layer from the cleaned NOEP data  
3. `wages.Rmd` creates the wages layer from the cleaned NOEP data

The `data` folder holds the cleaned up NOEP data (`clean_noep_data.csv`).

The `int` folder holds intermediate data for jobs and wages that may be useful to examine how the layers are created. These are mainly saved here for possible use in the dashboard.

### [Jobs data prep](https://ohi-northeast.github.io/ne-prep/prep/liv/jobs.html)    
### [Wages data prep](https://ohi-northeast.github.io/ne-prep/prep/liv/wages.html)

Please see our [citation policy](http://ohi-science.org/citation-policy/) if you use OHI data or methods.

Thank you!
