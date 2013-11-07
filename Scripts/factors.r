#' # Factors #
#'
#' To extract the (unique) levels of a factor, use `levels`:
levels(factor(c(1,2,3,2,3,2,3)))
#' Note: the levels of a factor are always character:
class(levels(factor(c(1,2,3,2,3,2,3))))
#'
#' To obtain just the number of levels, use `nlevels`:
nlevels(factor(c(1,2,3,2,3,2,3)))
#'
#'
#' ## Converting from factor class ##
#'
#' If the factor contains only integers, we can use `unclass` to convert it (back) to an integer class vector:
unclass(factor(c(1,2,3,2,3,2,3)))
#'
#' Note: The "levels" attribute is still being reported but the new object is not a factor.
#'
#' But if the factor contains other numeric values, we can get unexpected results:
unclass(factor(c(1,2,1.5)))
#' We might have expected this to produce a numeric vector of the form `c(1,2,1.5)`
#' Instead, we have obtained an integer class vector of the form `c(1,3,2)`
#' This is because the factors levels reflect the ordering vector values, not their actual values
#'
#' We can see this at work if we unclass a factor that was created from a character vector:
unclass(factor(c("a","b","a")))
#' The result is an integer vector: `c(1,2,1)`
#'
#' This can be especially confusing if we create a factor from a combination of numeric and character elements:
unclass(factor(c("a","b",1,2)))
#' The result is an integer vector, `c(3,4,1,2)`, which we can see in several steps:
#' (1) the numeric values are coerced to character
c("a","b",1,2)
#' (2) the levels of the factor are sorted numerically then alphabetically
factor(c("a","b",1,2))
#' (3) the result is thus a numeric vector, numbered according to the order of factor levels
unclass(factor(c("a","b",1,2)))
#'
#'
#' ## Modifying factors ##
#'
#' Changing factors is similar to changing other types of data, but has some unique challenges
#' We can see this if we compare a numeric vector to a factor version of the same data:
a <- 1:4
b <- factor(a)
a
b
#'
#' We can see in the way that the two variables are printed that the numeric and factor look different
#' This is also true if we use indexing to see a subset of the vector:
a[1]
b[1]
#'
#' If we try to change the value of an item in the numeric vector using positional indexing, there's no problem:
a[1] <- 5
a
#' If we try to do the same thing with the factor, we get a warning:
b[1] <- 5
b
#' And the result isn't what we wanted. We get a missing value.
#' This is because 5 wasn't a valid level of our factor.
#' Let's restore our `b` variable:
b <- factor(1:4)
#' Then we can add 5 to the levels by simply replacing the current levels with a vector of the current levels and 5:
levels(b) <- c(levels(b),5)
#' Our variable hasn't changed, but its available levels have:
b
#' Now we can change the value using positional indexing, just like before:
b[1] <- 5
b
#' And we get the intended result
#'
#' This can be quite useful if we want to change the label for all values at a given level
#' To see this, we need a vector containing repeated values:
c <- factor(c(1:4,1:3,1:2,1))
c
#' There are four levels to `c`:
levels(c)
#' If we want to change `c` so that every 2 is now a 5, we can just change the appropriate level
#' This is easy because 2 is the second level, but we'll see a different example below:
levels(c)[2]
levels(c)[2] <- 5
levels(c)[2]
c
#' Now `c` is contains 5's in place of all of the 2's
#' But our replacement involved positional indexing
#' The second factor level isn't always equal to the number 2, it just depends on what data we have
#' So we can also replace factor levels using logicals (e.g., to change 5 to 9):
levels(c)=='5'
levels(c)[levels(c)=='5']
levels(c)[levels(c)=='5'] <- 9
levels(c)
c
#'
#' As you can see, factors are a potentially useful way for storing different kinds of data and R uses them alot!
#'