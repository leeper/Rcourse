#' # Multivariate Regression #
#'
#' The bivariate OLS tutorial covers most of the details of model building and output, so this tutorial is comparatively short. It addresses some additional details about multivariate OLS models.
#'
#' We'll begin by generating some fake data involving a few covariates. We'll then generate two outcomes, one that is a simple linear function of the covariates and one that involves an interaction.
set.seed(50)
n <- 200
x1 <- rbinom(n,1,.5)
x2 <- rnorm(n)
x3 <- rnorm(n,0,4)
y1 <- x1 + x2 + x3 + rnorm(n)
y2 <- x1 + x2 + x3 + 2*x1*x2 + rnorm(n)
#' Now we can see how to model each of these processes.
#'
#' ## Regresssion formulae for multiple covariates ##
#' As covered in the formulae tutorial, we can easily represent a multivariate model using a formula just like we did for a bivariate model.
#' For example, a bivariate model might look like:
y1 ~ x1
#' And a multivariate model would look like:
y1 ~ x1 + x2 + x3
#' To include the interaction we need to use the `*` operator, though we could also use `:` for the same result:
y1 ~ x1*x2 + x3
y1 ~ x1 + x2 + x1*x2 + x3
#' The order of variables in a regression formula doesn't matter. Generally, R will print out the regression results in the order that the variables are listed in the formula, but there are exception. For example, all interactions are listed after main effects, as we'll see below.
#'
#' ## Regression estimation ##
#' Estimating a multivariate model is just like a bivariate model:
lm(y1 ~ x1 + x2 + x3)
#' We can do the same with an interaction model:
lm(y1 ~ x1*x2 + x3)
#' By default, the estimated coefficients print to the console. If we want to do anything else with the model, we need to store it as an object and then we can perform further procedures:
m1 <- lm(y1 ~ x1 + x2 + x3)
m2 <- lm(y1 ~ x1*x2 + x3)
#'
#' ## Extracting coefficients ##
#' To obtain just the coefficients themselves, we can use the `coef` function applied to the model object:
coef(m1)
#' Similarly, we can use `residuals` to see the model residuals. We'll just list the first 15 here:
residuals(m1)[1:15]
#' The model objects also include all of the data used to estimate the model in a sub-object called `model`. Let's look at its first few rows:
head(m1$model)
#' There are lots of other things stored in a model object that don't concern us right now, but that you could see with `str(m1)` or `str(m2)`.
#'
#' ## Regression summaries ##
#' Much more information about a model becomes available when we use the `summary` function:
summary(m1)
#' Indeed, as with a bivariate model, a complete representation of the regression results is printed to the console, including coefficients, standard errors, t-statistics, p-values, some summary statistics about the regression residuals, and various model fit statistics. The summary object itself can be saved and objects extracted from it:
s1 <- summary(m1)
#' A look at the structure of `s1` shows that there is considerable detail stored in the summary object:
str(s1)
#' This includes all of the details that were printed to the console, which we extract separately, such as the coefficients:
coef(s1)
s1$coefficients
#' Model fit statistics:
s1$sigma
s1$r.squared
s1$adj.r.squared
s1$fstatistic
#' And so forth. These details become useful to be able to extract when we want to output our results to another format, such as Word, LaTeX, or something else.
#'
#' ### Interaction Model Output ###
#' The output from a model that includes interactions is essentially the same as for a model without any interactions, but note that the interaction coefficients are printed at the end of the output:
coef(m2)
s2 <- summary(m2)
s2
coef(s2)
#'
#' ## Plots of Multivariate OLS Models ##
#' As with bivariate models, we can easily plot our observed data pairwise:
plot(y1~x2)
#' And we can overlay predicted values of the outcome on that kind of plot:
plot(y1~x2)
abline(m1$coef[1], m1$coef[3])
#' or plot the model residuals against included variables:
layout(matrix(1:2,nrow=1))
plot(m1$residuals ~ x1)
plot(m1$residuals ~ x2)
#'
#' For more details on plotting regressions, see the section of tutorials on Regression Plotting.
#'