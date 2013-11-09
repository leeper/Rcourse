#' # Multinomial Outcome Models #
#' 
#' One important, but sometimes problematic, class of regression models deals with nominal or multinomial outcomes (i.e., outcomes that are not continuous or even ordered). Estimating these models is not possible with `glm`, but can be estimated using the *nnet* add-on package, which is recommended and therefore simply needs to be loaded.

if(!library(nnet)){
    install.packages('nnet',repos='http://cran.r-project.org')
    library(nnet)
}
# multinom()

#'