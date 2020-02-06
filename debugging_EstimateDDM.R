# Jeremy Roth
rm(list=ls())

# load example datasets and necessary packages
load("data/example_data_rabat.rda")
load("data/example_data_ecuador.rda")
library(dplyr)
library(DDM)

# ComputeRatioRatios()
## source functions
source("../SubnationalCRVS/R/Helpers.R")
source("../SubnationalCRVS/R/EstimateDDM.R")


## specify arguments
data <- example_data_ecuador
name.disaggregations <- "province"
name.males <- "m"
name.females <- "f"
name.age <- "age" 
name.sex <- "sex"
name.population.year1 <- "pop1"
name.population.year2 <- "pop2"
name.date1 <- "date1"
name.date2 <- "date2"
name.deaths <- "deaths"
deaths.summed <- TRUE 
min.age.in.search <- 15
max.age.in.search <- 75
min.number.of.ages <- 8
largest.lower.limit.sensitivity <- 45
smallest.upper.limit.sensitivity <- 50
exact.ages.to.use <- NULL
life.expectancy.in.open.group <- NULL

## testing
(test_ddm <- EstimateDDM(data=example_data_ecuador, 
            name.disaggregations="province",
            name.age="age",
            name.sex="sex",
            name.males="m",
            name.females="f",
            name.date1="date1",
            name.date2="date2",
            name.population.year1="pop1",
            name.population.year2="pop2",
            name.deaths="deaths",
            deaths.summed=TRUE,
            min.age.in.search=15,
            max.age.in.search=75,
            min.number.of.ages=8,
            life.expectancy.in.open.group=NULL,
            exact.ages.to.use=NULL))
test_ddm_estimates <- test_ddm$ddm_estimates 
test_ddm_sensitivity <- test_ddm$sensitivity_ddm_estimates
