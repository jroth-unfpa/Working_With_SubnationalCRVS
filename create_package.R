# Jeremy Roth
rm(list=ls())

library(devtools)
library(roxygen2)
library(pkgbuild)

#create("../SubnationalCRVS/")
setwd("../SubnationalCRVS/")
document()

## had to fix error as described in https://stackoverflow.com/questions/37776377/error-when-installing-an-r-package-from-github-could-not-find-build-tools-neces
options(buildtools.check = function(action) TRUE )
install() 

