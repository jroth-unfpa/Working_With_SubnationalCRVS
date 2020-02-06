# Jeremy Roth
rm(list=ls())

# load example datasets and necessary packages
load("data/example_data_rabat.rda")
load("data/example_data_ecuador.rda")
library(dplyr)
library(reshape2)

# ComputeRatioRatios()
## source function
source("R/ComputeAgeRatios.R")
source("R/GetOneAgeRatio.R")

## specify arguments
data <- example_data_ecuador
name.disaggregations <- "province"
name.males <- "m"
name.females <- "f"
name.age <- "age" 
name.sex <- "sex"
date.1 <- NULL
date.2 <- NULL
line.size=1.1
fig.nrow=3
fig.ncol=2
ylim_disaggregated=NULL
ylim_overall=NULL
name.population.year1 <- "pop1"
name.population.year2 <- "pop2"

## testing
age_ratios_ecuador <- ComputeAgeRatios(data=example_data_ecuador,
                                       name.disaggregations="province",
                                       name.age="age",
                                       name.sex="sex",
                                       name.males="m",
                                       name.females="f")
age_ratios_ecuador %>% filter(province == 10 & 
                                age %in% seq(from=5, to=20, by=5)) %>%
                       select(province, age, sex, 
                              pop1, age_ratio_1, pop2, age_ratio_2)


age_ratios_rabat <- ComputeAgeRatios(data=example_data_rabat,
                                     name.disaggregations="residence_type",
                                     name.age="age",
                                     name.sex="sex",
                                     name.males="m",
                                     name.females="f")
age_ratios_rabat %>% filter(residence_type == "Rural" & 
                              age %in% seq(from=5, to=20, by=5)) %>%
                     select(residence_type, age, sex, 
                            pop1, age_ratio_1, pop2, age_ratio_2)




