# Regression-related plotting

# R's graphical capabilities are very strong. This is particularly helpful when deal with regression.

# If we have a regression model, there are a number of ways we can plot the relationships between variables.
# We can also use plots for checking model specification and assumptions.

# Let's start with a basic bivariate regression:
set.seed(1)
x <- rnorm(1000)
y <- 1 + x + rnorm(1000)
ols1 <- lm(y~x)

# The easiest plot we can draw is the relationship between y and x:
plot(y~x)
# We can also add a line representing this relationship to the plot.
# To get the coefficients from the model, we can use `coef`:
coef(ols1)
# We can then use those coefficients in the line-plotting function `abline`:
abline(a=coef(ols1)[1], b=coef(ols1)[2])

# We can specify "graphical parameters" in both `plot` and `abline` to change the look.
# For example, we could change the color:
plot(y~x, col='gray')
abline(a=coef(ols1)[1], b=coef(ols1)[2], col='red')

# We can also use `plot` to extract several diagnostics for our model.
# Almost all of these help us to identify outliers or other irregularities.
# If we type:
plot(ols1)
# We are given a series of plots describing the model. We can also see two other plots that are not displayed by default.
# To obtain a given plot, we use the `which` parameter inside `plot`:
plot(ols1, which=4)
# (1) A residual plot
# (2) A Quantile-Quantile plot to check the distribution of our residuals
# (3) A scale-location plot
# (4) Cook's distance, to identify potential outliers
# (5) A residual versus leverage plot, to identify potential outliers
# (6) Cook's distance versus leverage plot


# Besides the default `plot(ols1, which=1)` to get residuals, we can also plot residuals manually:
plot(ols1$residuals ~ x)
# We might want to do this to check whether another variable should be in our model:
x2 <- rnorm(1000)
plot(ols1$residuals ~ x2)
# Obviously, in this case `x2` doesn't belong in the model.
# Let's see a case where the plot would help us:
y2 <- x + x2 + rnorm(1000)
ols2 <- lm(y2 ~ x)
plot(ols2$residuals ~ x2)
# Clearly, `x2` is strongly related to our residuals, so it belongs in the model.


# We can also use residuals plots to check for nonlinear relationships (i.e., functional form):
y3 <- x + (x^2) + rnorm(1000)
ols3 <- lm(y3 ~ x)
plot(ols3$residuals ~ x)
# Even though `x` is in our model, it is not in the correct form.
# Let's try fixing that and see what happens to our plot:
ols3b <- lm(y3 ~ x + I(x^2))
# Note: We need to use the `I()` operator inside formulae in order to have R generate the `x^2` variable!
# Note (continued): This saves us from having to defined a new variable: `xsq <- x^2` and then running the model.
plot(ols3b$residuals ~ x)
# Clearly, the model now incorporates `x` in the correct functional form.

# Of course, if we had plotted our data originally:
plot(y3 ~ x)
# We would have seen the non-linear relationship and could have skipped the incorrect model entirely.


# Residual plots can also show heteroskedasticity
x3 <- runif(1000,1,10)
y4 <- (3*x3) + rnorm(1000,0,x3)
ols4 <- lm(y4 ~ x3)
plot(ols4$residuals ~ x3)
# Here we see that `x3` is correctly specified in the model. There is no relationship between `x3` and `y4`.
# But, the variance of the residuals is much higher at higher levels of `x3`.
# We might need to rely on a different estimate of our regression SEs than the default provided by R.
# And, again, this is a problem we could have identified by plotting our original data:
plot(y4 ~ x3)


# Multivariate OLS plotting
# If our model has more than one independent variable, these plotting tools all still work.
set.seed(1)
x5 <- rnorm(1000)
z5 <- runif(1000,1,5)
y5 <- x5 + z5 + rnorm(1000)
ols5 <- lm(y5 ~ x5 + z5)
# We can see all six of our diagnostic plots:
plot(ols5, 1:6)
# We can plot our outcome against the input variables:
plot(y5 ~ x5)
plot(y5 ~ z5)
# We can see residual plots:
plot(ols5$residuals ~ x5)
plot(ols5$residuals ~ z5)

# We might also want to check for colinearity between our input variables.
# We could do this with `cor`:
cor(x5,z5)
# Or we could see it visually with a scatterplot:
plot(x5,z5)
# In either case, there's no relationship.

# We can also plot our effects from our model against our input data:
coef(ols5)
# Lets plot the two input variables together using `layout`:
layout(matrix(1:2, ncol=2))
plot(y5 ~ x5, col='gray')
abline(a=coef(ols5)[1]+mean(z5), b=coef(ols5)['x5'], col='red')
plot(y5 ~ z5, col='gray')
abline(a=coef(ols5)[1]+mean(x5), b=coef(ols5)['z5'], col='red')
# Note: We add the expected value of the other input variable so that lines are drawn correctly.
# If we plot each bivariate relationship separately, we'll see how we get the lines of best fit:
ols5a <- lm(y5 ~ x5)
ols5b <- lm(y5 ~ z5)
layout(matrix(1:2, ncol=2))
plot(y5 ~ x5, col='gray')
abline(a=coef(ols5a)[1], b=coef(ols5a)['x5'], col='red')
plot(y5 ~ z5, col='gray')
abline(a=coef(ols5b)[1], b=coef(ols5b)['z5'], col='red')
# If we regress the residuals from `ols5a` on `z5` we'll see some magic happen.
# The estimated coefficient for `z5` is almost identical to that from our full `y5 ~ x5 + z5` model:
tmpz <- lm(ols5a$residuals ~ z5)
coef(tmpz)['z5']
coef(ols5)['z5']
# The same pattern works if we repeat this process for our `x5` input variable:
tmpx <- lm(ols5b$residuals ~ x5)
coef(tmpx)['x5']
coef(ols5)['x5']
# In other words, the coefficients from our full model `ols5` reflect the regression of each input variable...
# on the residuals of `y` unexplained by the contribution of the other input variable(s).
# Let's see this visually by drawing the bivariate regression lines in blue.
# And then overlapping these with the full model estimates in red:
layout(matrix(1:2, ncol=2))
plot(y5 ~ x5, col='gray')
abline(a=coef(ols5a)[1], b=coef(ols5a)['x5'], col='blue')
abline(a=coef(ols5)[1]+mean(z5), b=coef(ols5)['x5'], col='red')
plot(y5 ~ z5, col='gray')
coef(lm(ols5a$residuals ~ z5))['z5']
abline(a=coef(ols5b)[1], b=coef(ols5b)['z5'], col='blue')
abline(a=coef(ols5)[1]+mean(x5), b=coef(ols5)['z5'], col='red')

# In that example, `x5` and `z5` were uncorrelated, so there was no bias from excluding one variable.
# Let's look at a situation where we find omitted variable bias due to correlation between input variables.
set.seed(1)
x6 <- rnorm(1000)
z6 <- x6 + rnorm(1000,0,1.5)
y6 <- x6 + z6 + rnorm(1000)
# We can see from a plot and correlation and that our two input variables are correlated:
cor(x6,z6)
plot(x6,z6)
# Let's estimate some models:
ols6 <- lm(y6 ~ x6 + z6)
ols6a <- lm(y6 ~ x6)
ols6b <- lm(y6 ~ z6)
# And then let's compare the bivariate estimates (blue) to the multivariate estimates (red):
layout(matrix(1:2, ncol=2))
plot(y6 ~ x6, col='gray')
abline(a=coef(ols6a)[1], b=coef(ols6a)['x6'], col='blue')
abline(a=coef(ols6)[1]+mean(z6), b=coef(ols6)['x6'], col='red')
plot(y6 ~ z6, col='gray')
coef(lm(ols6a$residuals ~ z6))['z6']
abline(a=coef(ols6b)[1], b=coef(ols6b)['z6'], col='blue')
abline(a=coef(ols6)[1]+mean(x6), b=coef(ols6)['z6'], col='red')
# As we can see, the estimates from our bivariate models overestimate the impact of each input.
# We could of course see this in the raw coefficients, as well:
coef(ols6); coef(ols6a); coef(ols6b)
# These plots show, however, that omitted variable bias can be dangerous even when it seems our estimates are correct.
# The blue lines seem to fit the data, but those simple plots (and regressions) fail to account for correlations between inputs.

# And the problem is that you can't predict omitted variable bias a priori.
# Let's repeat that last analysis but simply change the data generating process slightly:
set.seed(1)
x6 <- rnorm(1000)
z6 <- x6 + rnorm(1000,0,1.5) 
y6 <- x6 - z6 + rnorm(1000) # this is the only differences from the previous example
cor(x6,z6)
ols6 <- lm(y6 ~ x6 + z6)
ols6a <- lm(y6 ~ x6)
ols6b <- lm(y6 ~ z6)
layout(matrix(1:2, ncol=2))
plot(y6 ~ x6, col='gray')
abline(a=coef(ols6a)[1], b=coef(ols6a)['x6'], col='blue')
abline(a=coef(ols6)[1]+mean(z6), b=coef(ols6)['x6'], col='red')
plot(y6 ~ z6, col='gray')
coef(lm(ols6a$residuals ~ z6))['z6']
abline(a=coef(ols6b)[1], b=coef(ols6b)['z6'], col='blue')
abline(a=coef(ols6)[1]+mean(x6), b=coef(ols6)['z6'], col='red')
# The blue lines seem to fit the data, but they're biased estimates.
