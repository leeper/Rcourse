#' # Bivariate Regression #
#'
#' ## Regression on a binary covariate ##
#' The easiest way to understand bivariate regression is to view it as equivalent to a two-sample t-test.
#' Imagine we have a binary variable (like male/female or treatment/control):
set.seed(1)
bin <- rbinom(1000,1,.5)
#' Then we have an outcome that is influenced by that group:
out <- 2*bin + rnorm(1000)
#' We can use `by` to calculate the treatment group means:
by(out, bin, mean)
#' This translates to a difference of:
diff(by(out, bin, mean))
#' A two-sample t-test shows us whether there is a significant difference between the two groups:
t.test(out~bin)
#' If we run a linear regression, we find that the mean-difference is the same as the regression slope:
lm(out~bin)
#' And t-statistic (and its significance) for the regression slope matches that from the t.test:
summary(lm(out~bin))$coef[2,]
#' It becomes quite easy to see this visually in a plot of the regression:
plot(out~bin, col='gray')
points(0:1,by(out,bin,mean),col='blue',bg='blue',pch=23)
abline(coef(lm(out~bin)), col='blue')
#'
#'
#' ## Regression on a continuous covariate ##
#' A regression involving a continuous covariate is similar, but rather than representing the difference in means between two groups (with the covariate is binary), it represents the conditional mean of the outcome at each level of the covariate.
#' We can see this in some simple fake data:
set.seed(1)
x <- runif(1000,0,10)
y <- 3*x + rnorm(1000,0,5)
#' Here, we'll cut our covariate into five levels and estimate the density of the outcome `y` in each of those levels:
x1 <- ifelse(x<2,1,ifelse(x >=2 & x<4,2,ifelse(x >=4 & x<6,3,ifelse(x >=6 & x<8,4,ifelse(x >=8 & x<10,5,NA)))))
d1 <- density(y[x1==1])
d2 <- density(y[x1==2])
d3 <- density(y[x1==3])
d4 <- density(y[x1==4])
d5 <- density(y[x1==5])
#' We'll then use those values to show how the regression models the mean of `y` conditional on `x`. Let's start with the model:
m1 <- lm(y~x)
#' And then plot:
plot(x,y, col='gray')
# add the regression equation:
abline(coef(m1), col='blue')
# add the conditional densities:
abline(v=c(1,3,5,7,9), col='gray', lty=2)
points(1+d1$y*10, d1$x, type='l', col='black')
points(3+d2$y*10, d2$x, type='l', col='black')
points(5+d3$y*10, d3$x, type='l', col='black')
points(7+d4$y*10, d4$x, type='l', col='black')
points(9+d5$y*10, d5$x, type='l', col='black')
# add points representing conditional means:
points(1,mean(y[x1==1]), col='red', pch=15)
points(3,mean(y[x1==2]), col='red', pch=15)
points(5,mean(y[x1==3]), col='red', pch=15)
points(7,mean(y[x1==4]), col='red', pch=15)
points(9,mean(y[x1==5]), col='red', pch=15)
#'
#' As is clear, the regression line travels through the conditional means of `y` at each level of `x`. We can also see in the densities that `y` is approximately normally distributed at each value of `x` (because we made our data that way). These data thus nicely satisfy the assumptions for linear regression.
#'
#' Obviously, our data rarely satisfy those assumptions so nicely. We can modify our fake data to have less desirable properties and see how that affects our inference. Let's put a discontinuity in our `y` value by simply increasing it by 10 for all values of `x` greater than 6:
y2 <- y
y2[x>6] <- y[x>6] + 10
#' We can build a new model for these data:
m2 <- lm(y2~x)
#' Let's estimate the conditional densities, as we did above, but for the new data:
e1 <- density(y2[x1==1])
e2 <- density(y2[x1==2])
e3 <- density(y2[x1==3])
e4 <- density(y2[x1==4])
e5 <- density(y2[x1==5])
#' And then let's look at how that model fits the new data:
plot(x,y2, col='gray')
# add the regression equation:
abline(coef(m2), col='blue')
# add the conditional densities:
abline(v=c(1,3,5,7,9), col='gray', lty=2)
points(1+e1$y*10, e1$x, type='l', col='black')
points(3+e2$y*10, e2$x, type='l', col='black')
points(5+e3$y*10, e3$x, type='l', col='black')
points(7+e4$y*10, e4$x, type='l', col='black')
points(9+e5$y*10, e5$x, type='l', col='black')
# add points representing conditional means:
points(1,mean(y2[x1==1]), col='red', pch=15)
points(3,mean(y2[x1==2]), col='red', pch=15)
points(5,mean(y2[x1==3]), col='red', pch=15)
points(7,mean(y2[x1==4]), col='red', pch=15)
points(9,mean(y2[x1==5]), col='red', pch=15)
#' As should be clear in the plot, the line no longer goes through the conditional means (see, especially, the third density curve) because the outcome `y` is not a linear function of `x`.
#' To obtain a better fit, we can estimate two separate lines, one on each side of the discontinuing:
m3a <- lm(y2[x<=6] ~ x[x<=6])
m3b <- lm(y2[x>6] ~ x[x>6])
#' Now let's redraw our data and the plot for `x<=6` in red and the plot for `x>6` in blue:
plot(x,y2, col='gray')
segments(0,coef(m3a)[1],6,coef(m3a)[1]+6*coef(m3a)[2], col='red')
segments(6,coef(m3b)[1]+(6*coef(m3b)[2]),10,coef(m3b)[1]+10*coef(m3b)[2], col='blue')
# redraw the densities:
abline(v=c(1,3,5,7,9), col='gray', lty=2)
points(1+e1$y*10, e1$x, type='l', col='black')
points(3+e2$y*10, e2$x, type='l', col='black')
points(5+e3$y*10, e3$x, type='l', col='black')
points(7+e4$y*10, e4$x, type='l', col='black')
points(9+e5$y*10, e5$x, type='l', col='black')
# redraw points representing conditional means:
points(1,mean(y2[x1==1]), col='red', pch=15)
points(3,mean(y2[x1==2]), col='red', pch=15)
points(5,mean(y2[x1==3]), col='red', pch=15)
points(7,mean(y2[x1==4]), col='blue', pch=15)
points(9,mean(y2[x1==5]), col='blue', pch=15)
#' Our two new models `m3a` and `m3b` are better fits to the data because they satisfy the requirement that the regression line travel through the conditional means of `y`.
#' Thus, regardless of the form of our covariate(s), our regression models only provide valid inference if the regression line travels through the conditional mean of `y` for every value of `x`.
#'
#' ## Regression on a discrete covariate ##
#' Binary and continuous covariates are easy to model, but we often have data that are not binary or continuous, but instead are categorical. Building regression models with these kinds of variables gives us many options to consider. In particular, developing a model that points through the conditional means of the outcome can be more complicated because the relationship between the outcome and a categorical covariate (if treated as continuous) is unlikely to be linear. We then have to decide how best to model the data.
#' Let's start with some fake data to illustrate this:
a <- sample(1:5, 500, TRUE)
b <- numeric(length=500)
b[a==1] <- a[a==1] + rnorm(sum(a==1))
b[a==2] <- 2*a[a==2] + rnorm(sum(a==2))
b[a==3] <- 2*a[a==3] + rnorm(sum(a==3))
b[a==4] <- .5*a[a==4] + rnorm(sum(a==4))
b[a==5] <- 2*a[a==5] + rnorm(sum(a==5))
#' Let's treat `a` as a continuous covariate, assume the a-b relationship is linear, and build the corresponding linear regression model:
n1 <- lm(b~a)
#' We can see the relationship in the data by plotting `b` as a function of `a`:
plot(a,b,col='gray')
abline(coef(n1), col='blue')
# draw points representing conditional means:
points(1,mean(b[a==1]), col='red', pch=15)
points(2,mean(b[a==2]), col='red', pch=15)
points(3,mean(b[a==3]), col='red', pch=15)
points(4,mean(b[a==4]), col='red', pch=15)
points(5,mean(b[a==5]), col='red', pch=15)
#' Clearly, the regression line misses the conditional mean values of `b` at all values of `a`. Our model is therefore not very good.
#' To correct for this, we can either (1) attempt to transform our variables to force a straight-line (which probably isn't possible in this case, but might be if the relationship were curvilinear) or (2) convert the `a` covariate to a factor and thus model the relationship as a series of indicator (or "dummy") variables.
#'
#' ## Discrete covariate as factor ##
#' When we treat a discrete covariate as a factor, R automatically transforms the variable into a series of indicator variables during the estimation of the regression. Let's compare our original model to this new model:
# our original model (treating `a` as continuous):
summary(n1)
# our new model:
n2 <- lm(b ~ factor(a))
summary(n2)
#' Obviously, the regression output is quite different for the two models. For `n1`, we see the slope of the line we drew in the plot above. For `n2`, we instead see the slopes comparing `b` for `a==1` to `b` for all other levels of `a` (i.e., dummy coefficient slopes).
#' R defaults to taking the lowest factor level as the baseline, but we can change this by reordering the levels of the factor:
# a==5 as baseline:
summary(lm(b ~ factor(a, levels=5:1)))
# a==4 as baseline:
summary(lm(b ~ factor(a, levels=c(4,1,2,3,5))))
#' Another approach is model the regression without an intercept:
# a==1 as baseline with no intercept:
n3 <- lm(b ~ 0 + factor(a))
summary(n3)
#' In this model, the coefficients are exactly the conditionals of `b` for each value of `a`:
coef(n3) # coefficients
sapply(1:5, function(x) mean(b[a==x])) # conditional means
#' All of these models produce the same substantive inference, but might simplify interpretation in any particular situation.
#'
#' ##Variable transformations ##
#' Sometimes, rather than forcing the categorical variable to be a set of indicators through the use of `factor`, we can treat the covariate as continuous once we transform it or the outcome in some way.
#' Let's start with some fake data (based on our previous example):
c <- a^3
d <- 2*a + rnorm(length(a))
#' These data have a curvilinear relationship that is not well represented by a linear regression line:
plot(c,d,col='gray')
sapply(unique(c), function(x) points(x,mean(d[c==x]),col='red',pch=15))
abline(lm(d~c))
#' As before, we can model this by treating the covariate `c` as a factor and find that model gives us the conditional means of `d`:
coef(lm(d~0+factor(c))) # coefficients
sapply(sort(unique(c)), function(x) mean(d[c==x])) # conditional means
#' We can also obtain the same substantive inference by transforming the variable(s) to produce a linear fit. In this case, we know (because we made up the data) that there is a cubic relationship between `c` and `d`. If we make a new version of the covariate `c` that is the cube-root of `c`, we should be able to force a linear fit:
c2 <- c^(1/3)
plot(c2,d, col='gray')
sapply(unique(c2), function(x) points(x,mean(d[c2==x]),col='red',pch=15))
abline(lm(d~c2))
#' We could also transform the outcome `d` by taking it cubed:
d2 <- d^3
plot(c,d2, col='gray')
sapply(unique(c), function(x) points(x,mean(d2[c==x]),col='red',pch=15))
abline(lm(d2~c))
#' Again, the plot shows this transformation also produces a linear fit. Thus we can reasonably model the relationship between a discrete covariate and a continuous outcome in a number of ways that satisfy the basic assumption of drawing the regression line through the conditional means of the outcome.
#' 