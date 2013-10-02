#' # Matrix algebra #
#'
#' ## Scalar addition/subtraction ##
#' Scalar addition and subtraction on a matrix works identically to addition or subtraction on a vector.
#' We simply use the standard addition (`+`) and subtraction (`-`) operators.
a <- matrix(1:6, nrow=2)
a
a + 1
a - 2
#' ## Scalar multiplication/division ##
#' Scalar multiplication and division also work with the standard operators (`*` and `/`).
a * 2
a / 2

#' ## Matrix comparators, logicals, and assignment ##
#' As with a vector, it is possible to apply comparators to an entire matrix:
a > 2
#' We can then use the resulting logical matrix as an index:
a[a>2]
#' But the result is a vector, not a matrix.
#' If we use the same statement to assign, however, the result is a matrix:
a[a>2] <- 99
a


#' ## Matrix Multiplication ##
#' In statistics, an important operation is matrix multiplication.
#' Unlike scalar multiplication, this procedure involves the multiplication of two matrices by one another.
#'
#' Let's start by defining a function to demonstrate how matrix multiplication works:
mmdemo <- function(A,B){
    m <- nrow(A)
    n <- ncol(B)
    C <- matrix(NA,nrow=m,ncol=n)
    for(i in 1:m) {
        for(j in 1:n) {
            C[i,j] <- paste('(',A[i,],'*',B[,j],')',sep='',collapse='+')
        }
    }
    print(C, quote=FALSE)
}

#' Now let's generate two matrices, multiply them and see how it worked:
amat <- matrix(1:4,ncol=2)
bmat <- matrix(1:6,nrow=2)
amat
bmat
amat %*% bmat
mmdemo(amat,bmat)
#' Let's try it on a different set of matrices:
amat <- matrix(1:16,ncol=4)
bmat <- matrix(1:32,nrow=4)
amat
bmat
amat %*% bmat
mmdemo(amat,bmat)
#' Note: matrix multiplication is noncommutative, so the order of matrices matters in a statement!

#' ## Cross-product ##
#' Another important operation is the crossproduct.
#' See also: OLS in matrix form.


#' ## Row/column means and sums ##
#' Sometimes we want to calculate a sum or mean for each row or column of a matrix.
#' R provides built-in functions for each of these operations:
cmat <- matrix(1:20, nrow=5)
cmat
rowSums(cmat)
colSums(cmat)
rowMeans(cmat)
colMeans(cmat)
#' These functions can be helpful for aggregating multiple variables and performing the sum or mean with these functions is much faster than manually adding (or taking the mean) of columns using `+` and `/` operators.

