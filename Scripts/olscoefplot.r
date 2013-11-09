#' # Regression coefficient plots #
#'
#' A contemporary way of presenting regression results involves converting a regression table into a figure.
set.seed(500)
x1 <- rnorm(100,5,5)
x2 <- rnorm(100,-2,10)
x3 <- rnorm(100,0,20)
y <- (1*x1) + (-2*x2) + (3*x3) + rnorm(100,0,20)
ols2 <- lm(y ~ x1 + x2 + x3)
#' Conventionally, we would present results from this regression as a table:
summary(ols2)
#' Or just:
coef(summary(ols2))[,1:2]
#'
#' It might be helpful to see the size and significance of these effects as a figure.
#' To do so, we have to draw the regression slopes as points and the SEs as lines.
slopes <- coef(summary(ols2))[c('x1','x2','x3'),1]  #' slopes
ses <- coef(summary(ols2))[c('x1','x2','x3'),2]     #' SEs
#' We'll draw the slopes of the three input variables.
#' Note: The interpretation of the following plot depends on input variables that have comparable scales.
#' Note (continued): Comparing dissimilar variables with this visualization can be misleading!
#'
#' ## Plotting Standard Errors ##
#' Let's construct a plot that draws 1 and 2 SEs for each coefficient:
#'
#' We'll start with a blank plot (like a blank canvas):
plot(NA, xlim=c(-3,3), ylim=c(0,4), xlab='Slope', ylab='', yaxt='n')
# We can add a title:
title('Regression Results')
# We'll add a y-axis labelling our variables:
axis(2, 1:3, c('x1','x2','x3'), las=2)
# We'll add a vertical line for zero:
abline(v=0, col='gray')
# Then we'll draw our slopes as points (`pch` tells us what type of point):
points(slopes,1:3, pch=23, col='black', bg='black')
# Then we'll add thick line segments for each 1 SE:
segments((slopes-ses)[1], 1, (slopes+ses)[1], 1, col='black', lwd=2)
segments((slopes-ses)[2], 2, (slopes+ses)[2], 2, col='black', lwd=2)
segments((slopes-ses)[3], 3, (slopes+ses)[3], 3, col='black', lwd=2)
# Then we'll add thin line segments for the 2 SEs:
segments((slopes-(2*ses))[1], 1, (slopes+(2*ses))[1], 1, col='black', lwd=1)
segments((slopes-(2*ses))[2], 2, (slopes+(2*ses))[2], 2, col='black', lwd=1)
segments((slopes-(2*ses))[3], 3, (slopes+(2*ses))[3], 3, col='black', lwd=1)
#'
#' ## Plotting Confidence Intervals ##
#' We can draw a similar plot with confidence intervals instead of SEs.
plot(NA, xlim=c(-3,3), ylim=c(0,4), xlab='Slope', ylab='', yaxt='n')
title('Regression Results')
axis(2, 1:3, c('x1','x2','x3'), las=2)
abline(v=0, col='gray')
points(slopes,1:3, pch=23, col='black', bg='black')
# Then we'll add thick line segments for each 67% CI:
# Note: The `qnorm` function tells us how much to multiple our SEs by to get Gaussian CIs.
# Note: We'll also use vectorization here to save having to retype the `segments` command for each line:
segments((slopes-(qnorm(.835)*ses)), 1:3, (slopes+(qnorm(.835)*ses)), 1:3, col='black', lwd=3)
# Then we'll add medium line segments for the 95%:
segments((slopes-(qnorm(.975)*ses)), 1:3, (slopes+(qnorm(.975)*ses)), 1:3, col='black', lwd=2)
# Then we'll add thin line segments for the 99%:
segments((slopes-(qnorm(.995)*ses)), 1:3, (slopes+(qnorm(.995)*ses)), 1:3, col='black', lwd=1)
#'
#' Both of these plots are similar, but show how the size, relative size, and significance of regression slopes can easily be summarized visually.
#'
#' ## Comparable effect sizes ##
#' One of the major problems (noted above) with these kinds of plots is that in order for them to make visual sense, the underlying covariates have to be inherently comparable. By showing slopes, the plot shows the effect of a unit change in each covariate on the outcome, but unit changes may not be comparable across variables. We could probably come up with an infinite number of ways of presenting the results, but let's focus on two here: plotting standard deviation changes in covariates and plotting minimum to maximum changes in scale of covariates.
#'
#' ### Standard deviation changes in X ###
#' Let's recall the values of our coefficients on `x1`, `x2`, and `x3`:
coef(summary(ols2))[,1:2]
#' On face value, `x3` has the largest effect, but what happens when we account for different standard deviations of the covariates:
sd(x1)
sd(x2)
sd(x3)
#' `x1` clearly also has the largest variance, so it may make more sense to compare a standard deviation change across the variables.
#' To do that is relatively simple because we're working in a linear model, so we simply need to calculate the standard deviation of each covariate and multiply that by the respective coefficient:
c1 <- coef(summary(ols2))[-1,1:2] # drop the intercept
c2 <- numeric(length=3)
c2[1] <- c1[1,1]*sd(x1)
c2[2] <- c1[2,1]*sd(x2)
c2[3] <- c1[3,1]*sd(x3)
#' Then we'll get standard errors for those changes:
s2 <- numeric(length=3)
s2[1] <- c1[1,2]*sd(x1)
s2[2] <- c1[2,2]*sd(x2)
s2[3] <- c1[3,2]*sd(x3)
#' Then we can plot the results:
plot(c2,1:3, pch=23, col='black', bg='black', xlim=c(-25,65), ylim=c(0,4), xlab='Slope', ylab='', yaxt='n')
title('Regression Results')
axis(2, 1:3, c('x1','x2','x3'), las=2)
abline(v=0, col='gray')
# Then we'll add medium line segments for the 95%:
segments((c2-(qnorm(.975)*s2)), 1:3, (c2+(qnorm(.975)*s2)), 1:3, col='black', lwd=2)
# Then we'll add thin line segments for the 99%:
segments((c2-(qnorm(.995)*s2)), 1:3, (c2+(qnorm(.995)*s2)), 1:3, col='black', lwd=1)
#' By looking at standard deviation changes (focus on the scale of the x-axis), we can see that `x3` actually has the largest effect by a much larger factor than we saw in the raw slopes. Moving the same relative amount up each covariate's distribution produces substantially different effects on the outcome.
#'
#' ### Full scale changes in X ###
#' Another way to visualize effect sizes is to examine the effect of full scale changes in covariates. This is especially useful when deal within covariates that differ dramatically in scale (e.g., a mix of discrete and continuous variables).
#' The basic calculations for these kinds of plots are the same as in the previous plot, but instead of using `sd`, we use `diff(range())`, which tells us what a full scale change is in the units of each covariate:
c3 <- numeric(length=3)
c3[1] <- c1[1,1]*diff(range(x1))
c3[2] <- c1[2,1]*diff(range(x2))
c3[3] <- c1[3,1]*diff(range(x3))
#' Then we'll get standard errors for those changes:
s3 <- numeric(length=3)
s3[1] <- c1[1,2]*diff(range(x1))
s3[2] <- c1[2,2]*diff(range(x2))
s3[3] <- c1[3,2]*diff(range(x3))
#' Then we can plot the results:
plot(c3,1:3, pch=23, col='black', bg='black', xlim=c(-150,300), ylim=c(0,4), xlab='Slope', ylab='', yaxt='n')
title('Regression Results')
axis(2, 1:3, c('x1','x2','x3'), las=2)
abline(v=0, col='gray')
# Then we'll add medium line segments for the 95%:
segments((c3-(qnorm(.975)*s3)), 1:3, (c3+(qnorm(.975)*s3)), 1:3, col='black', lwd=2)
# Then we'll add thin line segments for the 99%:
segments((c3-(qnorm(.995)*s3)), 1:3, (c3+(qnorm(.995)*s3)), 1:3, col='black', lwd=1)
#' 
#' Focusing on the x-axes of the last three plots, we see how differences in scaling of the covariates can lead to vastly different visual interpretations of effect sizes. Plotting the slopes directly suggested that `x3` had an effect about three times larger than the effect of `x1`. Plotting standard deviation changes suggested that `x3` had an effect about 10 times larger than the effect of `x1` and plotting full scale changes in covariates showed a similar substantive conclusion. While each showed that `x3` had the largest effect, interpreting the relative contribution of the different variables depends upon how much variance we would typically see in each variable in our data. The unit-change effect (represented by the slope) may not be the effect size that we ultimately care about for each covariate.
#'