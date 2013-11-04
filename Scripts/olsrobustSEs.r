#' # Heteroskedasticity-Consistent SEs for OLS #
#'
#' We often need to analyze data that fails to satisfy assumptions of the statistical techniques we use.
#' One common violation of assumptions in OLS regression is the assumption of homoskedasticity.
#' This assumption requires that the error term have constant variance across all values of the independent variable(s).
#' When this assumption fails, the standard errors from our OLS regression estimates are inconsistent. But, we can calculate heteroskedasticity-consistent standard errors, relatively easily.
#' Unlike in Stata, where this is simply an option for regular OLS regression, in R, these SEs are not built into the base package, but instead come in an add-on package called **sandwich**, which we need to install and load:
install.packages('sandwich',repos='http://cran.r-project.org')
library(sandwich)
#'
#' To see the **sandwich** package in action, let's generate some heteroskedastic data:
set.seed(1)
x <- runif(500,0,1)
y <- 5*rnorm(500,x,x)
#' A simple plot of `y` against `x` (and the associated regression line) will reveal any heteroskedasticity:
plot(y~x, col='gray', pch=19)
abline(lm(y~x), col='blue')
#' Clearly, the variance of `y` and thus of the error term in an OLS model of `y~x` will increase as `x` increases.
#'
#' Now let's run the OLS model and see the results:
ols <- lm(y~x)
s <- summary(ols)
s
#' It may be particularly helpful to look just as the coefficient matrix from the summary object:
s$coef
#' The second column shows the SEs.
#' These SEs are themselves generated from the variance-covariance matrix for the coefficients, which we can see with:
vcov(ols)
#' The variance estimates for the coefficients are on the diagonal:
diag(vcov(ols))
#' To convert these to SEs, we simply take the squared roote:
sqrt(diag(vcov(ols)))
#'
#' Now that we know where the regular SEs are coming from, let's get the heteroskedasticity-consistent SEs for this model from **sandwich**.
#' The SEs come from the `vcovHC` function and the resulting object is the variance-covariance matrix for the coefficients:
vcovHC(ols)
#' This is, again, a variance-covariance matrix for the coefficients. So to get SES, we take the square root of the diagonal, like we did above:
sqrt(diag(vcovHC(ols)))
#' We can then compare the SE estimate from the standard formula to the heteroskedasticity-consistent formula:
sqrt(diag(vcov(ols)))
sqrt(diag(vcovHC(ols)))
#'
#' One annoying thing about not having the heteroskedasticity-consistent formula built-in is that when we call `summary` on `ols`, it prints the default SEs rather than the ones we really want.
#' But, remember, everything in R is an object. So, we can overwrite the default SEs with the heteroskedasticity-consistent SEs quite easily. To do that, let's first look at the structure of our summary object `s`:
str(s)
#' `s` is a list, one element of which is `coefficients` (which we saw above when we first ran our OLS model). The `s$coefficients` object is a matrix, with four columns, the second of which contains the default standard errors. If we replace those standard errors with the heteroskedasticity-robust SEs, when we print `s` in the future, it will show the SEs we actually want. Let's see the effect by comparing the current output of `s` to the output after we replace the SEs:
s
s$coefficients[,2] <- sqrt(diag(vcovHC(ols)))
s
#' The summary output now reflects the correct SEs. But remember, if we call `summary(ols)`, again, we'll see the original SEs. We need to call our `s` object to see the updated version.
