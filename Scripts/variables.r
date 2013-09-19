# Variables

# Working with objects in R will become tedious if we don't give those objects names to refer to them in subsequent analysis.
# In R, we can "assign" an object a name that we can then reference subsequently.
# For example, rather than see the result of the expression `2+2`, we can store the result of this expression and look at it later:
a <- 2+2
# To see the value of the result, we simply call our variable's name:
a
# Thus the `<-` (less than and minus symbols together) mean assign the right-hand side to the name on the left-hand side.
# We can get the same result using `=` (an equal sign):
a = 2+2
a
# We can also, much more uncommonly, produce the same result by reversing the order of the statement and using a different symbol:
2+2 -> a
a
# This is very uncommon, though. The `<-` is the preferred assignment operator.

# When we assign an expression to a variable name, the result of the evaluated expression is saved.
# Thus, when we call `a` again later, we don't see `2+2` but instead see `4`.

# We can overwrite the value stored in a variable by simply assigning something new to that variable:
a <- 2+2
a <- 3
a

# We can also copy a variable into a different name:
b <- a
b

# We may decide we don't need a variable any more and it is possible to remove that variable from the R environment using `rm`:
rm(a)

# Sometimes we forget what we've done and want to see what variables we have floating around in our R environment. We can see them with `ls`:
ls()
# This returns a character vector containing all of the names for all named objects currently in our R environment.

# It is also possible to remove ALL variables in our current R session. You can do that with the following:
rm(list=ls(all=TRUE))
# Note: This is usually an option on the RGui dropdown menus and should only be done if you really want to remove everything.


# Sometimes you can also see an expression like:
b <- NULL
# This expression does not remove the object, but instead makes its value NULL.
# NULL is different from missing (NA) because R (generally) ignores a NULL value whenever it sees it.
# You can see this in the difference between the following two vectors:
c(1,2,NULL)
c(1,2,NA)
# The first has two elements and the second has three.


# It is also possible to use the `assign` function to assign a value to name:
assign("x",3)
x
# This is not common in interactive use of R but can be helpful at more advanced levels.