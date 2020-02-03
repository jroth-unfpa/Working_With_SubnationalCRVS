# Jeremy Roth
rm(list=ls())

# load example datasets and necessary packages
load("data/example_data_rabat.rda")
load("data/example_data_ecuador.rda")
library(dplyr)

# ComputeSexRatios()
## source function
source("R/ComputeSexRatios.R")
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

## testing
ecuador_sex_ratio <- ComputeSexRatios(data=example_data_ecuador,
                      name.disaggregations="province",
                      name.males="m",
                      name.females="f",
                      name.age="age",
                      name.sex="sex",
                      name.population.year1="pop1",
                      name.population.year2="pop2")
ecuador_sex_ratio %>% filter(age == "25") %>%
                      select(province, age, sex_ratio_1, sex_ratio_2)
    
rabat_sex_ratio <- ComputeSexRatios(data=example_data_rabat,
                                    name.disaggregations="residence_type",
                                    name.males="m",
                                    name.females="f",
                                    name.age="age",
                                    name.sex="sex",
                                    name.population.year1="pop1",
                                    name.population.year2="pop2")
rabat_sex_ratio %>% filter(age == "25") %>%
                    select(residence_type, age, sex_ratio_1, sex_ratio_2)

