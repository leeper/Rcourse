#' # Matrices #
#'
#' Matrices are a two-dimensional data structure that are quite useful, especially for statistics in R.
#' Just like in mathematical notation, an R matrix is an m-by-n grid of elements.
#' To create a matrix, we use the `matrix` function, which we supply with several parameters including the content of the matrix and its dimensions.
#' If we just give a matrix a `data` parameter, it produces a column vector:
matrix(1:6)
#' If we want the matrix to have different dimensions we can specify `nrow` and/or `ncol` parameters:
matrix(1:6,nrow=2)
matrix(1:6,ncol=3)
matrix(1:6,nrow=2, ncol=3)
#' By default, the data are filled into the resulting matrix "column-wise".
#' If we specify `byrow=TRUE`, the elements are instead filled in "row-wise":
matrix(1:6,nrow=2, ncol=3, byrow=TRUE)
#'
#' Requesting a matrix smaller than the supplied data parameter will result in only some of the data being used and the rest discarded:
matrix(1:6,nrow=2,ncol=1)
#'
#' Note: requesting a matrix with larger dimensions than the data produces a warning:
matrix(1:6,nrow=2,ncol=4)
#' In this example, we still receive a matrix but the matrix elements outside of our data are filled in automatically.
#' This process is called "recycling" in which R repeats the data until it fills in the requested dimensions of the matrix.
#'
#'
#' Just as with using `length` to count the elements in a vector, we can use several functions to measure a matrix object.
#' If we apply the function `length` to matrix, it still counts all the elements in the matrix, but doesn't tell us about dimensions:
a <- matrix(1:10,nrow=2)
length(a)
#' If we want to get the number of rows in the matrix, we can use `nrow`:
nrow(a)
#' If we want to get the number of columns in the matrix, we can use `ncol`:
ncol(a)
#' We can also get the number of rows and the number of columns in a single call to `dim`:
dim(a)
#'
#' We can also combine (or bind) vectors and/or matrices together using `cbind` and `rbind`.
#' `rbind` is used to "row-bind" by stacking vectors and/or matrices on top of one another vertically.
#' `cbind` is used to "column-bind" by stacking vectors and/or matrices next to one another horizontally.
rbind(1:3,4:6,7:9)
cbind(1:3,4:6,7:9)
#'
#' We can also easily transpose a matrix using `t`:
rbind(1:3,4:6,7:9)
t(rbind(1:3,4:6,7:9))
#'
#'
#' ## Matrix indexing ##
#' Indexing a matrix is very similar to indexing a vector, except now we have to account for two dimensions.
#' The first dimension is rows. The second dimension is columns.
b <- rbind(1:3,4:6,7:9)
b[1,]	#' first row
b[,1]	#' first column
b[1,1]	#' element in first row and first column
#' Just with vector indexing, we can extract multiple elements:
b[1:2,]
b[1:2,2:3]
#' And we can also use `-` indexing:
b[-1,2:3]
#' We can also use logical indexing in the same way:
b[c(TRUE,TRUE,FALSE),]
b[,c(TRUE,FALSE,TRUE)]
#'
#'
#' ## Diagonal and triangles ##
#' It is sometimes helpful to extract the diagonal of matrix (e.g., the diagonal of a variance-covariance matrix)
#' Diagonals can be extracted using `diag`:
diag(b)
#' It is also possible to use `diag` to assign new values to the diagonal of a matrix.
#' For example, we might want to make all of the diagonal elements 0:
b
diag(b) <- 0
b
#'
#' We can also extra the upper or lower triangles of a matrix (e.g., to extract one half of a correlation matrix)
#' `upper.tri` and `lower.tri` produce logical matrices of the same dimension as the original matrix, which can then be used to index:
upper.tri(b)	#' upper triangle
b[upper.tri(b)]
lower.tri(b)	#' lower triangle
b[lower.tri(b)]
#'
#'
#' ## Matrix names ##
#' Recall that vectors can have named elements. Matrices can have named dimensions.
#' Each row and column of a matrix can have a name that is supplied when it is created or added/modified later.
c <- matrix(1:6,nrow=2)
#' Row names are added with `rownames`:
rownames(c) <- c("Row1","Row2")
#' Column names are added with `colnames`:
colnames(c) <- c("x","y","z")
#' Dimension names can also be added initially when the matrix is created using the `dimnames` parameter in `matrix`:
matrix(1:6,nrow=2, dimnames=list(c("Row1","Row2"),c("x","y","z")))
#' Dimension names can also be created in this way for only the rows or columns by using a `NULL` value for one of the dimensions:
matrix(1:6,nrow=2, dimnames=list(c("Row1","Row2"),NULL))
#'