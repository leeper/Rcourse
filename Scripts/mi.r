#' # Multiple imputation #
#'
#' This tutorial covers techniques of multiple imputation. Multiple imputation is a strategy for dealing with missing data. Whereas we typically (i.e., automatically) deal with missing data through casewise deletion of any observations that have missing values on key variables, imputation attempts to replace missing values with an estimated value. In single imputation, we guess that missing value one time (perhaps based on the means of observed values, or a random sampling of those values). In multiple imputation, we instead draw multiple values for each missing value, effectively building multiple datasets, each of which replaces the missing data in a different way. There are numerous algorithms for this, each of which builds those multiple datasets in different ways. We're not going to discuss the details here, but instead focus on executing multiple imputation in R. The main challenge of multiple imputation is not the analysis (it simply proceeds as usual on each imputed dataset) but instead the aggregation of those separate analyses. The examples below discuss how to do this.
#'
#' To get a basic feel for the process, let's imagine that we're trying to calculate the mean of a vector of values that contains missing values. We can impute the missing values by drawing from the observed values, repeat the process several times, and then average across the estimated means to get an estimate of the mean with a measure of uncertainty that accounts for the uncertainty due to imputation.
#' Let's create a vector of ten values, seven of which we observe and three of which are missing, and imagine that they are random draws from the population whose mean we're trying to estimate:
set.seed(10)
x <- c(sample(1:10,7,TRUE),rep(NA,3))
x
#' We can find the mean using case deletion:
mean(x,na.rm=TRUE)
#' Our estimate of the sample standard error is then:
sd(x,na.rm=TRUE)/sqrt(sum(!is.na(x)))
#' Now let's impute several times to generate a list of imputed vectors:
imp <- replicate(15,c(x[!is.na(x)],sample(x[!is.na(x)],3,TRUE)), simplify=FALSE)
imp
#' The result is a list of five vectors. The first seven values of each is the same as our original data, but the three missing values have been replaced with different combinations of the observed values.
#' To get our new estimated maen, we simply take the mean of each vector, and then average across them:
means <- sapply(imp, mean)
means
grandm <- mean(means)
grandm
#' The result is 4.147, about the same as our original estimate.
#' To get the standard error of our multiple imputation estimate, we need to combine the standard errors of each of our estimates, so that means we need to start by getting the SEs of each imputed vector:
ses <- sapply(imp, sd)/sqrt(10)
#' Aggregating the standard errors is a bit complicated, but basically sums the mean of the SEs (i.e., the "within-imputation variance") with the variance across the different estimated means (the "between-imputation variance"). To calculate the within-imputation variance, we simply average the SE estimates:
within <- mean(ses)
#' To calculate the between-imputation variance, we calculate the sum of squared deviations of each imputed mean from the grand mean estimate:
between <- sum((means-grandm)^2)/(length(imp)-1)
#' Then we sum the within- and between-imputation variances (multiply the latter by a small correction):
grandvar <- within + ((1+(1/length(imp)))*between)
grandse <- sqrt(grandvar)
grandse
#' The resulting standard error is interesting because we increase the precision of our estimate by using 10 rather than 7 values (and standard errors are proportionate to sample size), but is larger than our original standard error because we have to account for uncertainty due to imputation. Thus if our missing values are truly missing at random, we can get a better estimate that is actually representative of our original population.
#' Most multiple imputation algorithms are, however, applied to multivariate data rather than a single data vector and thereby use additional information about the relationship between observed values and missingness to reach even more precise estimates of target parameters.
#'
#' There are three main R packages that offer multiple imputation techniques. Several other packages - described in the [OfficialStatistics](http://cran.r-project.org/web/views/OfficialStatistics.html) Task View - supply other imputation techniques, but packages **Amelia** (by Gary King and collaborators), **mi** (by Andrew Gelman and collaborators), and **mice** (by Stef van Buuren and collaborators) provide more than enough to work with.
#' Let's start by installing these packages:
install.packages(c('Amelia','mi','mice'),repos='http://cran.r-project.org')
#'
#' Now, let's consider an imputation situation where we plan to conduct a regression analysis predicting `y` by two covariates: `x1` and `x2` but we have missing data in `x1` and `x2`. Let's start by creating the dataframe:
x1 <- runif(100,0,5)
x2 <- rnorm(100)
y <- x1 + x2 + rnorm(100)
mydf <- cbind.data.frame(x1,x2,y)
#' Now, let's randomly remove some of the observed values of the independent variables:
mydf$x1[sample(1:nrow(mydf),20,FALSE)] <- NA
mydf$x2[sample(1:nrow(mydf),10,FALSE)] <- NA
#' The result is the removal of thirty values, 20 from `x1` and 10 from `x2`:
summary(mydf)
#' If we estimate the regression on these data, R will force casewise deletion of 28 cases:
lm <- lm(y~x1+x2,data=mydf)
summary(lm)
#' We should thus be quite skeptical of our results given taht we're discarding a substantial portion of our observations (28%, in fact).
#' Let's see how the various multiple imputation packages address this and affect our inference.
#'
#'
#' ## Amelia ##
library(Amelia)
#' 
imp.amelia <- amelia(mydf)
#' Once we've run our multiple imputation, we can see where are missing data lie:
missmap(imp.amelia)
#' We can also run our regression model on each imputed dataset. We'll use the `lapply` function to do this quickly on each of the imputed dataframes:
lm.amelia.out <- lapply(imp.amelia$imputations, function(i) lm(y~x1+x2,data=i))
#' If we look at `lm.amelia.out` we'll see the results of the model run on each imputed dataframe separately:
lm.amelia.out
#' To aggregate across the results is a little bit tricky because we have to extract the coefficients and standard errors from each model, format them in a particular way, and then feed that structure into the `mi.meld` function:
coefs.amelia <- do.call(rbind, lapply(lm.amelia.out, function(i) coef(summary(i))[,1]))
ses.amelia <- do.call(rbind, lapply(lm.amelia.out, function(i) coef(summary(i))[,2]))
mi.meld(coefs.amelia, ses.amelia)
#' Now let's compare these results to those of our original model:
t(do.call(rbind, mi.meld(coefs.amelia, ses.amelia)))
coef(summary(lm))[,1:2] # original results
#'
#'
#' ## mi ##
library(mi)
#' It is incredibly issue to conduct our multiple imputation using the `mi` function:
imp.mi <- mi(mydf)
#' Let's start by visualizing the missing data:
image(imp.mi)
summary(imp.mi)
#' The results above report how many imputed datasets were produced and summarizes some of the results we saw above.
#' For linear regression (and several other common models), the **mi** package includes functions that automatically run the model on each imputed dataset and aggregate the results:
lm.mi.out <- mi::pool(y~x1+x2, data = imp.mi, m = 5)
#' We can extract the results using the following:
coef.mi <- coef(lm.mi.out)
# or see them quickly with:
display(lm.mi.out)
#' Let's compare these results to our original model:
coef.mi # multiply imputed results
coef(summary(lm))[,1L] # original results
#'
#'
#' ## mice ##
library(mice)
#' To conduct the multiple imputation, we simply need to run the `mice` function:
imp.mice <- mice(mydf)
#' We can see some summary information about the imputation process:
summary(imp.mice)
#' To run our regression we use the `lm` function wrapped in a `with` call, which estimates our model on each imputed dataframe:
lm.mice.out <- with(imp.mice, lm(y~x1+x2))
summary(lm.mice.out)
#' The results above are for each separate dataset. But, to pool them, we use `pool`:
pool.mice <- pool(lm.mice.out)
#' Let's compare these results to our original model:
summary(pool.mice) # multiply imputed results
coef(summary(lm))[,1:2] # original results
#'
#'
#' ## Comparing packages ##
#' It is useful at this point to compare the coefficients from each of our multiple imputation methods. To do so, we'll pull out the coefficients from each of the three packages' results, our original observed results (with case deletion), and the results for the real data-generating process (before we introduced missingness).
#' **Amelia** package results
s.amelia <- t(do.call(rbind, mi.meld(coefs.amelia, ses.amelia)))
#' **mi** package results
s.mi <- do.call(cbind, coef.mi) # multiply imputed results
#' **mice** package results
s.mice <- summary(pool.mice)[,1:2] # multiply imputed results
#' Original results (case deletion)
s.orig <- coef(summary(lm))[,1:2] # original results
#' Real results (before missingness was introduced)
s.real <- summary(lm(y~x1+x2))$coef[,1:2]
#' Let's print the coefficients together to compare them:
allout <- cbind(s.real[,1], s.amelia[,1], s.mi[,1], s.mice[,1], s.orig[,1])
colnames(allout) <- c('Real Relationship','Amelia','MI','mice','Original')
allout
#' All three of the multiple imputation models - despite vast differences in underlying approaches to imputation in the three packages - yield strikingly similar inference. This was a relatively basic and all of the packages offer a number of options for more complicated situations than what we examined here.
#' While executing multiple imputation requires choosing a package and typing some potentially tedious code, the results are almost always going to be better than doing the easier thing of deleting cases and ignoring the consequences thereof.
#' 