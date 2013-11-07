#' # OLS interaction plots #
#'
#' Interactions are important, but they're hard to understand without visualization.
#' This script works through how to visualize interactions in linear regression models.
#'
#' ## Plots for identifying interactions ##
#'
set.seed(1)
x1 <- rnorm(200)
x2 <- rbinom(200,1,.5)
y <- x1 + x2 + (2*x1*x2) + rnorm(200)
#'
#' Interactions (at least in fake data) tend to produce weird plots:
plot(y~x1)
plot(y~x2)
#' This means they also produce weird residual plots:
ols1 <- lm(y ~ x1 + x2)
plot(ols1$residuals ~ x1)
plot(ols1$residuals ~ x2)
#' For example, in the first plot we find that there are clearly two relationships between `y` and `x1`, one positive and one negative.
#' We thus want to model this using an interaction:
ols2 <- lm(y ~ x1 + x2 + x1:x2)
summary(ols2)
#' Note: This is equivalent to either of the following:
summary(lm(y ~ x1 + x2 + x1*x2))
summary(lm(y ~ x1*x2))
#' However, specifying only the interaction...
summary(lm(y ~ x1:x2))
#' produces an incomplete (and thus invalid) model.
#' Now let's figure out how to visualize this interaction based upon the complete/correct model.
#'
#'
#' ## Start with the raw data ##
#'
#' Our example data are particularly simple. There are two groups (defined by `x2`) and one covariate (`x1`).
#' We can plot these two groups separately in order to see their distributions of `y` as a function of `x1`.
#' We can index our vectors in order to plot the groups separately in red and blue:
plot(x1[x2==0], y[x2==0], col=rgb(1,0,0,.5), xlim=c(min(x1),max(x1)), ylim=c(min(y),max(y)))
points(x1[x2==1], y[x2==1], col=rgb(0,0,1,.5))
#' It is already clear that there is an interaction.
#' Let's see if we plot the estimated effects.
#'
#' ## Predicted outcomes ##
#'
#' The easiest way of examining interactions is with predicted outcomes plots.
#' We simply want to show the predicted value of the outcome based upon combinations of input variables.
#' We know that we can do this with the `predict` function applied to some new data.
#' The `expand.grid` function is help to build the necessary new data:
xseq <- seq(-5,5,length.out=100)
newdata <- expand.grid(x1=xseq,x2=c(0,1))
#' Let's build a set of predicted values for our no-interaction model:
fit1 <- predict(ols1, newdata, se.fit=TRUE, type="response")
#' Then do the same for our full model with the interaction:
fit2 <- predict(ols2, newdata, se.fit=TRUE, type="response")
#'
#' Now let's plot the original data, again.
#' Then we'll overlay it with the predicted values for the two groups.
plot(x1[x2==0], y[x2==0], col=rgb(1,0,0,.5), xlim=c(min(x1),max(x1)), ylim=c(min(y),max(y)))
points(x1[x2==1], y[x2==1], col=rgb(0,0,1,.5))
points(xseq, fit1$fit[1:100], type='l', col='red')
points(xseq, fit1$fit[101:200], type='l', col='blue')
#' The result is a plot that differentiates the absolute levels of `y` in the two groups, but forces them to have equivalent slopes.
#' We know this is wrong.
#'
#' Now let's try to plot the data with the correct fitted values, accounting for the interaction:
plot(x1[x2==0], y[x2==0], col=rgb(1,0,0,.5), xlim=c(min(x1),max(x1)), ylim=c(min(y),max(y)))
points(x1[x2==1], y[x2==1], col=rgb(0,0,1,.5))
points(xseq, fit2$fit[1:100], type='l', col='red')
points(xseq, fit2$fit[101:200], type='l', col='blue')
#' This looks better. The fitted values lines correspond nicely to the varying slopes in our two groups.
#' But, we still need to add uncertainty. Luckily, we have the necessarily information in `fit2$se.fit`.
plot(x1[x2==0], y[x2==0], col=rgb(1,0,0,.5), xlim=c(min(x1),max(x1)), ylim=c(min(y),max(y)))
points(x1[x2==1], y[x2==1], col=rgb(0,0,1,.5))
points(xseq, fit2$fit[1:100], type='l', col='red')
points(xseq, fit2$fit[101:200], type='l', col='blue')
points(xseq, fit2$fit[1:100]-fit2$se.fit[1:100], type='l', col='red', lty=2)
points(xseq, fit2$fit[1:100]+fit2$se.fit[1:100], type='l', col='red', lty=2)
points(xseq, fit2$fit[101:200]-fit2$se.fit[101:200], type='l', col='blue', lty=2)
points(xseq, fit2$fit[101:200]+fit2$se.fit[101:200], type='l', col='blue', lty=2)
#'
#'
#' We can also produce the same plot through bootstrapping.
tmpdata <- data.frame(x1=x1,x2=x2,y=y)
myboot <- function(){
    thisboot <- sample(1:nrow(tmpdata),nrow(tmpdata),TRUE)
    coef(lm(y~x1*x2,data=tmpdata[thisboot,]))
}
bootcoefs <- replicate(2500,myboot())
plot(x1[x2==0], y[x2==0], col=rgb(1,0,0,.5), xlim=c(min(x1),max(x1)), ylim=c(min(y),max(y)))
points(x1[x2==1], y[x2==1], col=rgb(0,0,1,.5))
apply(bootcoefs,2,function(coefvec) {
    points(xseq, coefvec[1] + (xseq*coefvec[2]), type='l', col=rgb(1,0,0,.01))
    points(xseq, coefvec[1] + (xseq*(coefvec[2]+coefvec[4])) + coefvec[3], type='l', col=rgb(0,0,1,.01))
    
})
points(xseq, fit2$fit[1:100], type='l')
points(xseq, fit2$fit[101:200], type='l')
points(xseq, fit2$fit[1:100]-fit2$se.fit[1:100], type='l', lty=2)
points(xseq, fit2$fit[1:100]+fit2$se.fit[1:100], type='l', lty=2)
points(xseq, fit2$fit[101:200]-fit2$se.fit[101:200], type='l', lty=2)
points(xseq, fit2$fit[101:200]+fit2$se.fit[101:200], type='l', lty=2)
#' If we overlay our previous lines of top of this, we see that they produce the same result, above.
#'
#'
#' Of course, we may want to show confidence intervals rather than SEs. And this is simple.
#' We can reproduce the graph with 95% confidence intervals, using `qnorm` to determine how much to multiple our SEs by.
plot(x1[x2==0], y[x2==0], col=rgb(1,0,0,.5), xlim=c(min(x1),max(x1)), ylim=c(min(y),max(y)))
points(x1[x2==1], y[x2==1], col=rgb(0,0,1,.5))
points(xseq, fit2$fit[1:100], type='l', col='red')
points(xseq, fit2$fit[101:200], type='l', col='blue')
points(xseq, fit2$fit[1:100]-qnorm(.975)*fit2$se.fit[1:100], type='l', lty=2, col='red')
points(xseq, fit2$fit[1:100]+qnorm(.975)*fit2$se.fit[1:100], type='l', lty=2, col='red')
points(xseq, fit2$fit[101:200]-qnorm(.975)*fit2$se.fit[101:200], type='l', lty=2, col='blue')
points(xseq, fit2$fit[101:200]+qnorm(.975)*fit2$se.fit[101:200], type='l', lty=2, col='blue')
#'
#'
#' ## Incorrect models (without constituent terms) ##
#'
#' We can also use plots to visualize why we need to include constitutive terms in our interaction models.
#' Recall that our model is defined as:
ols2 <- lm(y ~ x1 + x2 + x1:x2)
#' We can compare this to a model with only one term and the interaction:
ols3 <- lm(y ~ x1 + x1:x2)
fit3 <- predict(ols3, newdata, se.fit=TRUE, type="response")
#' And plot its results:
plot(x1[x2==0], y[x2==0], col=rgb(1,0,0,.5), xlim=c(min(x1),max(x1)), ylim=c(min(y),max(y)))
points(x1[x2==1], y[x2==1], col=rgb(0,0,1,.5))
points(xseq, fit3$fit[1:100], type='l', col='red')
points(xseq, fit3$fit[101:200], type='l', col='blue')
# We can compare these lines to those from the full model:
points(xseq, fit2$fit[1:100], type='l', col='red', lwd=2)
points(xseq, fit2$fit[101:200], type='l', col='blue', lwd=2)
#' By leaving out a term, we misestimate the effect of `x1` in both groups.
#'