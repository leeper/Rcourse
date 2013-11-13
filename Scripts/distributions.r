#' # Probability distributions #
#'
#' A critical aspect of (parametric) statistical analysis is the use of probability distributions, like the normal (Gaussian) distribution. These distributions underly all of our common (parametric) statistical tests, like t-tests, chi-squared tests, ANOVA, regression, and so forth. R has functions to draw values from all of the common distributions (normal, t, F, chi-squared, binomial, poisson, etc.), as well as many others.
#'
#' There are four families of functions that R implements uniformly across each of these distributions that enable users to extract the probability density, the cumulative density, and the quantiles of a distribution. For example, the `dnorm` function provides the density of the normal distribution at a specific quantile. The `pnorm` function provides the cumulative density of the normal distribution at a specific quantile. The `qnorm` function provides the quantile of the normal distribution at a specified cumulative density. An additional function, `rnorm`, draws random values from the normal distribution (but this is discussed in detail in the random sampling tutorial).
#'
#' The same functions are also implemented for the other common distributions. For example, the functions for Student's t distribution are `dt`, `pt`, and `qt`. For the chi-squared distribution, they are `dchisq`, `pchisq`, and `qchisq`. Hopefully you see the pattern. The rest of this tutorial walks through how to use these functions.
#'
#' ## Density functions ##
#' The density functions provide the density of a specified distribution at a given quantile. This means that the `d*` family of functions can extract the density not just from a given distribution but from any version of the distribution. For example, calling:
dnorm(0)
#' provides the density of the standard normal distribution (i.e., a normal distribution with mean 0 and standard deviation 1) at the point 0 (i.e., at the distribution's mean). We can retrieve the density at a different value (or vector of values) easily:
dnorm(1)
dnorm(1:3)
#' We can also retrieve densities from a different normal distribution (e.g., one with a higher mean or larger SD):
dnorm(1, mean=-2)
dnorm(1, mean=5)
dnorm(1, mean=0, sd=3)
#'
#' ## Cumulative distribution functions ##
#' We are often much more interested in the cumulative distribution (i.e., how much of the distribution is to the left of the indicated value). For this, we can use the `p*` family of functions.
#' As an example, let's obtain the cumulative distribution function's value from a standard normal distribution at point 0 (i.e., the distribution's means):
pnorm(0)
#' Unsurprisingly, the value is .5 because half of the distribution is to the left of 0.
#'
#' When we conduct statistical significance testing, we compare a value we observe to the cumulative distribution function. As one might recall, the value of 1.65 is the (approximate) critical value for a 90% normal confidence interval. We can see that by requesting:
pnorm(1.65)
#' The comparable value for a 95% CI is 1.96:
pnorm(1.96)
#' Note how the values are ~.95 and ~.975, respectively, because those are critical values for two-tailed tests. If we plug a negative value into the `pnorm` function, we'll receive the cumulative probability for the left side of the distribution:
pnorm(-1.96)
#' Thus subtracting the output of `pnorm` for the negative input from the output for the positive input, we'll see that 95% of the density is between -1.96 and 1.96 (in the standard normal distribution):
pnorm(1.96)-pnorm(-1.96)
#'
#' ## Quantile function ##
#' The examples just described relied on the heuristic values of 1.65 and 1.96 as the thresholds for 90% and 95% two-tailed tests. But to find the exact points at which the normal distribution has accumulated a particular cumulative density, we can use the `qnorm` function. Essentially, `qnorm` is the reverse of `pnorm`.
#' To obtain the critical values for a two-tailed 95% confidence interval, we would plug .025 and .975 into `qnorm`:
qnorm(c(.025,.975))
#' And we could actually nest that call inside a `pnorm` function to see that `pnorm` and `qnorm` are opposites:
pnorm(qnorm(c(.025,.975)))
#' For one-tailed tests, we simply specify the cumulative density. So, for a one-tailed 95% critical value, we would specify:
qnorm(.95)
#' We could obtain the other tail by specifying:
qnorm(.05)
#' Or, we could request the upper-tail of the distribution rather than the lower (left) tail (which is the default):
qnorm(.95, lower.tail=FALSE)
#'
#' As with `dnorm`, `pnorm`, and `qnorm` work on arbitrary normal distributions, but its results will be unfamiliar to us:
pnorm(1.96, mean=3)
qnorm(.95, mean=3)
#'
#' ## Other distributions ##
#' As stated above, R supplies functions analogous to those just described for numerous distributions.
#' Details about all of the distributions can be found in the help files: `? Distributions`.
#'
#' Here are a few examples:
#'
#' t distribution
#' Note: The t distribution functions require a `df` argument, specifying the degrees of freedom.
qt(.95, df=1000)
qt(c(.025,.975), df=1000)
#'
#' Binomial distribution
#' The binomial distribution functions work as above, but require `size` and `prob` arguments, specifying the number of draw and the probability of success. So, if we are modelling fair coin flips:
dbinom(0, 1, .5)
pbinom(0, 1, .5)
qbinom(.95, 1, .5)
qbinom(c(.025,.975), 1, .5)
#' Note: Because the binomial is a discrete distribution, the values here might seem strange compared to the above.
#'