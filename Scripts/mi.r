#' # Multiple imputation #
#'
#' This tutorial covers techniques of multiple imputation. There are three main packages that offer multiple imputation techniques. Several other packages - described in the [OfficialStatistics](http://cran.r-project.org/web/views/OfficialStatistics.html) Task View - supply other imputation techniques, but packages **Amelia** (by Gary King and collaborators), **mi** (by Andrew Gelman and collaborators), and **mice** (by Stef van Buuren and collaborators) provide more than enough to work with.
#' Let's start by installing these packages:
install.packages(c('Amelia','mi','mice',repos='http://cran.r-project.org')
#'
#' ## Amelia ##
library(Amelia)
#'
#' ## mi ##
library(mi)
#'
#' ## mice ##
library(mice)
#'