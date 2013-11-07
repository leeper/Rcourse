#' # Lists #
#'
#' Lists are a very helpful data structure, especially for large projects.
#' Lists allow us to store other types of R objects together inside another object.
#' For example, instead of having two vectors `a` and `b`, we could put those vectors in a list:
a <- 1:10
b <- 11:20
x <- list(a,b)
x
#' The result is a list with two elements, where the elements are the original vectors.
#' We can also build lists without defining the list elements beforehand:
x <- list(1:5,6:10)
x
#'
#'
#' ## Positional indexing of lists ##
#'
#' Positional indexing of lists is similar to positional indexing of vectors, with a few important differences.
#' If we index our list `x` with `[]`, the result is a list:
x[1]
x[2]
x[1:2]
#' If we try to index with 0, we get an empty list:
x[0]
#' And if we try to index with a value larger than `length(x)`, we get a list with a NULL element:
length(x)
x[length(x)+1]
#'
#' Lists also allow us to use a different kind of positional indexing involving two brackets (e.g., `[[]]`):
x[[1]]
#' Rather than returning a list, this returns the vector that is stored in list element 1.
#' We aren't allowed to index like `x[[1:2]]` because R doesn't know we want the first and second vectors combined.
#'
#' The double bracket indexing also lets us index elements of the vector stored in a list element.
#' For example, if we want to get the third element of the second list item, we can use two sets of indices:
x[[2]][3]
#'
#'
#' ## Named indexing of lists ##
#'
#' Just like vectors, list elements can have names.
y <- list(first=4:6, second=7:9, third=1:3)
y
#' The result is a list with three named elements, each of which is a vector.
#' We can still index this list positionally:
y[1]
y[[3]]
#' But we can also index by the names, like we did with vectors.
#' This can involve single bracket indexing, to return a single-element list:
y['first']
#' Or a subset of the original list elements:
y[c('first','third')]
#' It can also involve double bracket indexing, to return a vector:
y[['second']]
#' We can then combine this named indexing of the list with the numeric indexing of one of the list's vectors:
y[['second']][3]
#'
#' Named indexing also allows us to use a new operator, the dollar sign (`$`).
#' The `$` sign is equivalent to named indexing:
y[['first']]
y$first
#' And, just with named indexing in double brackets, we can combine `$` indexing with vector positional indexing:
y[['first']][2]
y$first[2]
#'
#'
#' ## Modifying list elements ##
#'
#' We can easily modify the elements of a list using positional or named indexing.
w <- list(a=1:5,b=6:10)
w
w[[1]] <- 5:1
w
w[['a']] <- rep(1,5)
w
#' We can also add new elements to a list using positions or names:
w[[length(w)+1]] <- 1
w$d <- 2
w
#' The result is a list with some named and some unnamed elements:
names(w)
#' We can fill in the empty (`''`) name:
names(w)[3] <- 'c'
names(w)
w
#' Or we could change all the names entirely:
names(w) <- c('do','re','mi','fa')
names(w)
w
#'
#'
#' Lists are flexible and therefore important!
#' The above exercises also showed that lists can contain different kinds of elements.
#' Not every element in a list has to be the same length or the same class.
#' Indeed, we can create a list that mixes many kinds of elements:
m <- list(a=1,b=1:5,c="hello",d=factor(1:3))
m
#' This is important because many of the functions we will use to do analysis in R return lists with different kinds of information.
#' To really use R effectively, we need to be able to extract information from those resulting lists.
#'
#'
#' ## Converting a list to a vector (and back) ##
#'
#' It may at some point be helpful to have our list in the form of a vector.
#' For example, we may want to be able to see all of the elements of every vector in the list as a single vector:
#' To get this, we `unlist` the list, which converts it into a vector and automatically names the vector elements according to the names of the original list:
z1 <- unlist(y)
z1
#' We could also turn this back into a list, with every element of `unlist(y)` being a separate element of a new list:
z2 <- as.list(z1)
z2
#' Here all of the elements of the vector are separate list elements and vector names are transferred to the new list.
#' We can see that the names of the vector are the same as the names of the list:
names(z1)
names(z2)
#'