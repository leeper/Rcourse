#' # Character String Manipulation #
#'
#' Unlike other statistical packages, R has a robust and simple to use set of string manipulation functions.
#' These functions become useful in a number of situations, including: dynamically creating variables, generating tabular and graphical output, reading and writing from text files and the web, and managing character data (e.g., recoding free response or other character data).
#' This tutorial walks through some of the basic string manipulations functions.
#'
#' ## paste ##
#' The simplest and most important string manipulation function is `paste`. It allows the user to concatenate character strings (and vectors of character strings) in a number of different ways.
#' The easiest way to use `paste` is simply to concatenate several values together:
paste('1','2','3')
#' The result is a single string (i.e., one-element character vector) with the numbers separated by spaces (which is the default). We can also separate by other values:
paste('1','2','3',sep=',')
#' A helpful feature of `paste` is that it coerces objects to character before concatenating, so we can get the same result above using:
paste(1,2,3,sep=',')
#' This also means we can combine objects of different classes (e.g., character and numeric):
paste('a',1,'b',2,sep=':')
#' Another helpful feature of `paste` is that it is vectorized, meaning that we can concatenate each element of two or more vectors in a single call:
a <- letters[1:10]
b <- 1:10
paste(a,b,sep='')
#' The result is a 10-element vector, where the first element of `a` has been `paste`d to the first element of `b` and so forth.
#' We might want to collapse a multi-item vector into a single string and for this we can use the `collapse` argument to `paste`:
paste(a,collapse='')
#' Here, all of the elements of `a` are concatenated into a single string.
#' We can also combine the `sep` and `collapse` arguments to obtain different results:
paste(a,b,sep='',collapse=',')
paste(a,b,sep=',',collapse=';')
#' The first result above concatenates corresponding elements from each vector without a space and then separates them by a comma. The second result concatenates corresponding elements with a comma between the elements and separates each pair of elements by semicolon.
#'
#' # strsplit #
#' The `strsplit` function offers essentially the reversal of `paste`, by cutting a string into parts based on a separator. Here we can collapse our `a` vector and then split it back into a vector:
a1 <- paste(a,collapse=',')
a1
strsplit(a1,',')
#' Note: `strsplit` returns a list of results, so accessing the elements requires using the `[[]]` (double bracket) operator. To get the second element from the split vector, use:
strsplit(a1,',')[[1]][2]
#' The reason for this return value is that `strsplit` is also vectorized. So we can split multiple elements of a character vectors in one call:
b1 <- paste(a,b,sep=',')
b1
strsplit(b1,',')
#' The result is a list of split vectors.
#'
#' Sometimes we want to get every single character from a character string, and for this we can use an empty separator:
strsplit(a1,'')[[1]]
#' The result is every letter and every separator split apart.
#' `strsplit` also supports much more advanced character splitting using "regular expressions." We address that in a separate tutorial.
#'
#' # nchar and substring #
#' Sometimes we want to know how many characters are in a string, or just get a subset of the characters. R provides two functions to help us with these operations: `nchar` and `substring`.
#' You can think of `nchar` as analogous to `length` but instead of telling you how many elements are in a vector it tells you how many characters are in a string:
d <- 'abcd'
length(d)
nchar(d)
#' `nchar` is vectorized, which means we can retrieve the number of characters in each element of a characte vector in one call:
e <- c('abc','defg','hi','jklmnop')
nchar(e)
#' 
#' `substring` lets you extract a part of a string based on the position of characters in the string and can be combined with `nchar`:
f <- 'hello'
substring(f,1,1)
substring(f,2,nchar(f))
#' `substring` is also vectorized. For example we could extract the first character from each element of a vector:
substring(e,1,1)
#' Or even the last character of elements with different numbers of characters:
e
nchar(e)
substring(e,nchar(e),nchar(e))
#'