#' # Missing data handling #
#'
#' Missing data is a pain. It creates problems for simple and complicated analyses. It also tend to undermine our ability to make valid inferences.
#' Most statistical packages tend to "brush missing data under the rug" and simply delete missing cases on the fly. This is nice because it makes analysis simple: e.g., if you want a mean of a variable with missing data, most packages drop the missing data and report the mean of the remaining values.
#' But, a different view is also credible: the assumption that we should discard missing values may be a bad assumption. For example, let's say that we want to build a regression model to explain two outcomes but those outcome variables have different patterns of missing data. If we engage in "on-the-fly" case deletion, then we end up with two models that are built on different, non-comparable subsets of the original data. We are then limited in our ability to compare, e.g., the coefficients from one model to the other because they have different data bases.
#' Choosing how to deal with missing values is thus better done as an intentional activity early in the process of data analysis rather than as an analysis-specific assumption.
#'
#' This tutorial demonstrates some basic missing data handling procedures. A separate tutorial on multiple imputation covers advanced techniques.
#'
#' ## Local NA handling ##
#' When R encounters missing data, its typical behavior is to attempt to perform the requested procedure and then returns a missing (`NA`) value as a result. We can see this if we attempt to calculate the mean of a vector containing missing data:
x <- c(1,2,3,NA,5,7,9)
mean(x)
#' R is telling us here that our vector contains missing data, so the requested statistic - the mean - is undefined for these data. If we want to do - as many statistical packages do by default - and calculate the mean by dropping the missing value, we just need to request that R remove the missing values using the `na.rm=TRUE` argument:
mean(x, na.rm=TRUE)
#' `na.rm` can be found in many R functions, such as `mean`, `median`, `sd`, `var`, and so forth.
#' One exception to this is the `summary` function when applied to a vector of data. By default it counts missing values and then reports the mean, median, and other statistics excluding those value:
summary(x)
#' Another common function that handles missing values atypically is the correlation (`cor`) function. Rather than accepting an `na.rm` argument, it has a `use` argument that specifies what set of cases to use when calculating the correlation coefficient. Its default behavior - like `mean`, `median`, etc. - is to attempt to calculate the correlation coefficient with `use="everything"`. This can result in an `NA` result:
y <- c(3,2,4,5,1,3,4)
cor(x,y)
#' The `use` argument can take several values (see `?cor`), but the two most common useful are `use="complete.obs"` and `use="pairwise.complete.obs"`. The former deletes all cases with missing values before calculating the correlation. The latter applies where trying to build a correlation matrix (i.e., correlations between more than two variables) and instead of dropping all cases with any missing data, it only drops cases from each pairwise correlation calculation. We can see this if we build a three-variable matrix:
z <- c(NA,2,3,5,4,3,4)
m <- data.frame(x,y,z)
m
cor(m) # returns all NAs
cor(m, use='complete.obs')
cor(m, use='pairwise.complete.obs')
#' Under default settings, the response is a matrix of `NA` values. With `use="complete.obs"`, the matrix `m` first has all cases with missing values removed, then the correlation matrix is produced. Whereas with `use="pairwise.complete.obs"`, the cases with missing values are only removed during the calculation of each pairwise correlation. Thus we see that the correlation between `x` and `z` is the same in both matrices but the correlation between `y` and both `x` and `z` depends on the `use` method (with dramatic effect).
#'
#' ## Regression NA handling ##
#' Another places where missing data are handled atypically is in regression modeling. If we estimate a linear regression model for our `x`, `z`, and `y` data, R will default to casewise deletion. We can see this here:
lm <- lm(y~x+z,data=m)
summary(lm)
#' The model, obviously, can only fit the model to the available data, so the resulting fitted values have a different length from the original data:
length(m$y)
length(lm$fitted)
#' Thus, if we tried to store our fitted values back into our `m` dataframe (e.g., using `m$fitted <- lm$fitted`) or plot our model residuals against the original outcome `y` (e.g., with `plot(lm$residuals ~ m$y)`), we would encounter an error.
#' This is typical of statistical packages, but highlights that we should really address missing data before we start any of our analysis.
#'
#' ## Global NA handling ##
#' How do we deal with missing data globally? Basically, we need to decide how we're going to use our missing data, if at all, then either remove cases from our data or impute missing values, and then proceed with our analysis. As mentioned, one strategy is multiple imputation, which is addressed in a separate tutorial.
#' Before we deal with missing data, it is helpful to know where it lies in our data:
#' We can look for missing data in a vector by simply wrapping it in `is.na`:
is.na(x)
#' We can also do the same for an entire dataframe:
is.na(m)
#' That works fine in our small example, but in a very large dataset, that could get quite difficult to understand. Therefore, it is helpful to visualize missing data in a plot. We can use the `image` function to visualize the `is.na(m)` matrix:
image(is.na(m), main="Missing Values", xlab='Observation', ylab='Variable', xaxt='n', yaxt='n', bty='n')
axis(1,seq(0,1,length.out=nrow(m)),1:nrow(m), col='white')
axis(2,c(0,.5,1),names(m), col='white', las=2)
#' Note: The syntax here is a little bit tricky, but it is simply to make the plot easier to understand. See `?image` for more details.
#' The plot shows we have two missing values: one in our `z` variable for observation 1 and one in our `x` variable for observation 4.
#' This plot can help us understand where our missing data is and if we systematically observe missing data for certain types of observations.
#'
#' Once we know where our missing data are, we can deal with them in some way.
#' Casewise deletion is the easiest way to deal with missing data. It simply removes all cases that have missing data anywhere in the data.
#' To do casewise deletion, we simply using the `na.omit` function on our entire dataframe:
na.omit(m)
#' In our example data, this procedure removes two rows that contain missing values.
#' Note: using `na.omit(m)` does not affect our original object `m`. To use the new dataframe, we need to save it as an object:
m2 <- na.omit(m)
#' This let's us easily go back to our original data:
m
m2
#' Another strategy is some kind of imputation. There are an endless number of options here - and the best way is probably multiple imputation, which is described elsewhere - but two ways to do simple, single imputation is to replace missing values with the means of the other values in the variable or to randomly sample from those values. The former approach (mean imputation) preserves the mean of the variable, whereas the latter approach (random imputation) preserves both the mean and variance. Both might be unreasonable, but its worth seeing how to do them:
#' To do mean imputation we simply need to identify missing values, calculate the mean of the remaining values, and store that mean into those missing value possitions:
x2 <- x
x2
is.na(x2)
x2[is.na(x2)]
mean(x2,na.rm=TRUE)
x2[is.na(x2)] <- mean(x2,na.rm=TRUE)
x2
#' To do random imputation is a bit more complicated because we need to sample the non-missing values with the `sample` function, but the process is otherwise similar:
x3 <- x
x3[!is.na(x3)] # values from which we can sample
x3[is.na(x3)] <- sample(x3[!is.na(x3)], sum(is.na(x3)), TRUE)
x3
#' Thus these two imputation strategies produce different resulting data (and those data will reflect the statistical properties of the original data to varying extents), but they mean that all subsequent analysis will not have to worry about missing values.
#'