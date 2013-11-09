#' # OLS Goodness of Fit #
#'
#' When building regression models, one of the biggest question relates to "goodness-of-fit." How well does our model of the data (i.e., the selected predictor variables) actually "fit" the outcome data? In other words, how much of the variation in an outcome can we explain with a particular model?
#' R provides a number of useful ways of assessing model fit, some of which are common (but not necessarily good) and some which are uncommon (but probably much better).
#' To see these statistics in action, we'll build some fake data and then model using a small, bivariate model that incompletely models the data-generating process and a large, multivariate model that does so much more completely:
set.seed(100)
x1 <- runif(500,0,10)
x2 <- rnorm(500,-2,1)
x3 <- rbinom(500,1,.5)
y <- -1 + x1 + x2 + 3*x3 + rnorm(500)
#' Let's generate the bivariate model `m1` and store it and its output `sm1` for later:
m1 <- lm(y ~ x1)
sm1 <- summary(m1)
#' Then let's do the same for the multivariate model `m2` and its output `sm2`:
m2 <- lm(y ~ x1 + x2 + x3)
sm2 <- summary(m2)
#' Below we'll look at some different ways of assessing model fit.
#'
#' ## R-Squared ##
#' One measure commonly used - perhaps against better wisdom - for assessing model fit is R-squared. R-squared speaks to the proportion of variance in the outcome that can be accounted for by the model.
#' Looking at our simple bivariate model `m1`, we can extract R-squared as a measure of model fit in a number of ways. The easiest is simply to extract it from the `sm1` summary object:
sm1$r.squared
#' But we can also calculate R-squared from our data in a number of ways:
cor(y,x1)^2 # manually, as squared bivariate correlation
var(m1$fitted)/var(y) # manually, as ratio of variances
(coef(m1)[2]/ sqrt(cov(y,y)/cov(x1,x1)) )^2 # manually, as weighted regression coefficient
#'
#' Commonly, we actually use the "Adjusted R-squared" because "regular" R-squared is sensitive to the number of independent variables in the model (i.e., as we put more variables into the model, R-squared increases even if those variables are unrelated to the outcome). Adjusted R-squared attempts to correct for this by deflating R-squared by the expect amount of increase from including irrelevant additional predictors.
#' We can see this property of R-squared and Adjusted R-squared by adding two completely random variables unrelated to our other covariates or the outcome into our model and examine the impact on R-squared and Adjusted R-squared.
tmp1 <- rnorm(500,0,10)
tmp2 <- rnorm(500,0,10)
tmp3 <- rnorm(500,0,10)
tmp4 <- rnorm(500,0,10)
#' We can then compare the R-squared from our original bivariate model to that from the garbage dump model:
sm1$r.squared
summary(lm(y~x1+tmp1+tmp2+tmp2+tmp4))$r.squared
#' R-squared increased some, even though these variables are unrelated to `y`. The adjusted R-squared value also changes, but less so than R-squared:
sm1$adj.r.squared
summary(lm(y~x1+tmp1+tmp2+tmp2+tmp4))$adj.r.squared
#' So, relying on adjusted R-squared is still imperfect and, more than anything, highlights the problems of relying on R-squared (in either form) as a reliable measure of model fit.
#' Of course, when we compare the R-squared and adjusted R-squared values from our bivariate model `m1` to our fuller, multivariate model `m2`, we see appropriate increases in R-squared:
# R-squared
sm1$r.squared
sm2$r.squared
# adjusted R-squared
sm1$adj.r.squared
sm2$adj.r.squared
#' In both cases, we see that R-squared and adjusted R-squared increase. The challenge is that because R-squared depends on factors other than model fit, it is an imperfect metric.
#'
#' ## Standard Error of the Regression ##
#' A very nice way to assess model fit is the standard error of the regression (SER), sometimes just sigma. In R regression output, the value is labeled "Residual standard error" and is stored in a model summary object as `sigma`. You'll see it near the bottom of model output for the bivariate model `m1`:
sm1
sm1$sigma
#' This value captures the sum of squared residuals, over the number of degrees of freedom in the model:
sqrt(sum(residuals(m1)^2)/(m1$df.residual))
#' In other words, the value is proportionate to the standard deviation of the the model residuals. In large samples, it will converge on the standard deviation of the residuals:
sd(residuals(m1))
#' We can also see it in the multivariate model `m2`:
sm2$sigma
sqrt(sum(residuals(m2)^2)/(m2$df.residual))
#' Because sigma is a standard deviation (and not a variance), it is on the scale of the original outcome data. Thus, we can actually directly compare the standard deviation of the original outcome data `sd(y)` to the sigma of any model attepting to account for the variation in `y`. We see that our models reduce that standard deviation considerably:
sd(y)
sm1$sigma
sm2$sigma
#' Because of this inherent comparability of scale, sigma provides a much nicer measure of model fit than R-squared. It can be difficult to interpret how much better a given model fits compared to a baseline model when using R-squared (as we saw just above). By contrast, we can easily quantify the extra explanation done by a larger model by looking at sigma. We can, for example, see that the addition of several random, unrelated variables in our model does almost nothing to sigma:
sm1$sigma
summary(lm(y~x1+tmp1+tmp2+tmp2+tmp4))$sigma
#'
#' ## Formal model comparison ##
#' While we can see in the sigma values that the multivariate model fit the outcome data better than the bivariate model, the statistics alone don't supply a formal test of that between-model comparison. Typically, such comparisons are - incorrectly - made by comparing the R-squared of different models. Such comparisons are problematic because of the sensitivity of R-squared to the number of included variables (in addition to model fit).
#' We can make a formal comparison between "nested" models (i.e., models with a common outcome, where one contains a subset of the covariates of the other model and no additional coviariates). To do so, we conduct an F-test.
#' The F-test compares the fit of the larger model to the smaller model. By definition, the larger model (i.e., the one with more predictors) will always fit the data better than the smaller model. Thus, just with R-squared, we can be tempted to add more covariates simply to increase model fit even if that increase in fit is not particurly meaningful. The F-test thus compares the residuals from the larger model to the smaller model and tests whether there is a statistically significant reduction in the sum of squared residuals. We execute the test using the `anova` function:
anova(m1,m2)
#' The output suggests that our multivariate model does a much better job of fitting the data than the bivariate model, as indicated by the much larger RSS value for `m1` (listed first) and the very large F-statistic (and associated very small, heavily-starred p-value).
#' To see what's going on "under the hood," we can calculate the RSS for both models, the sum of squares, and the associated F-statistic:
sum(m1$residuals^2)                      # residual sum of squares for m1
sum(m2$residuals^2)                      # residual sum of squares for m2
sum(m1$residuals^2)-sum(m2$residuals^2)  # sum of squares
# the F-statistic
f <- ((sum(m1$residuals^2)-sum(m2$residuals^2))/sum(m2$residuals^2)) * # ratio of sum of squares
    (m2$df.residual/(m1$df.residual-m2$df.residual)) # ratio of degrees of freedom
f
# p-value (from the F distribution)
pf(f, m1$df.residual-m2$df.residual, m2$df.residual, lower.tail = FALSE)
#' Thus there are some complicated calculations being performed in order for the `anova` F-test to tell us whether the models differ in their fit. But, those calculations give us very clear inference about any improvement in model fit. Using the F-test rather than an ad-hoc comparison between (adjusted) R-squared values is a much more appropriate comparison of model fits.
#'
#' ## Quantile-Quantile (QQ) plots ##
#' Another very nice way to assess goodness of fit is to do so visually using the QQ-plot. This plot, in general, compares the distributions of two variables. In the regression context, we can use it to compare the quantiles of the outcome distribution to the quantiles of the distribution of fitted values from the model. To do this in R, we need to extracted the fitted values from our model using the `fitted` function and the `qqplot` function to do the plotting.
#' Let's compare the fit of our bivariate model to our multivariate model using two side-by-side qqplots.
layout(matrix(1:2,nrow=1))
qqplot(y,fitted(m1), col='gray', pch=15, ylim=c(-5,10), main='Bivariate model')
curve((x), col='blue', add=TRUE)
qqplot(y,fitted(m2), col='gray', pch=15, ylim=c(-5,10), main='Multivariate model')
curve((x), col='blue', add=TRUE)
#' Note: The blue lines represent a `y=x` line.
#' If the distribution of `y` and the distribution of the fitted values matched perfectly, then the gray dots would line up perflectly along the `y=x` line. We see, however, in the bivariate (underspecified) model (left panel) that the fitted values diverge considerably from the distribution of `y`. By contrast, the fitted values from our multivariate model (right panel) match the disribution of `y` much more closely. In both plots, however, the models clearly fail to precisely explain extreme values of `y`.
#' While we cannot summarize the QQ-plot as a single numeric statistic, it provides a very rich characterization of fit that shows not only how well our model fits overall, but also where in the distribution of our outcome the model is doing a better or worse job of explaining the outcome.
#'
#' Though different from a QQ-plot, we can also plot our fitted values directly again the outcome in order to see how well the model is capturing variation in the outcome. The closer this cloud of points looks to a single, straight line, the better the model fit. Such plots can also help us capture non-linearities and other things in data. Let's compare the fit of the two models side-by-side again:
layout(matrix(1:2,nrow=1))
plot(y,fitted(m1), col='gray', pch=15, ylim=c(-5,10), main='Bivariate model')
curve((x), col='blue', add=TRUE)
plot(y,fitted(m2), col='gray', pch=15, ylim=c(-5,10), main='Multivariate model')
curve((x), col='blue', add=TRUE)
#' As above, we see that the bivariate does a particularly power job of explaining extreme cases in `y`, whereas the multivariate model does much better but remains imperfect (due to random variation in `y` from when we created the data).
#'