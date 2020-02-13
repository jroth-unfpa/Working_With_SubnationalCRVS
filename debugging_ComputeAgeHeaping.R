# Jeremy Roth
rm(list=ls())

# load example dataset and necessary packages
load("../SubnationalCRVS/data/ecuador_age_tabulation.rda")
library(dplyr)
library(DemoTools)
library(ggplot2)

# ComputeRatioRatios()
## source function
source("../SubnationalCRVS/R/ComputeAgeHeapingScores.R")
source("../SubnationalCRVS/R/Helpers.R")

## specify arguments
data <- ecuador_age_tabulation
name.disaggregations <- "province"
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
ylim.overall <- NULL
fig.nrow.overall <- 2
fig.ncol.overall <- 1
print.overall <- TRUE
save.overall <- TRUE
save.name_overall <- NULL

## testign
test_age_heaping <- ComputeAgeHeapingScores(data=ecuador_age_tabulation,
                        name.disaggregations="province",
                        name.males="m",
                        name.females="f",
                        name.age="age",
                        name.sex="sex",
                        name.date1="date1",
                        name.date2="date2",
                        name.population.year1="pop1",
                        name.population.year2="pop2")
head(test_age_heaping)
tail(test_age_heaping)
g_age_heaping <- ggplot(data=test_age_heaping,
                        aes(x=province,
                            y=Myers))
g_age_heaping + geom_point(aes(col=get(name.sex)))

