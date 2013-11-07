#' # Count Regression Models #
#'
#' We sometimes want to estimate models of count outcomes. Depending on substantive assumptions, we can model these using a linear model, an ordered outcome model, or a count-specific model. This tutorial talks about count models, specifically poisson models and negative beta binomial models.
#' Poisson models can be estimated using R's base `glm` function, but negative beta binomial regression requires teh MASS add-on package, which is a recommended and therefore is pre-installed and you simply need to load it.

#poisson(link = "log")

library(MASS)
#glm.nb()

#'