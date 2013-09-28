#' # Matrix algebra #
#'
#' scalar addition/subtraction
#' scalar multiplication/division


#' ## Matrix Multiplication ##

#' A function to demonstrate how matrix multiplication works:
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



#' cross-product (see OLS in matrix form)


#' row/column means/sums
