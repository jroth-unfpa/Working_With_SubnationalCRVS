library(SubnationalCRVS)
library(dplyr)
library(ggplot2)
library(scales)


counts_single <- ecuador_single_year_ages %>% group_by(province_name) %>%
                           summarize("n_year1"=sum(pop1),
                                     "n_year2"=sum(pop2))


counts_five <- ecuador_five_year_ages %>% group_by(province_name) %>%
                           summarize("n_year1"=sum(pop1),
                                     "n_year2"=sum(pop2))
# debugging
data <- ecuador_single_year_ages
name.disaggregations <- "province_name"
name.males <- "m"
name.females <- "f"
name.age <- "age" 
name.sex <- "sex"
name.population.year1 <- "pop1"
name.population.year2 <- "pop2"
name.date1 <- "date1"
name.date2 <- "date2"
line.size.disaggregated=0.6


date.1 <- NULL
date.2 <- NULL

line.size.overall=0.8
fig.nrow.disaggregated=3
fig.ncol.disaggregated=2
ylim.disaggregated=NULL
ylim.overall=NULL







