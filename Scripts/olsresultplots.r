# Plotting regression summaries

# The `olsplots.r` script walked through plotting regression diagnostics.
# Here we focus on plotting regression results.


# Plotting regression slopes
# Because the other script described plotting slopes to some extent, we'll start there.
# Once we have a regression model, it's incredibly easy to plot slopes using `abline`:
set.seed(1)
x1 <- rnorm(100)
y1 <- x1 + rnorm(100)
ols1 <- lm(y1 ~ x1)
plot(y1~x1, col='gray')
# Note: `plot(y1~x1)` is equivalent to `plot(x1,y1)`, with reversed order of terms.
abline(coef(ols1)[1], coef(ols1)['x1'], col='red')
# This is a nice plot, but it doesn't show uncertainty.
# To add uncertainty about our effect, let's try bootstrapping our standard errors.

# To bootstrap, we resample or original data, reestimate the model and redraw our line.
# We're going to do some functional programming to make this happen.
myboot <- function(){
    tmpdata <- data.frame(x1=x1,y1=y1)
    thisboot <- sample(1:nrow(tmpdata),nrow(tmpdata),TRUE)
    coef(lm(y1~x1,data=tmpdata[thisboot,]))
}
bootcoefs <- replicate(2500,myboot())
# The result `bootcoefs` is 2500 bootstrapped OLS estimates
# We can add these all to our plot using a function called `apply`:
plot(y1~x1, col='gray')
apply(bootcoefs,2,abline,col=rgb(1,0,0,.01))
# The darkest parts of this plot show where we have the most certainty about the our expected values.
# At the tails of the plot, because of the uncertainty about our slope, the range of plausible predicted values is greater.

# We can also get a similar looking plot using mathematically calculated SEs.
# The `predict` function will help us determine the predicted values from a regression models at different inputs.
# To use it, we generate some new data representing the range of observed values of our data:
new1 <- data.frame(x1=seq(-3,3,length.out=100))
# We then do the prediction, specifying our model (`ols1`), the new data (`new1`), that we want SEs, and that we want "response" predictions.
pred1 <- predict(ols1, newdata=new1, se.fit=TRUE, type="response")
# We can then plot our data:
plot(y1 ~ x1, col='gray')
# Add the predicted line of best (i.e., the regression line:
points(pred1$fit ~ new1$x1, type="l", col='blue')
# Note: This is equivalent to `abline(coef(ols1)[1] ~ coef(ols1)[2], col='red')` over the range (-3,3).
# Then we add our confidence intervals:
lines(new1$x1, pred1$fit + (1.96*pred1$se.fit), lty=2, col='blue')
lines(new1$x1, pred1$fit - (1.96*pred1$se.fit), lty=2, col='blue')
# Note: The `lty` parameter means "line type." We've requested a dotted line.

# We can then compare the two approaches by plotting them together:
plot(y1 ~ x1, col='gray')
apply(bootcoefs,2,abline,col=rgb(1,0,0,.01))
points(pred1$fit ~ new1$x1, type="l", col='blue')
lines(new1$x1, pred1$fit + (1.96*pred1$se.fit), lty=2, col='blue')
lines(new1$x1, pred1$fit - (1.96*pred1$se.fit), lty=2, col='blue')
# As should be clear, both give us essentially the same representation of uncertainty, but in sylistically different ways.




# Regression summary plots
# Another contemporary way of presenting regression results involves converting a regression table into a figure.
set.seed(500)
x1 <- rnorm(100,5,5)
x2 <- rnorm(100,-2,10)
x3 <- rnorm(100,0,20)
y <- (1*x1) + (-2*x2) + (3*x3) + rnorm(100,0,20)
ols2 <- lm(y ~ x1 + x2 + x3)
# Conventionally, we would present results from this regression as a table:
summary(ols2)
# Or just:
coef(summary(ols2))[,1:2]

# It might be helpful to see the size and significance of these effects as a figure.
# To do so, we have to draw the regression slopes as points and the SEs as lines.
slopes <- coef(summary(ols2))[c('x1','x2','x3'),1]  # slopes
ses <- coef(summary(ols2))[c('x1','x2','x3'),2]     # SEs
# We'll draw the slopes of the three input variables.
# Note: The interpretation of the following plot depends on input variables that have comparable scales.
# Note (continued): Comparing dissimilar variables with this visualization can be misleading!
# Let's construct a plot that draws 1 and 2 SEs for each coefficient:

# We'll start with a blank plot (like a blank canvas):
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


# We can draw a similar plot with confidence intervals instead of SEs.
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

# Both of these plots are similar, but show how the size, relative size, and significance of regression slopes can easily be summarized visually.
