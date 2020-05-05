library(SubnationalCRVS)
library(dplyr)
library(ggplot2)
library(scales)
library(DDM)
library(ggpubr)
library(DemoTools)
library(gridExtra)
library(reshape2)
source("~/Dropbox/SubnationalCRVS/R/Helpers.R")


# debugging
my_plots_dir <- "Plots/"
data <- ecuador_five_year_ages
name.disaggregations <- "province_name"
name.males <- "m"
name.females <- "f"
name.age <- "age" 
name.sex <- "sex"
name.population.year1 <- "pop1"
name.population.year2 <- "pop2"
name.date1 <- "date1"
name.date2 <- "date2"
name.deaths <- "deaths"
ylim.disaggregated <- NULL
separate.national <- TRUE
name.national <- "National" #NULL
line.size.overall=0.8
fig.nrow.disaggregated=3
fig.ncol.disaggregated=2
ylim.disaggregated=NULL
ylim.overall=NULL
line.size.disaggregated=0.6
show.disaggregated.population=TRUE
fig.nrow.disaggregated=3
fig.ncol.disaggregated=2
fig.nrow.overall=2
fig.ncol.overall=1
print.disaggregated=FALSE
save.disaggregated=TRUE
save.name.disaggregated=NULL
print.overall=FALSE
save.overall=TRUE
save.name.overall=NULL
plots.dir="Plots/"
label.subnational.level = "Province"
fig.nrow=3
fig.ncol=2
confirm_single_year_ages=FALSE
mark_multiples_of_5_disaggregated=FALSE
mark_multiples_of_5_overall=TRUE
show.size.population=TRUE
roughness.age.min=NULL
roughness.age.max=NULL
Whipple.age.min=NULL
Whipple.age.max=NULL
Whipple.digit=NULL
Myers.age.min=NULL
Myers.age.max=NULL
Noumbissi.age.min=NULL
Noumbissi.age.max=NULL
base.size=12
fig.nrow.Noumbissi=2
fig.ncol.Noumbissi=1
show.thresholds.Noumbissi=TRUE
save.name.plots=NULL
show.population.counts=TRUE


label.completeness = "Completeness"
label.RMSE = "RMSE"
base.size.point.estimates = 12
base.size.sensitivity = 9

deaths.summed=TRUE
min.age.in.search=15
max.age.in.search=75
min.number.of.ages=8
exact.ages.to.use=NULL
largest.lower.limit.sensitivity=45
smallest.upper.limit.sensitivity=50
life.expectancy.in.open.group=NULL
minA=15
maxA=75
minAges=8
exact.ages=NULL





base.size.point.estimates=13
base.size.sensitivity=9
fig.nrow=2
fig.ncol=1
show.lines.sex.differential=TRUE
show.size.population=TRUE
label.completeness="Estimated death registration completeness (GGB-SEG)"
label.RMSE="RMSE"
label.subnational.levels=ddm_results$name_disaggregations
save.name.plot.point.estimates=NULL
save.name.plots.sensitivity=NULL
save.name.plots.RMSE=NULL
plots.dir=my_plots_dir





