# Matrices

# Matrices are a two-dimensional data structure that are quite useful, especially for statistics in R.
# Just like in mathematical notation, an R matrix is an m-by-n grid of elements.
# To create a matrix, we use the `matrix` function, which we supply with several parameters including the content of the matrix and its dimensions.
matrix()


# We can also combine (or bind) vectors and/or matrices together using `cbind` and `rbind`.
# `rbind` is used to "row-bind" by stacking vectors and/or matrices on top of one another vertically.
# `cbind` is used to "column-bind" by stacking vectors and/or matrices next to one another horizontally.
rbind(1:3,4:6,7:9)
cbind(1:3,4:6,7:9)

# We can also easily transpose a matrix using `t`:
rbind(1:3,4:6,7:9)
t(rbind(1:3,4:6,7:9))