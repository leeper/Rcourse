#' # Analysis of Variance #
#'
#' One of the most prominent classical statistical techniques is the Analysis of Variance (ANOVA). ANOVA is an especially important tool in experimental analysis, where it is used as an omnibus test of a null hypothesis that mean outcomes across all groups are equal (or, stated differently, that the outcome variance between groups is no larger than the outcome variance within groups).
#' This tutorial walks through the basics of using ANOVA in R. We'll start with some fake data from an imaginary three-group experiment:
set.seed(100)
tr <- rep(1:4,each=30)
y <- numeric(length=120)
y[tr==1] <- rnorm(30,5,1)
y[tr==2] <- rnorm(30,4,2)
y[tr==3] <- rnorm(30,4,5)
y[tr==4] <- rnorm(30,1,2)
#'
#' ## Omnibus test ##
#' The principle use of ANOVA is to partition the sum of squares from the data and test whether the variance across groups is larger than the variance within groups. The function to do this in R is `aov`. (Note: This should not be confused with the `anova` function, which is a model-comparison tool for regression models.)
#' ANOVA models can be expressed as formulae (like in regression, since the techniques are analogous):
aov(y~tr)
#' The default output of the `aov` function is surprisingly uninformative and we should instead use `summary` to see a more meaningful output:
summary(aov(y~factor(tr)))
#' This output is precisely what we would expect. It shows the "within" and "between" sum of squares, the F-statistic, and the p-value associated with that statistic. If significant (which it is in this case), we also see some stars to the right-hand side.
#'
#' Another way to see basically the same output is with the `oneway.test` function. It conducts a one-way ANOVA, whereas `aov` is flexible to alternative experimental designs:
oneway.test(y~tr)
#' The `oneway.test` function allows us to control whether equal variances are assumed across groups with the `var.equal` argument:
oneway.test(y~factor(tr), var.equal=TRUE)
#'
#' I always feel like the F-statistic is a bit of a let down. It's a lot of calculation to be reduced to a single number (the F-statistic), which really doesn't tell you much. Instead, we need to actually summary the data - with a table or figure - in order to actually see what that F-statistic means in practice.
#' 
#' As a non-parametric alternative to the ANOVA, which invokes a normality assumption about the residuals, one can use the Kruskal-Wallis analysis of variance test. This does not assume normality of residuals, but does assume that the treatment group outcome distributions have identical shape (other than a shift in median). To implement the Kruskal-Wallis ANOVA, we simply use `kruskal.test`:
kruskal.test(y~tr)
#' The output of this test is somewhat simpler than that from `aov`, presenting us with the test statistic and associated p-value immediately.
#'
#' For more details on assumptions about distributions, look at the tutorial on variance tests.
#' 
#' ## Post-hoc tests ##
#' Post-hoc comparisons are possible in R. The `TukeyHSD` function is available in the base **stats** package, but the **multicomp** add-on package offers much more. Other options include the **psych** package and the **car** package. In all, it's too much to cover in detail here. We'll look at the `TukeyHSD` function, which estimate's Tukey's Honestly Significant Difference statistics (for all pairwise group comparisons in an `aov` object):
TukeyHSD(aov(y~factor(tr)))
#'
#' One can always fall back on the trusty t-test (implemented with `t.test`) to compare treatment groups pairwise:
t.test(y[tr %in% 1:2] ~ tr[tr %in% 1:2])
t.test(y[tr %in% c(2,4)] ~ tr[tr %in% c(2,4)])
#' But the user should, of course, we aware of problems with multiple comparisons.
#'
#' ## Treatment group summaries ##
#' The easiest way to summarize the information underlying an ANOVA procedure is to look at the treatment group means and variances (or standard deviations). Luckily R makes it very easy to calculate this statistic on each group using the `by` function. If we want the mean of `y` for each level of `tr`, we simply call:
by(y, tr, FUN=mean)
#' The result is an output that shows the treatment level and the associated mean. We can also obtain the same information in a slightly different format using `tapply`:
tapply(y, tr, FUN=mean)
#' This returns an object of class "table", which is perhaps easier to work with. We can do the same for the treatment group standard deviations:
tapply(y, tr, FUN=sd)
#' And we could even mind them together:
out <- cbind(tapply(y, tr, FUN=mean), tapply(y, tr, FUN=sd))
colnames(out) <- c('mean','sd')
out
#' The result is a nice matrix showing the mean and standard deviation for each group. If there was some other statistic we wanted to calculate for each group, we could easily use `by` or `tapply` to obtain it.
#'
#' ## Treatment group plots ##
#' A perhaps more convenient way to see our data is to plot it. We can use `plot` to produce a simply scatterplot. And we can use our `out` matrix to highlight the treatment group means:
plot(y ~ tr, col=rgb(1,0,0,.5), pch=16)
# highlight the means:
points(1:4, out[,1], col='blue', bg='blue', pch=23, cex=2)
#' This nice because it shows the distribution of the data, but we can also use a boxplot summary to precisely see the locations of points on the distribution. Specifically, a boxplot will draw the five-number summary for each treatment group:
tapply(y,tr,fivenum)
boxplot(y~tr)
#' Another approach is to use our `out` object, containing treatment group means and standard deviations to draw a dotchart. We'll first divide our standard deviations by `sqrt(30)` to convert them to standard errors of the mean.
out[,2] <- out[,2]/sqrt(30)
dotchart(out[,1], xlim=c(0,6), xlab='y', main='Treatment group means', pch=23, bg='black')
segments(out[,1]-out[,2],1:4,out[,1]+out[,2],1:4, lwd=2)
segments(out[,1]-2*out[,2],1:4,out[,1]+2*out[,2],1:4, lwd=1)
#' This plot nicely shows the means and both 1- and 2-standard errors of the mean.
#'