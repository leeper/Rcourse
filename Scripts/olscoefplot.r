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
#' We can draw a similar plot with confidence intervals instead of SEs.
plot(NA, xlim=c(-3,3), ylim=c(0,4), xlab='Slope', ylab='', yaxt='n')
title('Regression Results')
axis(2, 1:3, c('x1','x2','x3'), las=2)
abline(v=0, col='gray')
points(slopes,1:3, pch=23, col='black', bg='black')
# Then we'll add thick line segments for each 67% CI:
# Note: The `qnorm` function tells us how much to multiple our SEs by to get Gaussian CIs.
segments((slopes-(qnorm(.835)*ses))[1], 1, (slopes+(qnorm(.835)*ses))[1], 1, col='black', lwd=3)
segments((slopes-(qnorm(.835)*ses))[2], 2, (slopes+(qnorm(.835)*ses))[2], 2, col='black', lwd=3)
segments((slopes-(qnorm(.835)*ses))[3], 3, (slopes+(qnorm(.835)*ses))[3], 3, col='black', lwd=3)
# Then we'll add medium line segments for the 95%:
segments((slopes-(qnorm(.975)*ses))[1], 1, (slopes+(qnorm(.975)*ses))[1], 1, col='black', lwd=2)
segments((slopes-(qnorm(.975)*ses))[2], 2, (slopes+(qnorm(.975)*ses))[2], 2, col='black', lwd=2)
segments((slopes-(qnorm(.975)*ses))[3], 3, (slopes+(qnorm(.975)*ses))[3], 3, col='black', lwd=2)
# Then we'll add thin line segments for the 99%:
segments((slopes-(qnorm(.995)*ses))[1], 1, (slopes+(qnorm(.995)*ses))[1], 1, col='black', lwd=1)
segments((slopes-(qnorm(.995)*ses))[2], 2, (slopes+(qnorm(.995)*ses))[2], 2, col='black', lwd=1)
segments((slopes-(qnorm(.995)*ses))[3], 3, (slopes+(qnorm(.995)*ses))[3], 3, col='black', lwd=1)
#'
#' Both of these plots are similar, but show how the size, relative size, and significance of regression slopes can easily be summarized visually.
#'