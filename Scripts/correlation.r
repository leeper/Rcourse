# Correlation and partial correlation

# Correlation
# The correlation coefficients speaks to degree to which two variables can be summarized by a straight line.
set.seed(1)
n <- 1000
x1 <- rnorm(n,-1,10)
x2 <- rnorm(n,3,2)
y <- 5*x1 + x2 + rnorm(n,1,2)

# To obtain the correlation of two variables we simply list them consecutively:
cor(x1,x2)
# To obtian a correlation matrix, we have to supply an input matrix:
cor(cbind(x1,x2,y))


# cor.test


# TALK ABOUT CORRELATIONS OF NON-LINEAR RELATIONSHIPS.




# Partial correlations
# An approach that is sometimes used to examine the effects of variables involves "partial correlations."
# A partial correlation measures the strength of the linear relationship between two variables, controlling for the influence of one or more covariates.
# For example, the correlation of  `y` and `z` is:
z <- x1 + rnorm(n,0,2)
cor(y,z)
# This correlation might be inflated or deflated to do the common antecedent variable `x1` in both `y` and `z`.
# Thus we may want to remove the variation due to `x1` from both `y` and `z` via linear regression:
part1 <- lm(y~x1)
part2 <- lm(z~x1)
# The correlation of the residuals of those two models is thus the partial correlation:
cor(part1$residual,part2$residual)
# As we can see, the correlation between these variables is actually much lower once we account for the variation attributable to `x1`.
