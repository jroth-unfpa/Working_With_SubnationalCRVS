# Jeremy Roth
rm(list=ls())

# load example datasets and necessary packages
load("../SubnationalCRVS/src/example_data_rabat.rda")
load("../SubnationalCRVS/src/example_data_ecuador.rda")
library(dplyr)
library(DDM)
library(ggplot2)
library(ggpubr)
library(gridExtra)

# ComputeRatioRatios()
## source functions
source("../SubnationalCRVS/R/Helpers.R")
source("../SubnationalCRVS/R/EstimateDDM.R")
source("../SubnationalCRVS/R/PlotDDM.R")

## specify arguments
size.text.sensitivity=8
fig.nrow=2
fig.ncol=1
print.plot.point.estimates=TRUE
save.plot.point.estimates=TRUE
save.name.plot.point.estimates=NULL
print.plots.sensitivity=FALSE
save.plots.sensitivity=TRUE
save.name.plots.sensitivity=NULL
plots.dir="Plots/"

## testing
(ddm_results <- EstimateDDM(data=example_data_ecuador, 
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

PlotDDM(ddm_results=ddm_results,
        size.text.sensitivity=8,
        plots.dir="Plots/")
