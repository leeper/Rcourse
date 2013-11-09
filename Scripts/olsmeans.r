#' # OLS as Regression on Means #
#'
#' One of the things that I find most difficult about regression is visualizing what is actually happening when a regression model is fit.
#' One way to better understand that process is to recognize that a regression is simply a curve through the conditional mean values of an outcome at each value of one or more predictors. Thus, we can actually estimate (i.e., "figure out") the regression line simply by determining the conditional mean of our outcome at each value of of our input. 
#' This is easiest to see in a bivariate regression, so let's create some data and build the model:
set.seed(100)
x <- sample(0:50,10000,TRUE)
#xsq <- x^2 # a squared term just for fun
# the data-generating process:
y <- 2 + x + (x^2) + rnorm(10000,0,300)
#' Now let's calculate the conditional means of `x`, `xsq`, and `y`:
condmeans_x <- by(x,x,mean)
condmeans_x2 <- by(x^2,x,mean)
condmeans_y <- by(y,x,mean)
#' If we run the regression on the original data (assuming we know the data-generating process), we'll get the following:
lm1 <- lm(y~x+I(x^2))
summary(lm1)
#' If we run the regression instead on just the conditional means (i.e., one value of `y` at each value of `x`), we will get the following:
lm2 <- lm(condmeans_y ~ condmeans_x + condmeans_x2)
summary(lm2)
#' The results from the two models look very similar. Aside from some minor variations, they provide identical substantive inference about the process at-hand. We can see this if we plot the original data (in gray) and overlay it with the conditional means of `y` (in red):
plot(y ~ x, col=rgb(0,0,0,.05), pch=16)
points(condmeans_y ~ condmeans_x, col="red", pch=15)
#' We can add predicted output lines (one for each model) to this plot to see the similarity of the two models even more clearly. Indeed, the lines overlay each other perfectly:
plot(y ~ x, col=rgb(0,0,0,.05), pch=16)
points(condmeans_y ~ condmeans_x, col="red", pch=15)
lines(0:50,predict(lm1,data.frame(x=0:50)), col='green', type='l', lwd=2)
lines(0:50,predict(lm2,data.frame(x=0:50)), col='blue', type='l', lwd=2)
#' So, if you ever struggle to think about what regression is doing, just remember that it is simply drawing a (potentially multidimensional) curve through the conditional means of the outcome at every value of the covariate(s).
#'