library(SubnationalCRVS)
library(dplyr)
library(ggplot2)
library(scales)
library(DDM)
library(ggpubr)
library(DemoTools)
source("~/Dropbox/SubnationalCRVS/R/Helpers.R")

# national-level stuff
my_plots_dir <- "Plots/"
head(ecuador_five_year_ages)
tail(ecuador_five_year_ages)
a <- ecuador_five_year_ages %>% group_by(sex, age) %>%
                                summarize("pop1"=sum(pop1),
                                          "pop2"=sum(pop2),
                                          "deaths"=sum(deaths),
                                          "province_name"="National",
                                          "province_name_short"="Nat",
                                          "date1"="2001-11-25",
                                          "date2"="2010-11-28") %>%
                                select(province_name,
                                       province_name_short,
                                       sex,
                                       age,
                                       pop1,
                                       pop2,
                                       deaths,
                                       date1,
                                       date2) %>%
                                as.data.frame()
ecuador_five_year_ages_with_national <- rbind(a,
                                              ecuador_five_year_ages)

# debugging
data <- ecuador_five_year_ages_with_national
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
name.national <- "National"
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

label.completeness = "Completeness"
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



date.1 <- NULL
date.2 <- NULL








