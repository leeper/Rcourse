# Basic Univariate Statistics

# R is obviously a statistical programming language and environment, so we can use it to do statistics.
# With any vector, we can calculate a number of statistics, including:
set.seed(1)
a <- rnorm(100)

# mininum
min(a)
# maximum
max(a)
# We can get the minimum and maximum together with `range`:
range(a)

# We can also obtain the minimum by sorting the vector (using `sort`):
sort(a)[1]
# And we can obtain the maximum by sorting in the opposite order:
sort(a,decreasing=TRUE)[1]

# To calculate the central tendency, we have several options.
# mean
mean(a)
# median
median(a)

# We can also obtain measures of dispersion:
# Variance
var(a)
# Standard deviation
sd(a)

# There are also some convenience functions that provide multiple statistics.
# The `fivenum` function provides the five-number summary (minimum, Q1, median, Q3, and maximum):
fivenum(a)

# It is also possible to obtain arbitrary percentiles/quantiles from a vector:
quantile(a,.1)  # 10% quantile
# You can also specify a vector of quantiles:
quantile(a,c(.025,0.975))



# Summary
# The `summary` function, applied to a numeric vector, provides those values and the mean:
summary(a)
# Note: The `summary` function returns different results if the vector is a logical, character, or factor.
# For a logical vector, `summary` returns some tabulations:
summary(as.logical(rbinom(100,1,.5)))
# For a character vector, `summary` returns just some basic information about the vector:
summary(sample(c("a","b","c"),100,TRUE))
# For a factor, `summary` returns a table of all values in the vector:
summary(factor(a))

# A `summary` of a dataframe will return the summary information separate for each column vector.
# This may look produce different result for each column, depending on the class of the column:
summary(data.frame(a=1:10,b=11:20))
summary(data.frame(a=1:10,b=factor(11:20)))

# A `summary` of a list will return not very useful information:
summary(list(a=1:10,b=1:10))

# A `summary` of a matrix returns a summary of each column separately (like a dataframe):
summary(matrix(1:20,nrow=4))

