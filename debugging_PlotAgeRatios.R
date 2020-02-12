# Jeremy Roth
rm(list=ls())

# load example datasets and necessary packages
load("../SubnationalCRVS/src/example_data_rabat.rda")
load("../SubnationalCRVS/src/example_data_ecuador.rda")
library(ggplot2)
library(ggpubr)
library(gridExtra)
library(dplyr)
library(reshape2)

# ComputeRatioRatios()
## source function
source("../SubnationalCRVS/R/ComputeAgeRatios.R")
source("../SubnationalCRVS/R/Helpers.R")
source("../SubnationalCRVS/R/PlotAgeRatios.R")

## specify arguments
data <- example_data_ecuador
name.disaggregations <- "province_name_short"
name.males <- "m"
name.females <- "f"
name.age <- "age" 
name.sex <- "sex"
date.1 <- NULL
date.2 <- NULL
line.size.disaggregated=0.8
line.size.overall=0.8
fig.nrow.disaggregated=3
fig.ncol.disaggregated=2
ylim.disaggregated=NULL
ylim.overall=NULL
name.population.year1 <- "pop1"
name.population.year2 <- "pop2"
name.date1 <- "date1"
name.date2 <- "date2"
save.overall = TRUE
save.name_overall = NULL
fig.nrow.overall=2
fig.ncol.overall=1

## testing
a <- PlotAgeRatios(data=example_data_ecuador,
              name.disaggregations="province_name",
              name.males="m",
              name.females="f",
              name.age="age",
              name.sex="sex",
              name.date1="date1",
              name.date2="date2",
              name.population.year1="pop1",
              name.population.year2="pop2",
              line.size.overall=0.6,
              print.disaggregated=FALSE,
              print.overall=FALSE,
              plots.dir="Plots/")

PlotAgeRatios(data=example_data_rabat,
              name.disaggregations="residence_type",
              name.males="m",
              name.females="f",
              name.age="age",
              name.sex="sex",
              name.date1="date1",
              name.date2="date2",
              name.population.year1="pop1",
              name.population.year2="pop2",
              line.size.overall=0.6,
              save.disaggregated=FALSE,
              print.disaggregated=FALSE,
              fig.nrow.overall=2,
              fig.ncol.overall=2,
              print.overall=FALSE,
              plots.dir="Plots/")


