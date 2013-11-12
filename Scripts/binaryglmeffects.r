#' # Binary Outcome GLM Effects Plots #
#'
#' This tutorial draws aims at making various binary outcome GLM models interpretable through the use of plots. As such, it begins by setting up some data (involving a few covariates) and then generating various versions of an outcome based upon data-generating proceses with and without interaction. The aim of the tutorial is to both highlight the use of predicted probability plots for demonstrating effects and demonstrate the challenge - even then - of clearly communicating the results of these types of models.
#'
#' Let's begin by generating our covariates:
set.seed(1)
n <- 200
x1 <- rbinom(n,1,.5)
x2 <- runif(n,0,1)
x3 <- runif(n,0,5)
#'
#' Now, we'll build several models. Each model has an outcome that is a transformed linear function the covariates (i.e., we calculate a `y` variable that is a linear function of the covariates, then rescale that outcome [0,1], and use the rescaled version as a probability model in generating draws from a binomial distribution).
# Simple multivariate model (no interaction):
y1 <- 2*x1 + 5*x2 + rnorm(n,0,3)
y1s <- rbinom(n,1,(y1-min(y1))/(max(y1)-min(y1))) # the math here is just to rescale to [0,1]
# Simple multivariate model (with interaction):
y2 <- 2*x1 + 5*x2 + 2*x1*x2 + rnorm(n,0,3)
y2s <- rbinom(n,1,(y2-min(y2))/(max(y2)-min(y2)))
# Simple multivariate model (with interaction and an extra term):
y3 <- 2*x1 + 5*x2 + 2*x1*x2 + x3 + rnorm(n,0,3)
y3s <- rbinom(n,1,(y2-min(y2))/(max(y2)-min(y2)))
#'
#' We thus have three outcomes (`y1s`, `y2s`, and `y3s`) that are binary outcomes, but each is constructed as a slightly different function of our three covariates.
#' We can then build models of each outcome. We'll build two versions of `y2s` and `y3s` (one version `a` that does not model the interaction and another version `b` that does model it):
m1 <- glm(y1s ~ x1 + x2, family=binomial(link='probit'))
m2a <- glm(y2s ~ x1 + x2, family=binomial(link='probit'))
m2b <- glm(y2s ~ x1*x2, family=binomial(link='probit'))
m3a <- glm(y1s ~ x1 + x2 + x3, family=binomial(link='probit'))
m3b <- glm(y1s ~ x1*x2 + x3, family=binomial(link='probit'))
#'
#' We can look at the outcome of one of our models, e.g. `m3b` (for `y3s` modelled with an interaction), but we know that the coefficients are not directly interpretable:
summary(m3b)
#'
#' Instead we need to look at fitted values (specifically, the predicted probability of observing `y==1` in each model. We can see these fitted values for our actual data using the `predict` function:
p3b.fitted <- predict(m3b,type='response',se.fit=TRUE)
p3b.fitted
#' We can even draw a small plot showing the predicted values separately for levels of `x1` (recall that `x1` is a binary/indicator variable):
plot(NA,xlim=c(0,1), ylim=c(0,1), xlab='x2', ylab='Predicted Probability of y=1')
points(x2[x1==0], p3b.fitted$fit[x1==0], col=rgb(1,0,0,.5))
points(x2[x1==1], p3b.fitted$fit[x1==1], col=rgb(0,0,1,.5))
#' But this graph doesn't show the fit of the model to all values of `x1` and `x2` (or `x3`) and doesn't communicate any of our uncertainty.
#'
#' ## Predicted Probability Plots ##
#' To get a better grasp on our models, we'll create some fake data representing the full scales of `x1`, `x2`, and `x3`:
newdata1 <- expand.grid(x1=0:1,x2=seq(0,1,length.out=10))
newdata2 <- expand.grid(x1=0:1,x2=seq(0,1,length.out=10),x3=seq(0,5,length.out=25))
#' We can then use these new fake data to generate predicted probabilities of each outcome at each combination of covarites:
p1 <- predict(m1,newdata1,type='response', se.fit=TRUE)
p2a <- predict(m2a,newdata1,type='response', se.fit=TRUE)
p2b <- predict(m2b,newdata1,type='response', se.fit=TRUE)
p3a <- predict(m3a,newdata2,type='response', se.fit=TRUE)
p3b <- predict(m3b,newdata2,type='response', se.fit=TRUE)
#' We can look at one of these objects, e.g. `p3b`, to see that we have predicted probabilities and associated standard errors:
p3b
#' It is then relatively straight forward to plot the predicted probabilities for all of our data. We'll start with the simple models, then look at the models with interactions and the additional covariate `x3`.
#'
#' ### Simple, no-interaction model ###
plot(NA,xlim=c(0,1), ylim=c(0,1), xlab='x2', ylab='Predicted Probability of y=1')
# `x1==0`
lines(newdata1$x2[newdata1$x1==0], p1$fit[newdata1$x1==0], col='red')
lines(newdata1$x2[newdata1$x1==0], p1$fit[newdata1$x1==0]+1.96*p1$se.fit[newdata1$x1==0], col='red', lty=2)
lines(newdata1$x2[newdata1$x1==0], p1$fit[newdata1$x1==0]-1.96*p1$se.fit[newdata1$x1==0], col='red', lty=2)
# `x1==1`
lines(newdata1$x2[newdata1$x1==1], p1$fit[newdata1$x1==1], col='blue')
lines(newdata1$x2[newdata1$x1==1], p1$fit[newdata1$x1==1]+1.96*p1$se.fit[newdata1$x1==1], col='blue', lty=2)
lines(newdata1$x2[newdata1$x1==1], p1$fit[newdata1$x1==1]-1.96*p1$se.fit[newdata1$x1==1], col='blue', lty=2)
#' The above plot shows two predicted probability curves with heavily overlapping confidence bands. While the effect of `x2` is clearly different from zero for both `x1==0` and `x1==1`, the difference between the two curves is not significant.
#' But this model is based on data with no underlying interaction. Let's look next at the outcome that is a function of an interaction between covariates.
#'
#' ### Interaction model ###
#' Recall that the interaction model (with outcome `y2s`) was estimated in two different ways. The first estimated model did not account for the interaction, while the second estimated model did account for the interaction. Let's see the two models side-by-side to compare the inference we would draw about the interaction:
# Model estimated without interaction
layout(matrix(1:2,nrow=1))
plot(NA,xlim=c(0,1), ylim=c(0,1), xlab='x2', ylab='Predicted Probability of y=1', main='Estimated without interaction')
# `x1==0`
lines(newdata1$x2[newdata1$x1==0], p2a$fit[newdata1$x1==0], col='red')
lines(newdata1$x2[newdata1$x1==0], p2a$fit[newdata1$x1==0]+1.96*p2a$se.fit[newdata1$x1==0], col='red', lty=2)
lines(newdata1$x2[newdata1$x1==0], p2a$fit[newdata1$x1==0]-1.96*p2a$se.fit[newdata1$x1==0], col='red', lty=2)
# `x1==1`
lines(newdata1$x2[newdata1$x1==1], p2a$fit[newdata1$x1==1], col='blue')
lines(newdata1$x2[newdata1$x1==1], p2a$fit[newdata1$x1==1]+1.96*p2a$se.fit[newdata1$x1==1], col='blue', lty=2)
lines(newdata1$x2[newdata1$x1==1], p2a$fit[newdata1$x1==1]-1.96*p2a$se.fit[newdata1$x1==1], col='blue', lty=2)
# Model estimated with interaction
plot(NA,xlim=c(0,1), ylim=c(0,1), xlab='x2', ylab='Predicted Probability of y=1', main='Estimated with interaction')
# `x1==0`
lines(newdata1$x2[newdata1$x1==0], p2b$fit[newdata1$x1==0], col='red')
lines(newdata1$x2[newdata1$x1==0], p2b$fit[newdata1$x1==0]+1.96*p2b$se.fit[newdata1$x1==0], col='red', lty=2)
lines(newdata1$x2[newdata1$x1==0], p2b$fit[newdata1$x1==0]-1.96*p2b$se.fit[newdata1$x1==0], col='red', lty=2)
# `x1==1`
lines(newdata1$x2[newdata1$x1==1], p2b$fit[newdata1$x1==1], col='blue')
lines(newdata1$x2[newdata1$x1==1], p2b$fit[newdata1$x1==1]+1.96*p2b$se.fit[newdata1$x1==1], col='blue', lty=2)
lines(newdata1$x2[newdata1$x1==1], p2b$fit[newdata1$x1==1]-1.96*p2b$se.fit[newdata1$x1==1], col='blue', lty=2)
#' The lefthand model leads us to some incorrect inference. Both predicted probability curves are essentially identical, suggesting that the influence of `x2` is constant at both levels of `x1`. This is because our model did not account for any interaction.
#' The righthand model leads us to substantially different inference. When `x1==0` (shown in red), there appears to be almost no effect of `x2`, but when `x1==1`, the effect of `x2` is strongly positive.
#'
#' ### Model with additional covariate ###
#' When we add an additional covariate to the model, things become much more complicated. Recall that the predicted probabilities have to be calculated on some value of each covariate. In other words, we have to define the predicted probability in terms of all of the covariates in the model. Thus, when we add an additional covariate (even if it does not interact with our focal covariates `x1` and `x2`), we need to account for it when estimating our predicted probabilities. We'll see this at work when we plot the predicted probabilities for our (incorrect) model estimated without the `x1*x2` interaction and in our (correct) model estimated with that interaction.
#' No-Interaction model with an additional covariate
plot(NA,xlim=c(0,1), ylim=c(0,1), xlab='x2', ylab='Predicted Probability of y=1')
s <- sapply(unique(newdata2$x3), function(i) {
    # `x1==0`
    lines(newdata2$x2[newdata2$x1==0 & newdata2$x3==i], p3a$fit[newdata2$x1==0 & newdata2$x3==i], col=rgb(1,0,0,.5))
    lines(newdata2$x2[newdata2$x1==0 & newdata2$x3==i],
          p3a$fit[newdata2$x1==0 & newdata2$x3==i]+1.96*p3a$se.fit[newdata2$x1==0 & newdata2$x3==i], col=rgb(1,0,0,.5), lty=2)
    lines(newdata2$x2[newdata2$x1==0 & newdata2$x3==i],
          p3a$fit[newdata2$x1==0 & newdata2$x3==i]-1.96*p3a$se.fit[newdata2$x1==0 & newdata2$x3==i], col=rgb(1,0,0,.5), lty=2)
    # `x1==1`
    lines(newdata2$x2[newdata2$x1==1 & newdata2$x3==i], p3a$fit[newdata2$x1==1 & newdata2$x3==i], col=rgb(0,0,1,.5))
    lines(newdata2$x2[newdata2$x1==1 & newdata2$x3==i],
          p3a$fit[newdata2$x1==1 & newdata2$x3==i]+1.96*p3a$se.fit[newdata2$x1==1 & newdata2$x3==i], col=rgb(0,0,1,.5), lty=2)
    lines(newdata2$x2[newdata2$x1==1 & newdata2$x3==i],
          p3a$fit[newdata2$x1==1 & newdata2$x3==i]-1.96*p3a$se.fit[newdata2$x1==1 & newdata2$x3==i], col=rgb(0,0,1,.5), lty=2)
})
#' Note how the above code is much more complicated than previously because we now need to draw a separate predicted probability curve (with associated confidence interval) at each level of `x3` even though we're not particularly interested in `x3. The result is a very confusing plot because the predicted probability curves at each level of `x3` are the essentially the same, but the confidence intervals vary widely because of different levels of certainty due to the sparsity of the original data.
#'
#' One common response is to simply draw the curve conditional on all other covariates (in this case `x3`) being at their means, but this is an arbitrary choice. We could also select minimum or maximum, or any other value. Let's write a small function to redraw our curves at different values of `x3` to see the impact of this choice:
ppcurve <- function(value_of_x3,title){
    tmp <- expand.grid(x1=0:1,x2=seq(0,1,length.out=10),x3=value_of_x3)
    p3tmp <- predict(m3a,tmp,type='response', se.fit=TRUE)
    plot(NA,xlim=c(0,1), ylim=c(0,1), xlab='x2', ylab='Predicted Probability of y=1', main=title)
    # `x1==0`
    lines(tmp$x2[tmp$x1==0], p3tmp$fit[tmp$x1==0], col='red')
    lines(tmp$x2[tmp$x1==0], p3tmp$fit[tmp$x1==0]+1.96*p3tmp$se.fit[tmp$x1==0], col='red', lty=2)
    lines(tmp$x2[tmp$x1==0], p3tmp$fit[tmp$x1==0]-1.96*p3tmp$se.fit[tmp$x1==0], col='red', lty=2)
    # `x1==1`
    lines(tmp$x2[tmp$x1==1], p3tmp$fit[tmp$x1==1], col='blue')
    lines(tmp$x2[tmp$x1==1], p3tmp$fit[tmp$x1==1]+1.96*p3tmp$se.fit[tmp$x1==1], col='blue', lty=2)
    lines(tmp$x2[tmp$x1==1], p3tmp$fit[tmp$x1==1]-1.96*p3tmp$se.fit[tmp$x1==1], col='blue', lty=2)
}
#' We can then draw a plot that shows the curves for the mean of `x3`, the minimum of `x3` and the maximum of `x3`.
layout(matrix(1:3,nrow=1))
ppcurve(mean(x3), title='x3 at mean')
ppcurve(min(x3), title='x3 at min')
ppcurve(max(x3), title='x3 at max')
#' The above set of plots show that while the inference about the predicted probability curves is the same, the choice of what value of `x3` to condition on is meaningful for the confidence intervals. The confidence intervals are much narrower when we condition on the mean value of `x3` than the minimum or maximum.
#'
#' Recall that this model did not properly account for the `x1*x2` interaction. Thus while our inference is somewhat sensitive to the choice of conditioning value of the `x3` covariate, it is unclear if this minimal sensitivity holds when we properly account for the interaction. Let's take a look at our `m3b` model that accounts for the interaction.
#'
#' ### Interaction model with additional covariate ###
#' Let's start by drawing a plot showing the predicted values of the outcome for every combination of `x1`, `x2`, and `x3`:
plot(NA,xlim=c(0,1), ylim=c(0,1), xlab='x2', ylab='Predicted Probability of y=1')
s <- sapply(unique(newdata2$x3), function(i) {
    # `x1==0`
    lines(newdata2$x2[newdata2$x1==0 & newdata2$x3==i], p3b$fit[newdata2$x1==0 & newdata2$x3==i], col=rgb(1,0,0,.5))
    lines(newdata2$x2[newdata2$x1==0 & newdata2$x3==i],
          p3b$fit[newdata2$x1==0 & newdata2$x3==i]+1.96*p3b$se.fit[newdata2$x1==0 & newdata2$x3==i], col=rgb(1,0,0,.5), lty=2)
    lines(newdata2$x2[newdata2$x1==0 & newdata2$x3==i],
          p3b$fit[newdata2$x1==0 & newdata2$x3==i]-1.96*p3b$se.fit[newdata2$x1==0 & newdata2$x3==i], col=rgb(1,0,0,.5), lty=2)
    # `x1==1`
    lines(newdata2$x2[newdata2$x1==1 & newdata2$x3==i], p3b$fit[newdata2$x1==1 & newdata2$x3==i], col=rgb(0,0,1,.5))
    lines(newdata2$x2[newdata2$x1==1 & newdata2$x3==i],
          p3b$fit[newdata2$x1==1 & newdata2$x3==i]+1.96*p3b$se.fit[newdata2$x1==1 & newdata2$x3==i], col=rgb(0,0,1,.5), lty=2)
    lines(newdata2$x2[newdata2$x1==1 & newdata2$x3==i],
          p3b$fit[newdata2$x1==1 & newdata2$x3==i]-1.96*p3b$se.fit[newdata2$x1==1 & newdata2$x3==i], col=rgb(0,0,1,.5), lty=2)
})
#' This plot is incredibly messy. Now, not only our the confidence bands sensitive to what value of `x3` we condition on, so too are the predicted probability curves themselves. It is therefore a fairly important decision what level of additional covariates to condition on when estimating the predicted probabilities.
#'
#'
#' ## Marginal Effects Plots ##
#' A different approach when deal with interactions is to show marginal effects. Marginal effect, I think, are a bit abstract (i.e., a bit removed from the actual data because they attempt to summarize a lot of information in a single number). The marginal effect is the slope of the curve drawn by taking the difference between, e.g., the predicted probability that `y==1` when `x1==1` and the predicted probability that `y==` when `x1==0`, at each level of `x2`. Thus, the marginal effect is simply the slope of the difference between the two curves that we were drawing in the above graphs (i.e., the slope of the change in predicted probabilities). Of course, we just saw, if any additional covariate(s) are involved in the data-generating process, then the marginal effect - like the predicted probabilities - is going to differ across levels of that covariate.
#'
#' ### Simple interaction model without additional covariates ###
#' Let's see how this works by first returning to our simple interaction model (without `x3`) and then look at the interaction model with the additional covariate.
#'
#' To plot the change in predicted probabilities due to `x1` across the values of `x2`, we simply need to take our predicted probabilities from above and difference the values predicted for `x1==0` and `x1==1`. The predicted probabilities for our simple interaction model are stored in `p2b`, based on new data from `newdata1`. Let's separate out the values predicted from `x1==0` and `x1==1` and then take their difference. Let's create a new dataframe that binds `newdata1` and the predicted probability and standard error values from `p2b` together. Then we'll use the `split` function to that dataframe based upon the value of `x1`.
tmpdf <- newdata1
tmpdf$fit <- p2b$fit
tmpdf$se.fit <- p2b$se.fit
tmpsplit <- split(tmpdf,tmpdf$x1)
#' The result is a list of two dataframes, each containing values of `x1`, `x2`, and the associated predicted probabilities:
tmpsplit
#' To calculate the change in predicted probabilty of `y==1` due to `x1==1` at each value of `x2`, we'll simply difference the the `fit` variable from each dataframe:
me <- tmpsplit[[2]]$fit-tmpsplit[[1]]$fit
me
#' We also want the standard error of that difference:
me_se <- sqrt(.5*(tmpsplit[[2]]$se.fit+tmpsplit[[1]]$se.fit))
#'
#' Now Let's plot the original predicted probability plot on the left and the change in predicted probability plot on the right:
layout(matrix(1:2,nrow=1))
plot(NA,xlim=c(0,1), ylim=c(0,1), xlab='x2', ylab='Predicted Probability of y=1', main='Predicted Probabilities')
# `x1==0`
lines(newdata1$x2[newdata1$x1==0], p2b$fit[newdata1$x1==0], col='red')
lines(newdata1$x2[newdata1$x1==0], p2b$fit[newdata1$x1==0]+1.96*p2b$se.fit[newdata1$x1==0], col='red', lty=2)
lines(newdata1$x2[newdata1$x1==0], p2b$fit[newdata1$x1==0]-1.96*p2b$se.fit[newdata1$x1==0], col='red', lty=2)
# `x1==1`
lines(newdata1$x2[newdata1$x1==1], p2b$fit[newdata1$x1==1], col='blue')
lines(newdata1$x2[newdata1$x1==1], p2b$fit[newdata1$x1==1]+1.96*p2b$se.fit[newdata1$x1==1], col='blue', lty=2)
lines(newdata1$x2[newdata1$x1==1], p2b$fit[newdata1$x1==1]-1.96*p2b$se.fit[newdata1$x1==1], col='blue', lty=2)
# plot of change in predicted probabilities:
plot(NA, type='l', xlim=c(0,1), ylim=c(-1,1),
     xlab='x2', ylab='Change in Predicted Probability of y=1', main='Change in Predicted Probability due to x1')
abline(h=0, col='gray') # gray line at zero
lines(tmpsplit[[1]]$x2, me, lwd=2) # change in predicted probabilities
lines(tmpsplit[[1]]$x2, me-1.96*me_se, lty=2)
lines(tmpsplit[[1]]$x2, me+1.96*me_se, lty=2)
#' As should be clear, the plot on the right is simply a further information reduction of the lefthand plot. Where the separate predicted probabilities show the predicted probability of the outcome at each combination of `x1` and `x2`, the righthand plot simply shows the difference between these two curves.
#'
#' The marginal effect of `x2` is thus a further information reduction: it is the slope of the line showing the difference in predicted probabilities.
#' Because our `x2` variable is scaled [0,1], we can see the marginal effect simply by subtracting the value of change in predicted probabilities when `x2==0` from the value of change in predicted probabilities when `x2==1`, which is simply:
me[length(me)]-me[1]
#' Thus the marginal effect of `x1` on the outcome, is the slope of the line representing the change in predicted probabilities between `x1==1` and `x1==0` across the range of `x2`. I don't find that a particularly intuitive measure of effect and would instead prefer to draw some kind of plot rather than reduce that plot to a single number.
#'
#' ### Simple interaction model without additional covariates ###
#' Things get more complicated, as we might expect, when we have to account for the additional covariate `x3`, which influenced our predicted probabilities above. Our predicted probabilies for these data are stored in `p3b` (based on input data in `newdata2`). We'll follow the same procedure just used to add those predicted probabilities into a dataframe with the variables from `newdata2`, then we'll split it based on `x1`:
tmpdf <- newdata2
tmpdf$fit <- p3b$fit
tmpdf$se.fit <- p3b$se.fit
tmpsplit <- split(tmpdf,tmpdf$x1)
#' The result is a list of two large dataframes:
str(tmpsplit)
#'
#' Now, we need to calculate the change in predicted probability within each of those dataframes, at each value of `x3`. That is tedious. So let's instead split by both `x1` and `x3`:
tmpsplit <- split(tmpdf,list(tmpdf$x3,tmpdf$x1))
#' The result is a list of 50 dataframes, the first 25 of which contain data for `x1==0` and the latter 25 of which contain data for `x1==1`:
length(tmpsplit)
names(tmpsplit)
#' We can then calculate our change in predicted probabilities at each level of `x1` and `x3`. We'll use the `mapply` function to do this quickly:
change <- mapply(function(a,b) b$fit - a$fit, tmpsplit[1:25], tmpsplit[26:50])
#' The resulting object `change` is a matrix, each column of which is the change in predicted probability at each level of `x3`. We can then use this matrix to plot each change in predicted probability on a single plot.
#' Let's again draw this side-by-side with the predicted probability plot:
layout(matrix(1:2,nrow=1))
# predicted probabilities
plot(NA,xlim=c(0,1), ylim=c(0,1), xlab='x2', ylab='Predicted Probability of y=1', main='Predicted Probabilities')
s <- sapply(unique(newdata2$x3), function(i) {
    # `x1==0`
    lines(newdata2$x2[newdata2$x1==0 & newdata2$x3==i], p3b$fit[newdata2$x1==0 & newdata2$x3==i], col=rgb(1,0,0,.5))
    lines(newdata2$x2[newdata2$x1==0 & newdata2$x3==i],
          p3b$fit[newdata2$x1==0 & newdata2$x3==i]+1.96*p3b$se.fit[newdata2$x1==0 & newdata2$x3==i], col=rgb(1,0,0,.5), lty=2)
    lines(newdata2$x2[newdata2$x1==0 & newdata2$x3==i],
          p3b$fit[newdata2$x1==0 & newdata2$x3==i]-1.96*p3b$se.fit[newdata2$x1==0 & newdata2$x3==i], col=rgb(1,0,0,.5), lty=2)
    # `x1==1`
    lines(newdata2$x2[newdata2$x1==1 & newdata2$x3==i], p3b$fit[newdata2$x1==1 & newdata2$x3==i], col=rgb(0,0,1,.5))
    lines(newdata2$x2[newdata2$x1==1 & newdata2$x3==i],
          p3b$fit[newdata2$x1==1 & newdata2$x3==i]+1.96*p3b$se.fit[newdata2$x1==1 & newdata2$x3==i], col=rgb(0,0,1,.5), lty=2)
    lines(newdata2$x2[newdata2$x1==1 & newdata2$x3==i],
          p3b$fit[newdata2$x1==1 & newdata2$x3==i]-1.96*p3b$se.fit[newdata2$x1==1 & newdata2$x3==i], col=rgb(0,0,1,.5), lty=2)
})
# change in predicted probabilities
plot(NA, type='l', xlim=c(0,1), ylim=c(-1,1),
     xlab='x2', ylab='Change in Predicted Probability of y=1', main='Change in Predicted Probability due to x1')
abline(h=0, col='gray')
apply(change,2,function(a) lines(tmpsplit[[1]]$x2, a))
#' As we can see, despite the craziness of the left-hand plot, the marginal effect of `x1` is actually not affected by `x3` (which makes sense because it is not interacted with `x3` in the data-generating process). Thus, while the choice of value of `x3` on which to estimated the predicted probabilities matters, the marginal effect is constant. We can estimate it simply by following the same procedure above from any column of our `change` matrix:
change[nrow(change),1]-change[1,1]
#' The result here is a negligible marginal effect, which is what we would expect given the lack of an interaction between `x1` and `x3` in the underlying data. If such an interaction were in the actual data, then we should expect that this marginal effect would vary across values of `x3` and we would need to further state the marginal effect as conditional on a particular value of `x3`.
#'