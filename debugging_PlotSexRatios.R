# Jeremy Roth
rm(list=ls())

# load example datasets and necessary packages
load("data/example_data_rabat.rda")
load("data/example_data_ecuador.rda")
library(ggplot2)
library(ggpubr)
library(gridExtra)
library(dplyr)
library(reshape2)

# ComputeRatioRatios()
## source function
source("R/ComputeSexRatios.R")
source("R/PlotSexRatios.R")

## specify arguments
data <- example_data_ecuador
name.disaggregations <- "province"
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
PlotSexRatios(data=example_data_ecuador,
              name.disaggregations="province",
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


PlotSexRatios(data=example_data_rabat,
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
              print.disaggregated=FALSE,
              print.overall=FALSE,
              save.disaggregated=FALSE,
              plots.dir="Plots/")

