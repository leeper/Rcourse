#' # Correlation and partial correlation #
#'
#' ## Correlation ##
#' The correlation coefficients speaks to degree to which two variables can be summarized by a straight line.
set.seed(1)
n <- 1000
x1 <- rnorm(n,-1,10)
x2 <- rnorm(n,3,2)
y <- 5*x1 + x2 + rnorm(n,1,2)

#' To obtain the correlation of two variables we simply list them consecutively:
cor(x1,x2)
#' If we want to test the significance of the correlation, we need to use the `cor.test` function:
cor.test(x1,x2)
#' To obtain a correlation matrix, we have to supply an input matrix:
cor(cbind(x1,x2,y))



#' ## Correlations of non-linear relationships ##
#'
a <- rnorm(n)
b <- a^2 + rnorm(n)
#' If we plot the relationship of `b` on `a`, we see a strong (non-linear) relationship:
plot(b~a)
#' Yet the correlation between the two variables is low:
cor(a,b)
cor.test(a,b)
#' If we can identify the functional form of the relationship, however, we can figure out what the relationship really is.
#' Clearly a linear relationship is inappropriate:
plot(b~a, col='gray')
curve((x), col='red', add=TRUE)
#' But what about `y ~ x^2` (of course, we know this is correct):
plot(b~a, col='gray')
curve((x^2), col='blue', add=TRUE)
#' The correlation between `b` and `a`^2 is thus much higher:
cor(a^2,b)
#' We can see this visually by plotting `b` against the transformed `a` variable:
plot(b ~ I(a^2), col='gray')
#' If we now overlay a linear relationship, we see how well the transformed data are represented by a line:
plot(b ~ I(a^2), col='gray')
curve((x), col='blue', add=TRUE)
#' Now let's see this side-by-side to see how the transform works:
layout(matrix(1:2,nrow=1))
plot(b~a, col='gray')
curve((x^2), col='blue', add=TRUE)
plot(b ~ I(a^2), col='gray')
curve((x), col='blue', add=TRUE)



#' ## Partial correlations ##
#'
#' An approach that is sometimes used to examine the effects of variables involves "partial correlations."
#' A partial correlation measures the strength of the linear relationship between two variables, controlling for the influence of one or more covariates.
#' For example, the correlation of  `y` and `z` is:
z <- x1 + rnorm(n,0,2)
cor(y,z)
#' This correlation might be inflated or deflated to do the common antecedent variable `x1` in both `y` and `z`.
#' Thus we may want to remove the variation due to `x1` from both `y` and `z` via linear regression:
part1 <- lm(y~x1)
part2 <- lm(z~x1)
#' The correlation of the residuals of those two models is thus the partial correlation:
cor(part1$residual,part2$residual)
#' As we can see, the correlation between these variables is actually much lower once we account for the variation attributable to `x1`.
