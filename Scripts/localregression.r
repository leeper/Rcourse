#' # Local Regression (LOESS) #
#' 
#' Sometimes we have bivariate data that are not well represented by a linear function (even if the variables are transformed). We might be able to see a relationship between the data in a scatterplot, but we are unable to fit a parametric model that properly describes the relationship between outcome and predictor. This might be particularly common when our predictor is a time variable and the outcome is a time-series.
#' In these situations, one way to grasp and convey the relationship is with "local regression," which fits a nonparametric curve to a scatterplot.
#' Note: Local regression also works in multivariate contexts, but we'll focus on the bivariate form here for sake of simplicity.
#'
#' Let's create a simple bivariate relationship and a complex one to see how local regression works in both cases.
set.seed(100)
x <- sample(1:50,100,TRUE)
y1 <- 2*x + rnorm(50,0,10)
y2 <- 5 + rnorm(100,5*abs(x-25),abs(x-10)+10)
#'
#' ## Fitting and visualizing local regressions ##
#' We can fit the local regression using the `loess` function, which takes a formula object as its argument, just like any other regression:
localfit <- loess(y1~x)
#' We can look at the `summary` of the `localfit` object, but - unlike parametric regression methods - the summary won't tell us much.
summary(localfit)
#' Local regression doesn't produce coefficients, so there's no way to see the model in tabular form. Instead we have to look at its predicted values and plot them visually.
#'
#' We can calculate predicted values at each possible value of `x`:
localp <- predict(localfit,data.frame(x=1:50), se=TRUE)
#' The result is a vector of predicted values:
localp
#'
#' To see the loess curve, we can simply plot the fitted values. We'll do something a little more interesting though. We'll start by plotting our original data (in blue), then plot the standard errors as polygons (using the `polygon`) function (for 1-, 2-, and 3-SEs), then overlay the fitted loess curve in white.
#' The plot nicely shows the fit to the data and the increasing uncertainty about the conditional mean at the tails of the independent variable. We also see that these data are easily modeled by a linear regression, which we could add to the plot.
plot(y1~x, pch=15, col=rgb(0,0,1,.5))
# one SE
polygon(c(1:50,50:1), c(localp$fit-localp$se.fit,rev(localp$fit+localp$se.fit)), col=rgb(1,0,0,.2), border=NA)
# two SEs
polygon(c(1:50,50:1), c(localp$fit-2*localp$se.fit,rev(localp$fit+2*localp$se.fit)), col=rgb(1,0,0,.2), border=NA)
# three SEs
polygon(c(1:50,50:1), c(localp$fit-3*localp$se.fit,rev(localp$fit+3*localp$se.fit)), col=rgb(1,0,0,.2), border=NA)
# loess curve:
lines(1:50, localp$fit, col='white', lwd=2)
# overlay a linear fit:
abline(lm(y1~x), lwd=2)
#' 
#' Loess works well in a linear situation, but in those cases we're better off fitting the linear model because then we can get directly interpretable coefficients. The major downside of local regression is that we can only see it and understand it as a graph.
#'
#' We can repeat the above process for our second outcome, which lacks a clear linear relationship between predictor `x` and outcome `y2`:
localfit <- loess(y2~x)
localp <- predict(localfit,data.frame(x=1:50), se=TRUE)
plot(y2~x, pch=15, col=rgb(0,0,1,.5))
# one SE
polygon(c(1:50,50:1), c(localp$fit-localp$se.fit,rev(localp$fit+localp$se.fit)), col=rgb(1,0,0,.2), border=NA)
# two SEs
polygon(c(1:50,50:1), c(localp$fit-2*localp$se.fit,rev(localp$fit+2*localp$se.fit)), col=rgb(1,0,0,.2), border=NA)
# three SEs
polygon(c(1:50,50:1), c(localp$fit-3*localp$se.fit,rev(localp$fit+3*localp$se.fit)), col=rgb(1,0,0,.2), border=NA)
# loess curve:
lines(1:50, localp$fit, col='white', lwd=2)
# overlay a linear fit and associated standard errors:
lmfit <- lm(y2~x)
abline(lmfit, lwd=2)
lmp <- predict(lmfit,data.frame(x=1:50), se.fit=TRUE)
lines(1:50, lmp$fit-lmp$se.fit, lty=2)
lines(1:50, lmp$fit+lmp$se.fit, lty=2)
#' In contrast to the data where `y1` was a simple function of `x`, these data are far messier. They are not well-represented by a straight line fit (as evidenced by our overlay of a linear fit to the data). Instead, the local regression approach shows how `y2` is not a clean function of the predictor. In these situations, the local regression curve can be helpful for understanding the relationship between outcome and predictor and potentially for building a subsequent parametric model that approximates the data better than a straight line.
#'