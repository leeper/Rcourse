# OLS in matrix form

# The matrix representation of OLS is (X'X)^(-1)(X'Y).
# Representing this in R is simple.

set.seed(1)
n <- 20
x1 <- rnorm(n)
x2 <- rnorm(n)
x3 <- rnorm(n)
X <- cbind(x1,x2,x3)
y <- x1 + x2 + x3 + rnorm(n)

# To transpose a matrix, we use the `t` function:
X
t(X)
# To multiply two matrices, we use the `%*%` matrix multiplication operator:
t(X) %*% X
# To invert a matrix, we use the `solve` function:
solve(t(X) %*% X)
# Now let's put all of that together:
solve(t(X) %*% X) %*% t(X) %*% y

# Now let's compare it to the `lm` function:
lm(y ~ x1 + x2 + x3)$coef
# The numbers are close, but they're not quite right.
# The reason is that we forgot to include the intercept in our matrix calculation.
# If we use `lm` again but leave out the intercept, we'll see this is the case:
lm(y ~ 0 + x1 + x2 + x3)$coef
# To include the intercept in matrix form, we need to add a vector of 1's to the matrix:
X2 <- cbind(1,X) # this uses vector recycling
# Now we redo our math:
solve(t(X2) %*% X2) %*% t(X2) %*% y
# And compare to our full model using `lm`:
lm(y ~ x1 + x2 + x3)$coef
# The result is exactly what we would expect.
