# Vectors

# An important, if not the most important, object in the R language is the vector.
# A vector is a set of items connected together.
# Building a vector is easy using the `c` operator:
c(1,2,3)

# This combines three items - 1 and 2 and 3 - into a vector.

# The same result is possible with the `:` (colon) operators:
1:3

# The two can also be combined:
c(1:3,4)
c(1:2,4:5,6)
1:4

# And colon-built sequences can be in any direction:
4:1
10:2

# Arbitrary numeric sequences can also be built with `seq`:
seq(from=1,to=10)
seq(2,25)

# `seq` accepts a number of optional arguments, including:
# by, which controls the spacing between vector elements
seq(1,10,by=2)
seq(0,1,by=.1)
# length.out, which controls the length of the resulting sequence
seq(0,1,length.out=11)

# A related function `seq_along` produces a sequence the length of another vector:
seq_along(c(1,4,5))

# This is shorthand for combining `seq` with the `length` function:
length(c(1,4,5))
seq(1,length(c(1,4,5)))


# The above vectors are numeric, but vectors can be other classes, like character:
c("a","b")

# Sequences of dates are also possible, using Date classes:
seq(as.Date("1999/1/1"), as.Date("1999/3/5"), "week")
seq(as.Date("1999/1/1"), as.Date("1999/3/5"), "day")

# But vectors can only have one class, so elements will be coerced, such that:
c(1,2,"c")
# produces a character vector
