#' # Scale construction #
#' 
#' One of the most common analytic tasks is creating variables. For example, we have some variable that we need to use in the analysis, but we want it to have a mean of zero or be confined to [0,1]. Alternatively, we might have a large number of indicators that we need to aggregate into a single variable.
#' When we used R as a calculator, we learned that R is "vectorized". This means that when we call a function like add (`+`), it adds each respective element of two vectors together. For example:
(1:3) + (10:12)
#' This returns a three-element vector that added each corresponding element of the two vectors together.
#' We also should remember R's tendency to use "recyling":
(1:3) + 10
#' Here, the second vector only has one element, so R assumes that you want to add 10 to each element of the first vector (as opposed to adding 10 to the first element and nothing to the second and third elements).
#' This is really helpful for preparing data vectors because it means we can use mathematical operators (addition, subtraction, multiplication, division, powers, logs, etc.) for their intuitive purposes when trying to create new variables rather than having to rely on obscure function names.
#' But R also has a number of other functions for building variables.
#'
#' Let's examine all of these features using some made-up data. In this case, we'll create a dataframe of indicator variables (coded 0 and 1) and build them into various scales.
set.seed(1)
n <- 30
mydf <- data.frame(x1 = rbinom(n,1,.5), 
                   x2 = rbinom(n,1,.1),
                   x3 = rbinom(n,1,.5),
                   x4 = rbinom(n,1,.8),
                   x5 = 1,
                   x6 = sample(c(0,1,NA),n,TRUE))
#' Let's use `str` and `summary` to get a quick sense of the data:
str(mydf)
summary(mydf)
#' All variables are coded 0 or 1, `x5` is all 1's, and `x6` contains some missing data (`NA`) values.
#'
#' ## Simple scaling ##
#' The easiest scales are those that add or substract variables. Let's try that quick:
mydf$x1 + mydf$x2
mydf$x1 + mydf$x2 + mydf$x3
mydf$x1 + mydf$x2 - mydf$x3
#' One way to save some typing is to use the `with` command, which simply tells R which dataframe to look in for variables:
with(mydf, x1 + x2 - x3)
#' A faster way to take a rowsum is to use `rowSums`:
rowSums(mydf)
#' Because we have missing data, any row that has an NA results in a sum of `0`. We could either skip that column:
rowSums(mydf[,1:5])
#' or use the `na.rm=TRUE` argument to skip `NA` values when calculating the sum:
rowSums(mydf, na.rm=TRUE)
#' or we could look at a reduced dataset, eliminating all rows from the result that have a missing value:
rowSums(na.omit(mydf))
#' but this last option can create problems if we try to store the result back into our original data (since it has fewer elements than the original dataframe has rows).
#'
#' We can also multiply (or divide) across variables. For these indicator variables, that applies an AND logic to tell us if *all* of the variables are 1:
with(mydf, x3*x4*x5)
#' We might also want to take an average value across all the columns, which we could do by hand:
with(mydf, x1+x2+x3+x4+x5+x6)/6
#' or use the `rowSums` function from earlier:
rowSums(mydf)/6
#' or use the even simpler `rowMeans` function:
rowMeans(mydf)
#'
#' If we want to calculate some other kind of function, like the variance, we can use the `apply` function:
apply(mydf,1,var) # the `1` refers to rows
#'
#' We can also make calculations for columns (though this is less common in rectangular data unless we're trying to create summary statistics):
rowSums(mydf)
rowMeans(mydf)
apply(mydf,2,var) # the `2` refers to columns
sapply(mydf,var) # another way to apply a function to columns
#'
#' ## Using indexing in building scales ##
#' Sometimes we need to build a scale with a different formula for subsets of a dataset. For example, we want to calculate a scale in one way for men and a different way for women (or something like that).
#' We can use indexing to achieve this. We can start by creating an empty variable with the right number of elements (i.e., the number of rows in our dataframe):
newvar <- numeric(nrow(mydf))
#' Then we can store values into this conditional on a variable from our dataframe:
newvar[mydf$x1==1] <- with(mydf[mydf$x1==1,], x2+x3)
newvar[mydf$x1==0] <- with(mydf[mydf$x1==0,], x3+x4+x5)
#' The key to making that work is using the same index on the new variable as on the original data. Doing otherwise would produce a warning about mismatched lengths:
newvar[mydf$x1==1] <- with(mydf, x2+x3)
#'