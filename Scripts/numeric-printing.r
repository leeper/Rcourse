#' # Numeric Printing #
#'
#' While most of R's default print setting are reasonable, it also provides fine-grained control over the display of output.
#' This control is helpful both for looking at data and results, but also for correctly interpreting it and then outputing it to other formats (e.g., for use in a publication).
#'
#' ## False Precision ##
#' One of the biggest errors made by users of statistical software is the abuse of "false precision."
#' The idea of "false precision" is that the analyst uses the output of a statistical algorithm directly rather than formatting that output in line with precision of the actual data.
#' Statistical algorithms, when executed by computers, will typically produce output to a finite but very large number of decimal places even though the underlying data only allow precision to a smaller number of decimals.
#' Take for example, the task of calculating the average height of a group of individuals. Perhaps we have a tools capable of measuring height to the nearest centimeter. Let's say this is our data for five individuals:
height <- c(167, 164, 172, 158, 181, 179)
#' We can then use R to calculate the mean height of this group:
mean(height)
#' The result is given to four decimal places. But because our data are only precise to whole centimeters, the concept of "significant figures" applies. According to those rules, we can only have a result that is precise to the number of digits in our original data plus one. Our original data have three significant digits so the result can only have one decimal place. The mean is thus 170.2 not 170.167.
#' This is important because we might be tempted to compare our mean to another mean (as part of some analysis) and we can only detect differences at the tenths place but no further. A different group with a calculated mean height 170.191 (by the same measurement tool) would therefore have a mean indistinguishable from that in our group.
#' These kinds of calculations must often be done by hand. But R can do them for using several different functions.
#'
#' ## signif and round ##
#' The most direct way to properly round our results is with either `signif` or `round`. `signif` rounds to a specified number of significant digits. For our above example with four significant figures, we can use:
signif(mean(height),4)
#' An alternative approach is to use `round` to specify a number of decimal places. For the above example, this would be 1:
round(mean(height),1)
#' `round` also accepts negative values to round to, e.g., tens, hundreds, etc. places:
round(mean(height),-1)
#' Figuring out significant figures can sometimes be difficult, particularly when the precision of original data is ambiguous. A good rule of thumb for social science data is two significant digits unless those data are known to have greater precision.
#' As an example, surveys often measure constructs on an arbitrary scale (e.g., 1-7). There is one digit of precision in these data, so any results from them should have only two significant figures.
#'
#' ## digits options ##
#' While R typically prints to a large number of digits (default on my machine is 7), the above reminds us that we shouldn't listen to R's defaults because they convey false precision.
#' Rather than having to round everything that comes out of R each time, we can also specify a number of digits to round to globally.
#' We might, for example, follow a rule of thumb of two decimal places for our results:
mean(height)
sd(height)
options(digits=2)
mean(height)
sd(height)
#' But we can easily change this again to whatever value we so choose.
#' Note: computers are limited in the number of decimals they can actually store, so requesting large number of decimal places may produce unexpected results.
options(digits=20)
mean(height)
sd(height)
options(digits=7)
#'
#' Another useful global option is `scipen`, which decides whether R reports results in scientific notation.
#' If we specify a negative value for `scipen`, R will tend to report results in scientific notation.
#' And, if we specify a positive value for `scipen`, R will tend to report results in fixed notation, even when they are very small or very large.
#' Its default value is 0 (meaning no tendency either way).
options(scipen=-10)
1e10
1e-10
options(scipen=10)
1e10
1e-10
options(scipen=0)
1e10
1e-10
#'
#' ## sprintf ##
#' Another strategy for formatting output is the `sprintf` function.
#' `sprintf` is very flexible, so I won't explain all the details here, but it can be used to format a number (and other things) into any variety of formats as a character string. Here are some examples from `?sprintf` for the display of pi:
sprintf("%f", pi)
sprintf("%.3f", pi)
sprintf("%1.0f", pi)
sprintf("%5.1f", pi)
sprintf("%05.1f", pi)
sprintf("%+f", pi)
sprintf("% f", pi)
#'