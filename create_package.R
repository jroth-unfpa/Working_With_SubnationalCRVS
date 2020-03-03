# Jeremy Roth
rm(list=ls())
.rs.restartR()

library(devtools)
library(roxygen2)

setwd("~/Dropbox/SubnationalCRVS/")

document() ## wrapper for roxygen2::roxygenize() -- vignette("rd") for help
setwd("../")
install("SubnationalCRVS/") ## installs with "R CMD INSTALL"

.rs.restartR()
library(SubnationalCRVS)
