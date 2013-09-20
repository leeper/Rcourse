# Recoding

# Recoding is one of the most important tasks in preparing for an analysis.
# Often the data we have is not in the format we need to perform an analysis.
# Changing in data in R is easy, as long as we understand indexing and assignment.

# To recode values, we can either rely on positional or logical indexing.
# To change a particular value, we can rely on positions:
a <- 1:10
a[1] <- 99
a
# But this does not scale well. This is no better than recoding by hand.
# Logical indexing is then much easier to change multiple values at once:
a[a < 5] <- 99
a

# We can use multiple logical indices to change all of our values.
# For example, we could turn a vector into groups base on their values:
b <- 1:20
c <- b
c[b<6] <- 1
c[b>=6 & b<=10] <- 2
c[b>=11 & b<=15] <- 3
c[b>15] <- 4
# Looking at the two vectors as a matrix, we can see how our input values translated to outputs:
cbind(b,c)
# We can obtain the same result with nested `ifelse` functions:
d <- ifelse(b<6,1, ifelse(b>=6 & b<=10,2, ifelse(b>=11 & b<=15,3, ifelse(b>15,4,NA))))
cbind(b,c,d)

# Another way that is sometimes more convenient for writing this involves the package `car`, which we would need to load:
library(car)
# In this library we can use function `recode` to recode a vector:
e <- recode(b,"1:5=1; 6:10=2; 11:15=3; 16:20=4; else=NA")
# The `recode` function can also infer the minimum ('lo') and maximum ('hi') values in a vector:
f <- recode(b,"lo:5=1; 6:10=2; 11:15=3; 16:hi=4; else=NA")

# All of these techniques produce the same result:
cbind(b,c,d,e,f)
# Instead of checking this visually, we can use an `all.equal` function to compare two vectors:
all.equal(c,d)
all.equal(c,e)
all.equal(c,f)
# Note: if we instead used the `==` double equals comparator, the result would be a logical vector that compares corresponding values in each vector:
c==d
# If `all.equal` turns out false, the `==` double equals comparator shows where the vectors differ.


# Recoding missing values
# Missing values are handled somewhat differently from other values.
# If our vector has missing values, we need to use the `is.na` logical function to identify them:
g <- c(1:5,NA,7:13,NA,15)
h <- g
g
g[is.na(g)] <- 99
# The `recode` function can also handle missing values to produce the same result:
h <- recode(h, "NA=99")
all.equal(g,h)



# Recoding based on multiple input variables
# Often we want to recode based on two variables (e.g., age and sex) to produce categories.
# This is easy using the right logical statements.
# Let's create some fake data (in the form of a dataframe) using a function called `expand.grid`:
i <- expand.grid(1:4,1:2)
i
# This dataframe has two variables (columns), one with four categories ('Var1') and one with two ('Var2').
# Perhaps we want to create a variable that reflects each unique combination of the two variables.
# We can do this with `ifelse`:
ifelse(i$Var2==1, i$Var1, i$Var1+4)
# This statement says that if an element from `i$Var2` is equal to 1,
# then the value of the corresponding element in our new variable is equal to the value in `i$Var1`.
# otherwise the value of the corresponding element in the new vecotr is set to `i$Var1+4`.

# That solution requires us to know something about the data (that it's okay to simply add 4 to get unique values).
# A more general solution is to use the `interaction` function:
interaction(i$Var1,i$Var2)
# This produces a factor vector with eight unique values.
# The names are a little strange, but it will always give us every unique combination of the two (or more) vectors.


# There are lots of different ways to recode vectors, but these are the basic tools that can be combined to do almost anything.

