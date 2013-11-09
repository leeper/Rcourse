#' # Ordered Outcome Models #
#'
#' This tutorial focuses on ordered outcome regression models. R's base `glm` function does not support these, but they're very easy to execute using the MASS package, which is a recommended package.
library(MASS)
#' Ordered outcome data always create a bit of tension when it comes to analysis because it presents many options for how to analyze it. For example, imagine we are looking at the effect of some independent variables on response to a survey question that measures opinion on a five-point scale from extremely supportive to extremely opposed. We could dichotomize the measure to compare support versus opposition with a binary model. We could also assume that the categories are spaced equidistant on a latent scale and simply model the outcome using a linear model. Or, finally, we could use an ordered model (e.g., ordered logit or ordered probit) to model the unobserved latent scale of the outcome without requiring that the outcome categories are equidistant on that scale. We'll focus on the last of these options here, with comparison to the binary and linear alternative specifications.
#'
#' Let's start by creating some data that have a linear relationship between an outcome `y` and two covariates `x1` and `x2`:
set.seed(500)
x1 <- runif(500,0,10)
x2 <- rbinom(500,1,.5)
y <- x1 + x2 + rnorm(500,0,3)
#' The `y` vector is our latent linear scale that we won't actually observe. Instead let's collapse the `y` variable into a new variable `y2`, which will serve as our observed data and has 5 categories. We can do this using the `cut` function:
y2 <- as.numeric(cut(y,5))
#' Now let's plot our "observed" data `y2` against our independent variables. We'll plot the values for `x2==1` and `x2==0` separately just to visualize the data. And we'll additionally fit a linear model to the data and draw separate lines for predictin `y2` for values of `x2==0` and `x2==1` (which will be parallel lines):
lm1 <- lm(y2 ~ x1 + x2)
plot(y2[x2==0] ~ x1[x2==0], col=rgb(1,0,0,.2), pch=16)
points(y2[x2==1] ~ x1[x2==1], col=rgb(0,0,1,.2), pch=16)
abline(coef(lm1)[1],coef(lm1)[2], col='red', lwd=2)
abline(coef(lm1)[1]+coef(lm1)[3],coef(lm1)[2], col='blue', lwd=2)
#' The plot actually seems like a decent fit, but let's remember that the linear model is trying to predict the conditional means if of our outcome `y2` for each value of `x` but those conditional means can be kind of meaningless when our outcome can only take specific values rather than all values. Let's redraw the plot with points for the conditional means (at 10 values of `x1`) to see the problem:
plot(y2[x2==0] ~ x1[x2==0], col=rgb(1,0,0,.2), pch=16)
points(y2[x2==1] ~ x1[x2==1], col=rgb(0,0,1,.2), pch=16)
x1cut <- as.numeric(cut(x1,10))
s <- sapply(unique(x1cut), function(i) {
    points(i, mean(y2[x1cut==i & x2==0]), col='red', pch=15)
    points(i, mean(y2[x1cut==i & x2==1]), col='blue', pch=15)
})
# redraw the regression lines:
abline(coef(lm1)[1],coef(lm1)[2], col='red', lwd=1)
abline(coef(lm1)[1]+coef(lm1)[3],coef(lm1)[2], col='blue', lwd=1)
#'
#' ## Estimating ordered logit and probit models ##
#' Overall, then, the previous approach doesn't seem to be doing that great of a job and the output of the model will be continuous values that fall outside of the set of discrete values we actually observed for `y2`. Instead, we should try an ordered model (either ordered logit or ordered probit).
#' To estimate these models we need to use the `polr` function from the MASS package. We can use the same formula interface that we used for the linear model. The default is an ordered logit model, but we can easily specify probit using a `method='probot'` argument.
#' Note: One important issue is that the outcome needs to be a "factor" class object. But we can specify this atomically in the call to `polr`:
ologit <- polr(factor(y2) ~ x1 + x2)
oprobit <- polr(factor(y2) ~ x1 + x2, method='probit')
#' Let's look at the summaries of these objects, just to get familiar with the output:
summary(ologit)
summary(oprobit)
#' The output looks similar to a linear model but now instead of a single intercept, we have a set of intercepts listed separately from the other coefficients. These intercepts speak to the points (on a latent dimension) where the outcome transitions from one category to the next. Because they're on a latent scale, they're not particularly meaningful to us.
#' Indeed, even the coefficients aren't particularly meaningful. Unlike in OLS, these are not directly interpretable. So let's instead look at some predicted probabilities.
#' 
#' ## Predicted outcomes for ordered models ##
#' Predicted probabilities can be estimated in the same way for ordered models as for binary GLMs. We simply need to create some covariate data over which we want to estimate predicted probabilities and then run `predict`. We'll use `expand.grid` to create our `newdata` dataframe because we have two covariates and it simplifies creating data at each possible level of both variables.
newdata <- expand.grid(seq(0,10,length.out=100),0:1)
names(newdata) <- c('x1','x2')
#' When estimating outcomes we can actually choose between getting the discrete fitted class (i.e., which value of the outcome is most likely at each value of covariates) or the predicted probabilities. We'll get both for the logit model just to compare:
plogclass <- predict(ologit, newdata, type='class')
plogprobs <- predict(ologit, newdata, type='probs')
#' If we look at the `head` of each object, we'll see that when `type='class'`, the result is a single vector of discete fitted values, whereas when `type='probs'`, the response is a matrix where (for each observation in our new data) the predicted probability of being in each outcome category is specified.
head(plogclass)
head(plogprobs)
#' Note: The predicted probabilities necessarily sum to 1 in ordered models:
rowSums(plogprobs)
#'
#' The easiest way to make sense of these predictions is through plotting.
#' Let's start by plotting the original data and then overlying, as horizontal lines, the predicted classes for each value of `x1` and `x2`:
plot(y2[x2==0] ~ x1[x2==0], col=rgb(1,0,0,.2), pch=16, xlab='x1', ylab='y')
points(y2[x2==1] ~ x1[x2==1], col=rgb(0,0,1,.2), pch=16)
s <- sapply(1:5, function(i) 
    lines(newdata$x1[plogclass==i & newdata$x2==0], as.numeric(plogclass)[plogclass==i & newdata$x2==0]+.1, col='red', lwd=3))
s <- sapply(1:5, function(i) 
    lines(newdata$x1[plogclass==i & newdata$x2==1], as.numeric(plogclass)[plogclass==i & newdata$x2==1]-.1, col='blue', lwd=3))
#' Note: We've drawn the predicted classes separately for `x2==0` (red) and `x2==1` (blue) and offset them vertically to see their values and the underlying data.
#' The above plot shows, for each combination of values of `x1` and `x2`, what the most likely category to observe for `y2` is. Thus, where one horizontal bar ends, the next begins (i.e., the blue bars do not overlap each other and neither do the red bars). You'll also note for these data that the predictions are never expected to be in `y==1` or `y==5`, even though some of our observed `y` values are.
#'
#' ## Predicted probabilities for ordered models ##
#' Now that we've seen the fitted classes, we should acknowledge that we have some uncertainty about those classes. It's simply the most likely class for each observation to take, but there is a defined probability that we'll see values in each of the other `y` classes. We can see this if we plot our predicted probability object `plogprobs`.
#' We'll plot predicted probabilities when `x2==0` on the left and when `x2==1` on the right. The colored lines represent the predicted probability of falling in each category of `y2` (in rainbow order, so that red represents `y2==1` and purple represents `y2==5`). We'll draw a thick horizontal line at the bottom of the plot representing the predicted classes at each value of `x1` and `x2`:
layout(matrix(1:2,nrow=1))
# plot for `x2==0`
plot(NA, xlim=c(min(x1),max(x1)), ylim=c(0,1), xlab='x1 (x2==0)', ylab='Predicted Probability (Logit)')
s <- mapply(function(i, col) lines(newdata$x1[newdata$x2==0], plogprobs[newdata$x2==0,i], lwd=1, col=col), 1:5, rainbow(5))
# optional horizontal line representing predicted class
s <- mapply(function(i,col)
    lines(newdata$x1[plogclass==i & newdata$x2==0], rep(0,length(newdata$x1[plogclass==i & newdata$x2==0])), col=col, lwd=3),
    1:5, rainbow(5))
# plot for `x2==1`
plot(NA, xlim=c(min(x1),max(x1)), ylim=c(0,1), xlab='x1 (x2==1)', ylab='Predicted Probability (Logit)')
s <- mapply(function(i, col) lines(newdata$x1[newdata$x2==1], plogprobs[newdata$x2==1,i], lwd=1, col=col), 1:5, rainbow(5))
# optional horizontal line representing predicted class
s <- mapply(function(i,col)
    lines(newdata$x1[plogclass==i & newdata$x2==1], rep(0,length(newdata$x1[plogclass==i & newdata$x2==1])), col=col, lwd=3),
    1:5, rainbow(5))
#' We can see that the predicted probability curves strictly follow the logistic distribution (due to our use of a logit model). The lefthand plot also shows what we noted in the earlier plot: when `x2==0`, the model never predicts `y2==5`.
#'
#' Note: We can redraw the same plot using prediction values from our ordered probit model and obtain essentially the same inference:
oprobprobs <- predict(oprobit, newdata, type='probs')
layout(matrix(1:2,nrow=1))
plot(NA, xlim=c(min(x1),max(x1)), ylim=c(0,1), xlab='x1 (x2==0)', ylab='Predicted Probability (Probit)')
s <- mapply(function(i, col) lines(newdata$x1[newdata$x2==0], oprobprobs[newdata$x2==0,i], lwd=1, col=col), 1:5, rainbow(5))
plot(NA, xlim=c(min(x1),max(x1)), ylim=c(0,1), xlab='x1 (x2==1)', ylab='Predicted Probability (Probit)')
s <- mapply(function(i, col) lines(newdata$x1[newdata$x2==1], oprobprobs[newdata$x2==1,i], lwd=1, col=col), 1:5, rainbow(5))
#'
#' ## Alternative predicted probability plot ##
#' Though the above plot predicted probabilities plots communicate a lot of information. We can also present predicted probabilities in a different way. Because we use ordered outcome regression models when we believe the outcome has a meaningful ordinal scale, it may make sense to present the predicted probabilities stacked on top of one another as a "stacked area chart" (since they sum to 1 for every combination of covariates) to differently communicate the relative probability of being in each outcome class at each combination of covariates. To do this, we need to write a little bit of code to prep our data.
#' Specifically, our `plogprobs` object is a matrix where, for each row, the columns are predicted probabilities of being in each category of the outcome. In order to plot them stacked on top of one another, we need the value in each column to instead be the cumulative probability (calculated left-to-right across the matrix). Luckily R has some nice built in function to do this. `cumsum` returns the cumulative sum at each position of a vector. We can use `apply` to calculate this cumulative sum for each row of the `plogprobs` matrix, and then we simply need to transpose that result using the `t` function to simply some things later on. Let's try it out:
cumprobs <- t(apply(plogprobs, 1, cumsum))
head(cumprobs)
#' Note: The cumulative probabilities will always be 1 for category 5 because rows sum to 1.
#' To plot this, we simply need to draw these new values on our plot. We'll again separate data for `x2==0` from `x2==1`.
layout(matrix(1:2,nrow=1))
plot(NA, xlim=c(min(x1),max(x1)), ylim=c(0,1), xlab='x1 (x2==0)', ylab='Cumulative Predicted Probability (Logit)')
s <- mapply(function(i, col) lines(newdata$x1[newdata$x2==0], cumprobs[newdata$x2==0,i], lwd=1, col=col), 1:5, rainbow(5))
plot(NA, xlim=c(min(x1),max(x1)), ylim=c(0,1), xlab='x1 (x2==1)', ylab='Cumulative Predicted Probability (Logit)')
s <- mapply(function(i, col) lines(newdata$x1[newdata$x2==1], cumprobs[newdata$x2==1,i], lwd=1, col=col), 1:5, rainbow(5))
#' The result is a stacked area chart showing the cumulative probability of being in a set of categories of `y`. If we think back to the first example at the top of this tutorial - about predicting opinions on a five-point scale - we could interpret the above plot as the cumulative probability of, e.g., opposing the issue. If `y==1` (red) and `y==2` (yellow) represent strong and weak opposition, respectively, we could interpret the above lefthand plot as saying that when `x1==0`, there is about a 40% chance that an individual strongly opposes and an over 90% chance that they will oppose strongly or weakly.
#' This plot makes it somewhat more difficult to figure out what the most likely outcome category is, but it helps for making these kind of cumulative prediction statements. To see the most likely category, we have to visually estimate the widest vertical distance between lines at any given values of `x1`, which can be tricky.
#'
#' We can also use the `polygon` plotting function to draw areas rather than lines, which produces a slight different effect:
layout(matrix(1:2,nrow=1))
plot(NA, xlim=c(min(x1),max(x1)), ylim=c(0,1), xlab='x1 (x2==0)', ylab='Cumulative Predicted Probability (Logit)', bty='l')
s <- mapply(function(i, col)
    polygon(c(newdata$x1[newdata$x2==0],rev(newdata$x1[newdata$x2==0])),
        c(cumprobs[newdata$x2==0,i],rep(0,length(newdata$x1[newdata$x2==0]))), lwd=1, col=col, border=col),
    5:1, rev(rainbow(5)))
plot(NA, xlim=c(min(x1),max(x1)), ylim=c(0,1), xlab='x1 (x2==1)', ylab='Cumulative Predicted Probability (Logit)', bty='l')
s <- mapply(function(i, col)
    polygon(c(newdata$x1[newdata$x2==1],rev(newdata$x1[newdata$x2==1])),
        c(cumprobs[newdata$x2==1,i],rep(0,length(newdata$x1[newdata$x2==1]))), lwd=1, col=col, border=col),
    5:1, rev(rainbow(5)))
#' Note: We draw the polygons in reverse order so that the lower curves are drawn on top of the higher curves.
#' 