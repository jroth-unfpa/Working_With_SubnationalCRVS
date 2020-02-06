# Jeremy Roth
rm(list=ls())

# source functions (will be replaced with library() call after documentation is ready)
library(miceadds)
source.all(path="../SubnationalCRVS/R/")

# load data
load("data/example_data_ecuador.rda")

# DDQA
## sex ratios
s <- PlotSexRatios(data=example_data_ecuador,
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
head(s$data_with_sex_ratio) 

## age ratios
a <- PlotAgeRatios(data=example_data_ecuador,
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



