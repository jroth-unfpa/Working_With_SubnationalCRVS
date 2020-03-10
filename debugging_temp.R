library(SubnationalCRVS)
library(dplyr)
library(ggplot2)
library(scales)
library(DDM)
library(ggpubr)
source("~/Dropbox/SubnationalCRVS/R/Helpers.R")


counts_single <- ecuador_single_year_ages %>% group_by(province_name) %>%
                           summarize("n_year1"=sum(pop1),
                                     "n_year2"=sum(pop2))


counts_five <- ecuador_five_year_ages %>% group_by(province_name) %>%
                           summarize("n_year1"=sum(pop1),
                                     "n_year2"=sum(pop2))
# debugging
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
label.completeness = "Completeness"
label.subnational.levels = "Province"
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


line.size.disaggregated=0.6
date.1 <- NULL
date.2 <- NULL

line.size.overall=0.8
fig.nrow.disaggregated=3
fig.ncol.disaggregated=2
ylim.disaggregated=NULL
ylim.overall=NULL







