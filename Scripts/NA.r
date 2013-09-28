#' # Missing data #
#'
#' Missing data values in R are a major point of confusion.
#' This script walks through some of the basics of missing data.
#' Where some statistical packages have different kinds of missing data, R only has one
NA
#' `NA` means a missing value. For example, in a vector variable, we might be missing the third observation:
a <- c(1,2,NA,4,5)
a
#' This impacts our ability to do calculations on the vector, like taking its sum:
sum(a)
#' This is because R treats anything mathematically calculated with an NA as missing:
1+NA
0+NA
#' This can cause some confusion because many statistical packages omit missing values by default.
#' The R approach is better because it forces you to be conscious about where data are missing.

#' Another point of confusion is that some things look like missing data but are not.
#' For example, the `NULL` value is not missing. Note the difference between `a` and `b`:
a
b <- c(1,2,NULL,4,5)
b
#' `b` has only four elements. NULL is not missing, it is simply dropped.

#' This can be especially confusing when a vector is of character class.
#' For example, compare `c` to `d`:
c <- c("do","re",NA,"fa")
c
d <- c("do","re","NA","fa")
d
#' The third element of `c` is missing (`NA`), whereas the third element of `d` is a charater string `'NA'`.
#' We can see this with the logical test `is.na`:
is.na(c)
is.na(d)
#' This tests whether each element in a vector is missing.
#' Similarly, an empty character string is not missing:
is.na("")
#' It is simply a character string that has no contents.
#' For example, compare `c` to `e`:
c
e <- c("do","re","","fa")
e
is.na(c)
is.na(e)


#' There may be situations in which we want to change missing NA values or remove them entirely.
#' For example, to change all NA values in a vector to 0, we could use logical indexing:
f <- c(1,2,NA,NA,NA,6,7)
f
f[is.na(f)] <- 0
f
#' Alternatively, there may be situations where we want convert NA values to NULL values, and thus shorten our vector:
g1 <- c(1,2,NA,NA,NA,6,7)
g2 <- na.omit(g1)
g2
#' We now have shorter vector:
length(g1)
length(g2)
#' But that vector has been given an additional attribute: a vector of positions of omitted missing values:
attributes(g2)$na.action

#' Many functions also provide the ability to exclude missing values from a calculation.
#' For example, to calculate the sum of `g1` we could either use the `na.omit` function or an `na.rm` parameter in `sum`:
sum(na.omit(g1))
sum(g1, na.rm=TRUE)
#' Both provide the same answer.
#' Many functions in R allow an `na.rm` parameter (or something similarly).
