# Standardized linear regression coefficients

# Sometimes people standardize regression coefficients in order to make them comparable.
# Gary King thinks this produces apples-to-oranges comparisons. He's right. It is a rare context in which these are helpful.

# Let's start with some data:
set.seed(1)
n <- 1000
x1 <- rnorm(n,-1,10)
x2 <- rnorm(n,3,2)
y <- 5*x1 + x2 + rnorm(n,1,2)

# Then we can build and summarize a standard linear regression model.
model1 <- lm(y~x1+x2)
# The summary shows us unstandardized coefficients that we typically deal with:
summary(model1)

# We might want standardized coefficients in order to make comparisons across the two input variables, which have different means and variances.
# To do this, we multiply the coefficients by the standard deviation of the input over the standard deviation of the output.
b <- summary(model1)$coef[2:3,1]
sy <- apply(model1$model[1], 2, sd)
sx <- apply(model1$model[2:3], 2, sd)
betas <- b * (sx/sy)
# The result are coefficients for `x1` and `x2` that we can interpret in the form:
# "the change in y (in standard deviations) for every standard deviation change in x"
betas

# We can obtain the same results by standardizing our variables to begin with:
yt <- (y-mean(y))/sd(y)
x1t <- (x1-mean(x1))/sd(x1)
x2t <- (x2-mean(x2))/sd(x2)
model2 <- lm(yt~x1t+x2t)

# If we compare the result of original model to the results from our manual calculation or our pre-standardized mode,
# we see that the latter two sets of coefficients are identical, but different from the first.
rbind(	model1$coef,
		model2$coef,
		c(NA,betas))
# We can see how these produce the same inference by examining the change in `y` predicted by one-SD change in `x1` from `model1`:
sd(x1)*model1$coef['x1']
# Dividing that value by the standard deviation of `y`, we obtain our standardized regression coefficient:
sd(x1)*model1$coef['x1']/sd(y)
# And the same is true for `x2`:
sd(x2)*model1$coef['x2']/sd(y)
# Thus, we obtain the same substantive inference from standardized coefficients.
# Using them is a matter of what produces the most intuitive story from the data.
