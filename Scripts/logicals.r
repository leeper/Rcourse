#' # Logicals #
#'
#' Logicals are a fundamental tool for using R in a sophisticated way.
#' Logicals allow us to precisely select elements of an R object (e.g., a vector or dataframe) based upon criteria and to selectively perform operations.
#'
#' R supports all of the typical mathematical comparison operators:
#' Equal to:
1 == 2
#' Note: Double equals `==` is a logical test. Single equals `=` means right-to-left assignment.
#' Greater than:
1 > 2
#' Greater than or equal to:
1 >= 2
#' Less than:
1 < 2
#' Less than or equal to:
1 <= 2
#' Note: Less than or equal to `<=` looks like `<-`, which means right-to-left assignment.
#'
#' Spacing between the numbers and operators is not important:
1==2
1 == 2
#' But, spacing between multiple operators is! The following:
# 1 > = 2
#' produces an error!
#'
#' The results of these comparisons is a logical vector that has values TRUE, FALSE, or NA:
is.logical(TRUE)    #' valid logical
is.logical(FALSE)   #' valid logical
is.logical(NA)      #' valid logical
is.logical(45)      #' invalid
is.logical('hello') #' invalid
#'
#' Because logicals only take values of TRUE or FALSE, values of 1 or 0 can be coerced to logical:
as.logical(0)
as.logical(1)
as.logical(c(0,0,1,0,NA))
#'
#' And, conversely, logicals can be coerced back to integer using mathematical operators:
TRUE + TRUE + FALSE
FALSE - TRUE
FALSE + 5
#'
#'
#' Logical comparisons can also be applied to vectors:
a <- 1:10
a > 5
#' This produces a logical vector. This is often useful for indexing:
a[a > 5]
#' We can also apply multiple logical conditions using boolean operators (AND and OR):
a > 4 & a < 9
a > 7 | a==2
#' Complex conditions can also be combined with parentheses to build a logical:
(a > 5 & a < 8) | (a < 3)
#' There is also a `xor` function to enforce strict OR (but not AND) logic:
xor(TRUE,FALSE)
xor(TRUE,TRUE)
xor(FALSE,FALSE)
#'
#' This becomes helpful, for example, if we want to create a new vector based on values of an old vector:
b <- a
b[b>5] <- 1
b
#'
#' It is also possible to convert a logical vector into a positional vector using `which`:
a > 5
which(a > 5)
#' Of course, this is only helful in some contexts because:
a[a>5]
a[which(a>5)]
#' produce the same result.
#'
#' We can also invert a logical (turn TRUE into FALSE, and vice versa) using the exclamaation point (`!`):
!TRUE
!FALSE
b==3
!b==3
#'
#' We can also use an if-else construction to define a new vector conditional on an old vector:
#' For example, we could produce our `b` vector from above using the `ifelse` function:
ifelse(a > 5, 1, a)
#' This tests each element of `a`. If that elements meets the condition, it returns the next value (1), otherwise it returns the value of `a`.
#' We could modify this slightly to instead return 2 rather than the original value when an element fails the condition:
ifelse(a > 5, 1, 2)
#' This gives us an indicator vector.
#'
#'
#' ## Set membership ##
#'
#' An especially helpful logical comparator checks of a vector in another vector:
d <- 1:5
e <- 4:7
d %in% e
e %in% d
#' R has several other functions related to sets (e.g., `union`, `intersection`) but these produce numeric, not logical output.
#'
#'
#' ## Vectorization ##
#'
#' Note: The `ifelse` function demonstrates an R feature called "vectorization."
#' This means that the function operates on each element in the vector rather than having to test each element separately.
#' Many R functions rely on vectorization, which makes them easy to write and fast for the computer to execute.
#'