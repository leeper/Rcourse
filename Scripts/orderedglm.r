#' # Ordered Outcome Models #
#'
#' This tutorial focues on ordered outcome regression models. R's base `glm` function does not support these, but they're very easy to execute using the MASS package, which is a recommended package.
if(!library(MASS)){
    install.packages('MASS',repos='http://cran.r-project.org')
    library(MASS)
}
#'
#polr()
#'