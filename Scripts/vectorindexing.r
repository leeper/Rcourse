# Vector Indexing

# An important aspect of working with R objects is knowing how to "index" them
# Indexing means selecting a subset of the elements in order to use them in further analysis or possibly change them
# Here we focus just on three kinds of vector indexing: positional, named reference, and logical
# Any of these indexing techniques works the same for all classes of vectors


# Positional indexing
# If we start with a simple vector, we can extract each element from the vector by placing its position in brackets:
c("a","b","c")[1]
c("a","b","c")[2]
c("a","b","c")[3]

# Indices in R start at 1 for the first item in the vector and continue up to the length of the vector.
# (Note: In some languages, indices start with the first item being indexed as 0.)
# This means that we can even index a one-element vector:
4[1]

# But, we will get a missing value if we try to index outside the length of a vector:
length(c(1:3))
c(1:3)[9]

# Positional indices can also involve an R expression
# For example, you may want to extract the last element of a vector of unknown length
# To do that, you can embed the `length` function in the the `[]` brackets.
a <- 4:12
a[length(a)]
# Or, you can express any other R expression, for example to get the second-to-last element:
a[length(a)-1]

# It is also possible to extra multiple elements from a vector, such as the first two elements:
a[1:2]
# You can use any vector of element positions:
a[c(1,3,5)]
# This means that you could also return the same element multiple times:
a[c(1,1,1,2,2,1)]
# But note that positions outside of the length of vector will be returned as missing values:
a[c(5,25,26)]

# It is also possible to index a vector, less a vector of specified elements, using the `-` symbol
# For example, to get all elements except the first, on could simply index with `-1`:
a[-1]
# Or, to obtain all elements except the last element, we can combine `-` with `length`:
a[-length(a)]
# Or, to obtain all elements except the second and third:
a[-c(2,3)]
# Note: While in general `2:3` is the same as `c(2,3)`, this is not the case in indexing



# Named indexing
# A second approach to indexing that is not particularly common for vectors is named indexing
# Vector elements can assigned names, such that each element has a value but also a name attached to it:
b <- c('x'=1,'y'=2,'z'='4')
b
# This is the same as:
b <- c(x=1,y=2,z='4')
b
# In this type of vector we can still use positional indexing:
b[1]
# But we can also index based on the names of the vector elements:
b['x']
# And, just with positional indexing, we can extract multiple elements at once:
b[c('x','z')]
# But, it's not possible to use the `-` indexing that we used with element positions.
# For example, `b[-'x']` would return an error.
# If a vector has names, this provides a way to extract elements without knowing their relative position in the order of vector elements.
# If you want to know which name is in which position, we can also get just the names of the vector elements:
names(b)
# And we can use positional indexing on the `names(b)` vector, e.g. to get the first element's name:
names(b)[1]



# Logical indexing
# The final way to index a vector involves logicals.
# Positional indexing allowed us to use any R expression to extract one or more elements.
# Logical indexing allows us to extract elements that meet specified criteria, as specified by an R logical expression.

# Thus, with a given vector, we could, for example, extract elements that are equal to a particular value:
c <- 10:3
c[c==5]
# This works by first constructing a logical vector and then using that to return elements where the logical is TRUE:
c==5
c[c==5]
# We can use an exclamation point (`!`) to negate the logical and thus return an opposite set of vector elements
# This is similar to the `-` indexing from positional indexing:
!c==5
c[!c==5]

# We do not need to restrict ourselves to logical equivalences. We can also use other comparators:
c[c>5]
c[c<=7]

# We can also use boolean operators (i.e., AND `&`, OR `|`) to combine multiple criteria:
c < 9 & c > 4
c[c < 9 & c > 4]
c > 8 | c==3
c[c > 8 | c==3]
# Here we can see how different logical criteria translate into a logical vector that is then used to index our target vector

# Some potentially unexpected behavior can happen if we try to index with a logical vector of a different length than our target vector:
c[TRUE] 		# returns all elements
c[c(TRUE,TRUE)] # returns all elements
c[FALSE] 		# returns an empty vector
# Just with positional indexing, if the logical vector is longer than our target vector, missing values will be appended to the end:
d <- 1:3
d[c(TRUE,TRUE,TRUE,TRUE)]

# Because 0 and 1 values can be coerced to logicals, we can also use some shorthand to get the same indices as logical values:
as.logical(c(1,1,0))
d[c(TRUE,TRUE,FALSE)]
d[as.logical(c(1,1,0))]



# Blank index
# Note: A blank index like `e[]` is treated specially in R.
# It refers to all elements in a vector.
e <- 1:10
e[]
# This is of course redundant to just saying `e`, but might produce unexpected results during assignment:
e[] <- 0
e
# This replaces all values of `e` with 0, which may or may not be intended.
