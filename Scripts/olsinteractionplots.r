# OLS interaction plots

# Interactions are important, but they're hard to understand without visualization.
# This script works through how to visualize interactions in linear regression models.


# Plots for identifying interactions
set.seed(1)
x1 <- rnorm(1000)
x2 <- rbinom(1000,1,.5)
y <- x1 + x2 + (2*x1*x2) + rnorm(1000)

# Interactions (at least in fake data) tend to produce weird plots:
plot(y~x1)
plot(y~x2)
# This means they also produce weird residual plots:
ols1 <- lm(y ~ x1 + x2)
plot(ols1$residuals ~ x1)
plot(ols1$residuals ~ x2)
# For example, in the first plot we find that there are clearly two relationships between `y` and `x1`, one positive and one negative.
# We thus want to model this using an interaction:
ols2 <- lm(y ~ x1 + x2 + x1:x2)
summary(ols2)
# Note: This is equivalent to either of the following:
summary(lm(y ~ x1 + x2 + x1*x2))
summary(lm(y ~ x1*x2))
# However, specifying only the interaction...
summary(lm(y ~ x1:x2))
# produces an incomplete (and thus invalid) model.
# Now let's figure out how to visualize this interaction based upon the complete/correct model.



# Predicted outcomes
# The easiest way of examining interactions is with predicted outcomes plots.
# We simply want to show the predicted value of the outcome based upon combinations of input variables.



# Marginal effects
# A common way of examining interactions is with marginal effects.
# Note: I am somewhat skeptical of these plots, but many people like them, so we'll learn about them.

