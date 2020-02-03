# Jeremy Roth
rm(list=ls())

# load example datasets and necessary packages
load("data/example_data_rabat.rda")
load("data/example_data_ecuador.rda")
library(dplyr)
library(DDM)

# ComputeRatioRatios()
## source functions
source("R/Helpers.R")
source("R/EstimateDDM.R")

## specify arguments
data <- example_data_ecuador
name.disaggregations <- "province"
name.males <- "m"
name.females <- "f"
name.age <- "age" 
name.sex <- "sex"
name.population.year1 <- "pop1"
name.population.year2 <- "pop2"
name.date1 <- "date1"
name.date2 <- "date2"
name.deaths <- "deaths"
deaths.summed <- TRUE 
min.age.in.search <- 15
max.age.in.search <- 75
min.number.of.ages <- 8
largest.lower.limit.sensitivity <- 45
smallest.upper.limit.sensitivity <- 50
exact.ages.to.use <- NULL
life.expectancy.in.open.group <- NULL

## testing
(test_ddm <- EstimateDDM(data=example_data_ecuador, 
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
test_ddm_estimates <- test_ddm$ddm_estimates 
test_ddm_sensitivity <- test_ddm$sensitivity_ddm_estimates

library(ggplot2)
g <- ggplot(data=test_ddm$ddm_estimates %>%
                 filter(cod != 90),
            aes(x=cod,
                y=ggbseg))
g + geom_point(aes(col=sex),
               size=3,
               alpha=0.7) +
    labs(x="Province",
         y="Estimated death registration completeness (GGBSEG)")

test_ddm$sensitivity_ddm_estimates[, "lower_age_range"] <- 
    as.factor(test_ddm$sensitivity_ddm_estimates[, "lower_age_range"])
test_ddm$sensitivity_ddm_estimates[, "upper_age_range"] <- 
  as.factor(test_ddm$sensitivity_ddm_estimates[, "upper_age_range"])
g_sensitivity_females <- ggplot(data=test_ddm$sensitivity_ddm_estimates %>%
                             filter(cod == 1 & sex == "Females"),
                        aes(x=lower_age_range,
                            y=ggbseg))
g_sensitivity_females <- g_sensitivity_females + 
                         geom_point(aes(col=upper_age_range),
                                    size=3,
                                    alpha=0.7) +
                labs(x="Lower limit of age range",
                     y="Estimated death registration completeness (GGBSEG)",
                     title="cod 1") +
                coord_cartesian(ylim=c(0, 1))
g_sensitivity_females
g_sensitivity_males <- ggplot(data=test_ddm$sensitivity_ddm_estimates %>%
                                filter(cod == 1 & sex == "Males"),
                              aes(x=lower_age_range,
                                  y=ggbseg))
g_sensitivity_males <- g_sensitivity_males + 
                       geom_point(aes(col=upper_age_range),
                                 size=3,
                                 alpha=0.7) +
  labs(x="Lower limit of age range",
       y="Estimated death registration completeness (GGBSEG)",
       title="cod 1") +
  coord_cartesian(ylim=c(0, 1))
g_sensitivity_males
library(ggpubr)
ggarrange(g_sensitivity_females,
          g_sensitivity_males,
          nrow=1)  
