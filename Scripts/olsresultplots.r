#' # Plotting regression summaries #
#'
#' The `olsplots.r` script walked through plotting regression diagnostics.
#' Here we focus on plotting regression results.


#' ## Plotting regression slopes ##
#'
#' Because the other script described plotting slopes to some extent, we'll start there.
#' Once we have a regression model, it's incredibly easy to plot slopes using `abline`:
set.seed(1)
x1 <- rnorm(100)
y1 <- x1 + rnorm(100)
ols1 <- lm(y1 ~ x1)
plot(y1~x1, col='gray')
#' Note: `plot(y1~x1)` is equivalent to `plot(x1,y1)`, with reversed order of terms.
abline(coef(ols1)[1], coef(ols1)['x1'], col='red')
#' This is a nice plot, but it doesn't show uncertainty.
#' To add uncertainty about our effect, let's try bootstrapping our standard errors.

#' To bootstrap, we resample or original data, reestimate the model and redraw our line.
#' We're going to do some functional programming to make this happen.
myboot <- function(){
    tmpdata <- data.frame(x1=x1,y1=y1)
    thisboot <- sample(1:nrow(tmpdata),nrow(tmpdata),TRUE)
    coef(lm(y1~x1,data=tmpdata[thisboot,]))
}
bootcoefs <- replicate(2500,myboot())
#' The result `bootcoefs` is 2500 bootstrapped OLS estimates
#' We can add these all to our plot using a function called `apply`:
plot(y1~x1, col='gray')
apply(bootcoefs,2,abline,col=rgb(1,0,0,.01))
#' The darkest parts of this plot show where we have the most certainty about the our expected values.
#' At the tails of the plot, because of the uncertainty about our slope, the range of plausible predicted values is greater.

#' We can also get a similar looking plot using mathematically calculated SEs.
#' The `predict` function will help us determine the predicted values from a regression models at different inputs.
#' To use it, we generate some new data representing the range of observed values of our data:
new1 <- data.frame(x1=seq(-3,3,length.out=100))
#' We then do the prediction, specifying our model (`ols1`), the new data (`new1`), that we want SEs, and that we want "response" predictions.
pred1 <- predict(ols1, newdata=new1, se.fit=TRUE, type="response")
#' We can then plot our data:
plot(y1 ~ x1, col='gray')
# Add the predicted line of best (i.e., the regression line:
points(pred1$fit ~ new1$x1, type="l", col='blue')
# Note: This is equivalent to `abline(coef(ols1)[1] ~ coef(ols1)[2], col='red')` over the range (-3,3).
# Then we add our confidence intervals:
lines(new1$x1, pred1$fit + (1.96*pred1$se.fit), lty=2, col='blue')
lines(new1$x1, pred1$fit - (1.96*pred1$se.fit), lty=2, col='blue')
#' Note: The `lty` parameter means "line type." We've requested a dotted line.

#' We can then compare the two approaches by plotting them together:
plot(y1 ~ x1, col='gray')
apply(bootcoefs,2,abline,col=rgb(1,0,0,.01))
points(pred1$fit ~ new1$x1, type="l", col='blue')
lines(new1$x1, pred1$fit + (1.96*pred1$se.fit), lty=2, col='blue')
lines(new1$x1, pred1$fit - (1.96*pred1$se.fit), lty=2, col='blue')
#' As should be clear, both give us essentially the same representation of uncertainty, but in sylistically different ways.

#' It is also possible to draw a shaded region rather than the blue lines in the above example.
#' To do this we use the `polygon` function, which we have to feed some x and y positions of points:
plot(y1 ~ x1, col='gray')
polygon(    c(seq(-3,3,length.out=100),rev(seq(-3,3,length.out=100))),
            c(pred1$fit - (1.96*pred1$se.fit),rev(pred1$fit + (1.96*pred1$se.fit))),
            col=rgb(0,0,1,.5), border=NA)
#' Alternatively, we might want to show different confidence intervals with this kind of polygon:
plot(y1 ~ x1, col='gray')
# 67% CI
# To draw the polygon, we have to specify the x positions of the points from our predictions.
# We do this first left to right (for the lower CI limit) and then right to left (for the upper CI limit).
# Then we specify the y positions, which are just the outputs from the `predict` function.
polygon(    c(seq(-3,3,length.out=100),rev(seq(-3,3,length.out=100))),
            c(pred1$fit - (qnorm(.835)*pred1$se.fit),rev(pred1$fit + (qnorm(.835)*pred1$se.fit))),
            col=rgb(0,0,1,.2), border=NA)
# Note: The `qnorm` function tells us how much to multiple our SEs by to get Gaussian CIs.
# 95% CI
polygon(    c(seq(-3,3,length.out=100),rev(seq(-3,3,length.out=100))),
            c(pred1$fit - (qnorm(.975)*pred1$se.fit),rev(pred1$fit + (qnorm(.975)*pred1$se.fit))),
            col=rgb(0,0,1,.2), border=NA)
# 99% CI
polygon(    c(seq(-3,3,length.out=100),rev(seq(-3,3,length.out=100))),
            c(pred1$fit - (qnorm(.995)*pred1$se.fit),rev(pred1$fit + (qnorm(.995)*pred1$se.fit))),
            col=rgb(0,0,1,.2), border=NA)
# 99.9% CI
polygon(    c(seq(-3,3,length.out=100),rev(seq(-3,3,length.out=100))),
            c(pred1$fit - (qnorm(.9995)*pred1$se.fit),rev(pred1$fit + (qnorm(.9995)*pred1$se.fit))),
            col=rgb(0,0,1,.2), border=NA)
