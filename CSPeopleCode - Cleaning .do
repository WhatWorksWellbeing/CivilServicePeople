********************************************************************************************************************************
**************************************** Civil Service People Survey - Welleing over time **************************************
************************************************ Michael Sanders ***************************************************
******************************************** What Works Centre for Wellbeing ***************************************************
********************************************************************************************************************************

********************************************************************************************************************************
**Version 1.0
**Importing each year's data - 2014-2021
**This data also standardises organisational identifiers across time periods, and standardises wellbeing variable denominations, and truncate wellbeing variable names
**First step - insheet each year's data (from 2014-2021)

**Set working directory:
cd 

**2021 data**
**Import
import excel "Civil_Service_People_Survey__2009_2021_Benchmarks.xlsx", sheet("Table_3") firstrow clear
**Generate an indicator for year
gen period =2021
**Rename organisation identifier variables to make consistent across years.
tab Organisation
ren Organisation Organisationcode
ren Organisationname Organisation
**Truncate variable name and standardise values of wellbeing data.
local var W01 W02 W03 W04
foreach x of local var{
ren `x' `x'
replace `x' = `x'/100
}
**Save
save "CSP2021.dta", replace


**2020 Data**
**Import
import excel "Civil_Service_People_Survey_2020-_All_organisation_scores.xlsx", sheet("Table_2") firstrow clear
**Generate an indicator for year
gen period=2020
tab Organisationcode
**Standardise values of wellbeing data.

codebook W01 W02 W03 W04
foreach x of  varlist B01-E03{
di "`x'"
replace `x'  = `x'*100
}
**Save
save "CSP2020.dta", replace

**2019 Data**
**Import
import delimited "Civil-Service-People-Survey-2019-All-Organisation-Scores-CSV-format.csv", varnames(1) case(preserve) clear 
**Generate an indicator for year
gen period = 2019
**Truncate variable values for destringing and standardise values of wellbeing data.
foreach x of varlist W01-W04{
replace `x' = substr(`x',1,2)
destring `x', replace
replace `x' =`x'/100
}
**Remove % sign from values.
foreach x of  varlist ResponseRate-E03{
di "`x'"
replace `x'  = substr(`x', 1, strpos(`x',"%")-1)
destring `x', replace
}
codebook W01 W02 W03 W04
**Save
save "CSP2019.dta", replace

**2018 Data**
**Import
import delimited "Civil-Service-People-Survey-2018-All-Organisation-Scores-v2.0.csv", varnames(1) case(preserve) clear 
**Generate an indicator for year
gen period = 2018
**Truncate variable values for destringing and standardise values of wellbeing data
foreach x of varlist W01-W04{
replace `x' = substr(`x',1,2)
destring `x', replace
replace `x' =`x'/100
}
**Remove % sign from values.

foreach x of  varlist Responserate-E03{
di "`x'"
replace `x'  = substr(`x', 1, strpos(`x',"%")-1)
destring `x', replace
}
**Include PERMA and Proxy Stress index in this year. Truncate value to allow for destsringing
replace PERMA  = substr(PERMA, 1, strpos(PERMA,"%")-1)
destring PERMA, replace
replace ProxyStressIndex  = substr(ProxyStressIndex, 1, strpos(ProxyStressIndex,"%")-1)
destring ProxyStressIndex, replace
codebook W01 W02 W03 W04
ren Organisation_Code Organisationcode
**Save
save "CSP2018.dta", replace

**2017 Data**
**Import
import delimited "Civil_Service_People_Survey_2017_All_Organisation_Scores__CSV_.csv", varnames(1) case(preserve) clear 

**Generate an indicator for year
gen period = 2017
**Truncate values of wellbeing variables and destring
foreach x of varlist W01-W04{
replace `x' = substr(`x',1,2)
destring `x', replace
replace `x' =`x'/100

}
**Truncate values for other variables and destring
foreach x of  varlist Responserate-E03{
di "`x'"
replace `x'  = substr(`x', 1, strpos(`x',"%")-1)
destring `x', replace
}
codebook W01 W02 W03 W04
**Rename organisational identifier to facilitate later merging
ren Organisation_Code Organisationcode
**Save
save "CSP2017.dta", replace

**2016 Data**
**Import
import delimited "civil_service_peoples_survey_2016_all_org_scores.csv", varnames(1) case(preserve) clear 
**Generate an Indicator for year
gen period = 2016
**Truncate and destring wellbeing variables
foreach x of varlist W01-W04{
replace `x' = substr(`x',1,2)
destring `x', replace
replace `x' =`x'/100

}
**Truncate and destring other variables**
foreach x of  varlist Response_rate-E03{
di "`x'"
replace `x'  = substr(`x', 1, strpos(`x',"%")-1)
destring `x', replace
}
**For other variables, reduce length by renaming in loops
foreach x of numlist 1/9{
  ren B0`x' B0`x' 
  }

foreach x of numlist 11/61{
  ren B`x' B`x'
  }

  foreach x of numlist 1/3{
  ren D0`x' D0`x'
  }
  foreach x of numlist 1 3{
  ren E0`x' E0`x'
  }

codebook W01 W02 W03 W04
**Rename organisational identifier to facilitate later merging
ren Organisation_Code Organisationcode
**Save
save "CSP2016.dta", replace

**2015 Data**
**Import
import delimited "csps2015_allorganisations_csv.csv", varnames(1) case(preserve) clear 
**Generate an indicator for year
gen period = 2015
**Rename wellbeing variables for consistency
ren W01 W01 
ren W02 W02
ren W03 W03
ren W04 W04
**Truncate values of wellbeing variables and destring
foreach x of varlist W01-W04{
replace `x' = substr(`x',1,2)
destring `x', replace
replace `x' =`x'/100

}
**Truncate other variables and destring
local vars 
foreach x of  varlist Responserate-E03Duringthepast12monthshaveyoup{
di "`x'"
replace `x'  = substr(`x', 1, strpos(`x',"%")-1)
destring `x', replace
}
**Rename other variables to make them shorter in a loop
foreach x of numlist 1/9{
  ren B0`x' B0`x' 
  }

foreach x of numlist 11/61{
  ren B`x' B`x'
  }

  foreach x of numlist 1/3{
  ren D0`x' D0`x'
  }
  foreach x of numlist 1 3{
  ren E0`x' E0`x'
  }

codebook W01 W02 W03 W04
**Save
save "CSP2015.dta", replace

**2014 Data**
**Import
import delimited "csps2014_allorganisations_20141120.csv", varnames(1) case(preserve) clear 
**Generate an indicator for year
gen period = 2014
**Rename wellbeing variables for consistency
ren W01 W01 
ren W02 W02
ren W03 W03
ren W04 W04
**Truncate values of wellbeing variables and destring
foreach x of varlist W01-W04{
replace `x' = substr(`x',1,2)
destring `x', replace
replace `x' =`x'/100

}
**Truncate values and destring other variables
foreach x of  varlist Responserate-E03Duringthepast12monthshaveyoup{
di "`x'"
replace `x'  = substr(`x', 1, strpos(`x',"%")-1)
destring `x', replace
}
**Rename other variables 
foreach x of numlist 1/9{
  ren B0`x' B0`x' 
  }

foreach x of numlist 11/61{
  ren B`x' B`x'
  }

  foreach x of numlist 1/3{
  ren D0`x' D0`x'
  }
  foreach x of numlist 1 3{
  ren E0`x' E0`x'
  }

codebook W01 W02 W03 W04
**Save
save "CSP2014.dta", replace


**Appending
**This code creates one dataset with all years 2014-2021 together, through appending each dataset in turn 
**Append all periods data together
clear
foreach x of numlist 14/21{
di `x'
**Note that I am forcing here because there are a handful of fiddly variables in 2019/2020 which are byte/str3. I am not planning to use any of those variables.
append using "CSP20`x'.dta", force
}
**Drop observations which relate to the whole civil service and not just a single department 
drop if Organisationcode=="CS_MEDIAN"
drop if Organisationcode=="CS_MEAN"
**Show me which periods I've got where wellbeing data is not missing (should be all)
tab period if W01!=.


**Regression Analysis**
**We now do basic regression analysis to look at whether there is a relationship between wellbeing in time. We also include 2020 and 2021 as binary indicators (rather than trends) due to the pandemic
**Generate binary period indicatoes for 2021 and 2020
gen t21 = period==2021
gen t20 = period==2020
**Create a trendline starting at 1 for ease of interpretation
gen trend = period-2013
**Run regressions in a loop, regression each of the ONS4 wellbeing questions on the trendline and the 2020 + 2021 dummmies. Using Huber-White Standard Errors
foreach x of varlist W01-W04{
di `x'
reg `x' trend t21 t20, robust
}

**Produce Graphs**
**Here we create graphs showing the change in wellbeing over time in the data, fo reach of the four measures
**Preserve temporarily stores our dataset so that we can go back to it later.
preserve
**Collapse so that the data only shows the mean of each wellbeing question for each year.
collapse W01 W02 W03 W04, by(period)
**Draws connected graphs on a loop with axis labels.
foreach x of varlist W01-W04{
twoway (connected `x' period), xtitle(Year) ytitle("Proportion high `x' score") graphregion(color(white)) 
**Save each graph
graph export "`x'time.png", replace
}
**We return to the version of the dataset we saved on line 287.
restore

**Now we check for duplicates of organisation within period.
egen org = group(Organisation)
bysort org period: gen dups = _N
tab dups
**Yields one triplicate observation and a bunch of missings. Drop without loss of generality.**
drop if dups>1
**Set panel data to allow us to calculate lags. Organisation is the cross-sectional unit and year is the temporal unit. 
xtset org period
tab period
**Create first differences, second differences, and third differences for all of our Wellbeing variables.** 
**L. when data are set up as a panel takes the first lag of a variable. L2. takes the second, and so on.  F. takes the future values of that variable.
foreach x of varlist W01-W04{
gen fd`x' = `x'-L.`x'
gen sd`x' = L.`x'-L2.`x'
gen td`x' = L2.`x'-L3.`x'
}
**Kernel density plots of the changes over the 2019-2020 period for each variable 
foreach x of varlist W01-W04{
kdensity fd`x' if period==2020, xtitle("First difference `x'") ytitle("Density") graphregion(color(white))
**Save Kernel Density Plots
graph export "fd`x'.png", replace
}
**Kernel density plots of the changes over the 2019-2020 period fr each variable 
foreach x of varlist W01-W04{
kdensity fd`x' if period==2021, xtitle("First difference `x'") ytitle("Density") graphregion(color(white))
**Save density plots set 2
graph export "Recoveryfd`x'.png", replace
}
**Here we create a binary indicator of whether trends all wellbeing variables are positive or negative in a particular year.
**Binary indicators of positivity and negativity.
gen allpositive = fdW01>0 & fdW02>0 & fdW03>0 & fdW04<0
**Identify any departments with positive wellbeing growth in 2019-2020 (COVID Effects)**
tab Organisation if allpositive ==1 & period==2020
**Identify departments with positive covid recovery on all measures in 2020-2021**
tab Organisation if allpositive ==1 & period==2021
gen allnegative = fdW01<0 & fdW02<0 & fdW03<0
**Identify organisations where everything has gotten worse over 2019-2020 and 2020-2021
tab Organisation if allnegative==1 & period==2020
**COVID recovery allbad 
tab Organisation if allnegative==1 & period==2021

**Display changes over time for all variables
**2020 changes**
foreach x of varlist W01-W04{
di 2020
di `x'
summ fd`x' if period==2020, det
}
**2021 changes**
foreach x of varlist W01-W04{
di 2021
di `x'
summ fd`x' if period==2021, det
}

**2021 two year changes**
foreach x of varlist W01-W04{
di 2021
di `x'
summ sd`x' if period==2021, det
}
**Based on the summaries produced above, get Stata to display the best and worst performing departments on a number of measures.
**lookup lists of LAs*
tab Organisation fdW01 if period==2020 & fdW01>=-0.03
tab Organisation fdW01 if period==2020 & fdW01>-0.03
tab Organisation  if period==2020 & fdW01>-0.03
tab Organisation fdW02 if period==2020 & fdW02>-0.01
tab Organisation  if period==2020 & fdW02>-0.01
tab Organisation fdW03 if period==2020 & fdW03>-0.00
tab Organisation  if period==2020 & fdW03>-0.00
tab Organisation fdW04 if period==2020 & fdW04<0.05
tab Organisation  if period==2020 & fdW04<0.05
tab Organisation fdW01 if period==2021 & fdW01>0.10
tab Organisation fdW02 if period==2021 & fdW02>0.06
tab Organisation fdW03 if period==2021 & fdW03>0.085
tab Organisation  if period==2021 & fdW03>0.085
tab Organisation fdW04 if period==2021 & fdW04<=-0.199
tab Organisation sdW01 if period==2021 & sdW01>=0.03
tab Organisation sdW01 if period==2021 & sdW01>=-0.03
tab Organisation sdW02 if period==2021 & sdW02>=-0.01
tab Organisation sdW03 if period==2021 & sdW03>=0.0
tab Organisation sdW04 if period==2021 & sdW04<=0.05

**Do File Ends here.
