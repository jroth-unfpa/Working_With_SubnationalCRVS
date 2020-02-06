# Jeremy Roth
rm(list=ls())
.rs.restartR()


library(devtools)
library(roxygen2)

setwd("~/Dropbox/SubnationalCRVS/")

document()
setwd("../")
install("SubnationalCRVS/")
library(SubnationalCRVS)
