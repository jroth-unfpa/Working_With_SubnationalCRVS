# Jeremy Roth
rm(list=ls())

# load example datasets and necessary packages
load("../SubnationalCRVS/src/example_data_rabat.rda")
load("../SubnationalCRVS/src/example_data_ecuador.rda")
library(dplyr)
library(reshape2)

# ComputeRatioRatios()
## source function
source("../SubnationalCRVS/R/ComputeAgeRatios.R")
source("../SubnationalCRVS/R/Helpers.R")

## specify arguments
data <- example_data_ecuador
name.disaggregations <- "province_name_short"
name.males <- "m"
name.females <- "f"
name.age <- "age" 
name.sex <- "sex"
name.population.year1 <- "pop1"
name.population.year2 <- "pop2"
name.date1 <- "date1"
name.date2 <- "date2"
date.1 <- NULL
date.2 <- NULL
line.size=1.1
fig.nrow=3
fig.ncol=2
ylim_disaggregated=NULL
ylim_overall=NULL

## testing
age_ratios_ecuador <- ComputeAgeRatios(data=example_data_ecuador,
                                       name.disaggregations="province_name_short",
                                       name.age="age",
                                       name.sex="sex",
                                       name.males="m",
                                       name.females="f",
                                       name.population.year1="pop1",
                                       name.population.year2="pop2",
                                       name.date1="date1",
                                       name.date2="date2")

age_ratios_rabat <- ComputeAgeRatios(data=example_data_rabat,
                                     name.disaggregations="residence_type",
                                     name.age="age",
                                     name.sex="sex",
                                     name.males="m",
                                     name.females="f",
                                     name.population.year1="pop1",
                                     name.population.year2="pop2",
                                     name.date1="date1",
                                     name.date2="date2")




