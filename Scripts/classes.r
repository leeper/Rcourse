#' # R object classes #
#'
#' R objects can be of several different "classes"
#' A class essentially describes what kind of information is contained in the object
#'
#'
#' ## Numeric ##
#'
#' Often an object contains "numeric" class data, like a number or vector of numbers
#' We can test the class of an object using `class`:
class(12)
class(c(1,1.5,2))
#'
#' While most numbers are of class "numeric", a subset are "integer":
class(1:5)
#'
#' We can coerce numeric class objects to an integer class:
as.integer(c(1,1.5,2))
#' But note that this modifies the second item in the vector (1.5 becomes 1)
#'
#'
#' ## Character ##
#'
#' Other common classes include "character" data
#' We see character class data in country names or certain survey responses
class("United States")
#'
#' If we try to coerce character to numeric, we get a warning and the result is a missing value:
as.numeric("United States")
#'
#' If we combine a numeric (or integer) and a character together in a vector, the result is character:
class(c(1,"test"))
#' You can see that the `1` is coerced to character:
c(1,"test")
#' We can also coerce a numeric vector to character simply by changing its class:
a <- 1:4
class(a)
class(a) <- "character"
class(a)
a
#'
#'
#' ## Factor ##
#'
#' Another class is "factor"
#' Factors are very important to R, especially in regression modelling
#' Factors combine characteristics of numeric and character classes
#' We can create a factor from numeric data using `factor`:
factor(1:3)
#' We see that factor displays a special `levels` attribute
#' Levels describe the unique values in the vector
#' e.g., with the following factor, there are six values but only two levels:
factor(c(1,2,1,2,1,2))
#'
#' To see just the levels, we can use the `levels` function:
levels(factor(1:3))
levels(factor(c(1,2,1,2,1,2)))
#'
#' We can also build factors from character data:
factor(c("a","b","b","c"))
#'
#' We can look at factors in more detail in the `factors.R` script
#'
#'
#' ## Logical ##
#'
#' Another common class is "logical" data
#' This class involves TRUE | FALSE objects
#' We can look at that class in detail in the `logicals.R` script
#'