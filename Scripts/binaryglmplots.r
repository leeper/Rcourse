#' # Binary Outcome GLM Plots #
#' 
#' Unlike with linear models, interpreting GLMs requires looking at predicted values and this is often easiest to understand in the form of a plot.
#' Let's start by creating some binary outcome data in a simple bivariate model:
set.seed(1)
n <- 100
x <- runif(n,0,1)
y <- rbinom(n,1,x)
#' If we look at this data, we see that that there is a relationship between `x` and `y`, where we are more likely to observe `y==1` at higher values of `x`. We can fit a linear model to these data, but that fit is probably inappropriate, as we can see in the linear fit shown here:
plot(y~x, col=NULL, bg=rgb(0,0,0,.5), pch=21)
abline(lm(y~x), lwd=2)
#'
#' We can use the `predict` function to obtain predicted probabilities from other model fits to see if they better fit the data.
#'
#' ## Predicted probabilities for the logit model ##
#' We can start by fitting a logit model to the data:
m1 <- glm(y ~ x, family=binomial(link='logit'))
#' As with OLS, we then construct the input data over which we want to predict the outcome:
newdf <- data.frame(x=seq(0, 1, length.out = 100))
#' Because GLM relies on a link function, `predict` allows us to both extract the linear predictions as well as predicted probabilities through the inverse link. The default value for the `type` argument (`type='link'`) gives predictions on the scale of the linear predicts. For logit models, these are directly interpretable as log-odds, but we'll come back to that in a minute. When we set `type='response'`, we can obtain predicted probabilities:
newdf$pout_logit <- predict(m1, newdf, se.fit=TRUE, type='response')$fit
#' We also need to store the standard errors of the predicted probabilities and we can use those to build confidence intervals:
newdf$pse_logit <- predict(m1, newdf, se.fit=TRUE, type='response')$se.fit
newdf$pupper_logit <- newdf$pout_logit + (1.96*newdf$pse_logit) # 95% CI upper bound
newdf$plower_logit <- newdf$pout_logit - (1.96*newdf$pse_logit) # 95% CI lower bound
#' With these data in hand, it is trivial to plot the predicted probability of `y` for each value of `x`:
with(newdf, plot(pout_logit ~ x, type='l', lwd=2))
with(newdf, lines(pupper_logit ~ x, type='l', lty=2))
with(newdf, lines(plower_logit ~ x, type='l', lty=2))
#'
# ## Predicted probabilities for the probit model ##
#' We can repeat the above procedure exactly in order to obtain predicted probabilities for the probit model. All we have to change is value of `link` in our original call to `glm`:
m2 <- glm(y ~ x, family=binomial(link='probit'))
newdf$pout_probit <- predict(m2, newdf, se.fit=TRUE, type='response')$fit
newdf$pse_probit <- predict(m2, newdf, se.fit=TRUE, type='response')$se.fit
newdf$pupper_probit <- newdf$pout_probit + (1.96*newdf$pse_probit)
newdf$plower_probit <- newdf$pout_probit - (1.96*newdf$pse_probit)
#' Here's the resulting plot, which looks very similar to the one from the logit model:
with(newdf, plot(pout_probit ~ x, type='l', lwd=2))
with(newdf, lines(pupper_probit ~ x, type='l', lty=2))
with(newdf, lines(plower_probit ~ x, type='l', lty=2))
#' Indeed, we can overlay the logit model (in red) and the probit model (in blue) and see that both models provide essentially identical inference. It's also helpful to have the original data underneath to see how the predicted probabilities communicate information about the original data:
# data
plot(y~x, col=NULL, bg=rgb(0,0,0,.5), pch=21)
# logit
with(newdf, lines(pout_logit ~ x, type='l', lwd=2, col='red'))
with(newdf, lines(pupper_logit ~ x, type='l', lty=2, col='red'))
with(newdf, lines(plower_logit ~ x, type='l', lty=2, col='red'))
# probit
with(newdf, lines(pout_probit ~ x, type='l', lwd=2, col='blue'))
with(newdf, lines(pupper_probit ~ x, type='l', lty=2, col='blue'))
with(newdf, lines(plower_probit ~ x, type='l', lty=2, col='blue'))
#' Clearly, the model does an adequate job predicting `y` for high and low values of `x`, but offers a less accurate prediction for middling values.
#' Note: You can see the influence of the logistic distribution's heavier tails in its higher predicted probabilities for `y` at low values of `x` (compared to the probit model) and the reverse at high values of `x`.
#'
#' ## Log-odds predictions for logit models ##
#' As stated above, when dealing with `logit` models, we can also directly interpet the log-odds predictions from `predict`.
#' Let's take a look at these using the default `type='link'` argument in `predict`:
logodds <- predict(m1, newdf, se.fit=TRUE)$fit
#' Whereas the predicted probabilities (from above) are strictly bounded [0,1]:
summary(newdf$pout_logit)
#' the log-odds are allowed to vary over any value:
summary(logodds)
#' We can calculate standard errors, use those to build confidence intervals for the log-odds, and then plot to make a more direct interpretation:
logodds_se <- predict(m1, newdf, se.fit=TRUE)$se.fit
logodds_upper <- logodds + (1.96*logodds_se)
logodds_lower <- logodds - (1.96*logodds_se)
plot(logodds ~ newdf$x, type='l', lwd=2)
lines(logodds_upper ~ newdf$x, type='l', lty=2)
lines(logodds_lower ~ newdf$x, type='l', lty=2)
#' From this plot we can see that the log-odds of observing `y==1` are positive when `x>.5` and negative otherwise. 
#' But operating in log-odds is itself confusing because logs are fairly difficult to directly understand. Thus we can translate log-odds to odds by taking `exp` of the log-odds and redrawing the plot with the new data.
#' Recall that the odds-ratio is the ratio of the betting odds (i.e., the odds of `y==1` divided by the odds of `y==0` at each value of `x`). The odds-ratio is strictly lower bounded by 0. When the OR is 1, the ratio of the odds is equal (i.e., at that value of `x`, we are equally likely to see an observation as `y==1` or `y==0`). We saw this in the earlier plot, where the log-odds changed from negative to positive at `x==.5`. An OR greater than 1 means that the odds of `y==1` are higher than the odds of `y==0`. When less than 1, the opposite is true.
plot(exp(logodds) ~ newdf$x, type='l', lwd=2)
lines(exp(logodds_upper) ~ newdf$x, type='l', lty=2)
lines(exp(logodds_lower) ~ newdf$x, type='l', lty=2)
#' This plot shows that when `x` is low, the OR is between 0 and 1, but when `x` is high, the odds-ratio is quite large. At `x==1`, the OR is significantly larger than 1 and possibly higher than 6, suggesting that when `x==`, the odds are 6 times higher for a unit having a value of `y==1` than a value of `y==0`.
