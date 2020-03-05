# Jeremy Roth
rm(list=ls())

# load example dataset and necessary packages
load("../SubnationalCRVS/src/ecuador_age_tabulation.rda")
library(dplyr)
library(DemoTools)
library(ggplot2)
library(gridExtra)

# ComputeRatioRatios()
## source function
source("../SubnationalCRVS/R/ComputeAgeHeapingScores.R")
source("../SubnationalCRVS/R/Helpers.R")
source("../SubnationalCRVS/R/PlotAgeHeapingScores.R")

## specify arguments
data <- ecuador_age_tabulation
name.disaggregations <- "province_name"
name.males <- "m"
name.females <- "f"
name.age <- "age" 
name.sex <- "sex"
date.1 <- NULL
date.2 <- NULL
name.population.year1 <- "pop1"
name.population.year2 <- "pop2"
name.date1 <- "date1"
name.date2 <- "date2"
roughness.age.min <- NULL
roughness.age.max <- NULL
sawtooth.age.min <- NULL
sawtooth.age.max <- NULL
Whipple.age.min <- NULL
Whipple.age.max <- NULL
Whipple.digit <- NULL
Myers.age.min <- NULL
Myers.age.max <- NULL
Noumbissi.age.min <- NULL
Noumbissi.age.max <- NULL
Noumbissi.digit <- NULL
fig.nrow <- 2
fig.ncol <- 2
print.plots <- TRUE
save.plots <- TRUE
save.name.plots <- NULL
plots.dir <- "Plots/"
label.subnational.levels <- name.disaggregations
base.size=12


## testing
test_age_heaping <- ComputeAgeHeapingScores(data=ecuador_age_tabulation,
                        name.disaggregations="province_name_short",
                        name.males="m",
                        name.females="f",
                        name.age="age",
                        name.sex="sex",
                        name.date1="date1",
                        name.date2="date2",
                        name.population.year1="pop1",
                        name.population.year2="pop2")

test_age_heaping_plotting <- PlotAgeHeapingScores(data=ecuador_age_tabulation,
                                      name.disaggregations="province_name_short",
                                      name.males="m",
                                      name.females="f",
                                      name.age="age",
                                      name.sex="sex",
                                      name.date1="date1",
                                      name.date2="date2",
                                      name.population.year1="pop1",
                                      name.population.year2="pop2",
                                      plots.dir="Plots/")

