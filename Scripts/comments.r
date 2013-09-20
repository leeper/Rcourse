# Comments

# Commenting is a way to describe the contents of an R script.
# Commenting is very important for reproducibility because it helps make sense of code to others and to a future you.


# Hash comments
# The scripts used in these materials include comments. Any text that follows a has symbol (`#`) becomes an R comment.
# Anything can be in a comment. It is ignored by R.
# You can comment an entire line or just the end of a line, like:
2+2 # This is a comment. The code before the `#` is still evaluated by R.

# Some languages provide mutli-line comments. R doesn't have these. Every line has to be commented individually.
# Most script editors provide the ability to comment out multiple lines at once.
# This can be helpful if you change your mind about some code:
a <- 1:10
# b <- 1:10
b <- 10:1
# In the above example, we comment out the line we don't want to run.



# Ignoring Code blocks
# If there are large blocks of valid R code that you decide you don't want to run, you can wrap them in an `if` statement:
a <- 10
b <- 10
c <- 10
if(FALSE){
  a <- 1
  b <- 2
  c <- 3
}
a
b
c
# The lines inside the `if(FALSE){...}` block are not run.
# If you decide you want to run them after all, you can just change `FALSE` to `TRUE`.



# R `comment` function
# R also provides a quite useful function called `comment` that stores a hidden description of an object.
# This can be useful in interactive sessions for keeping track of a large number of objects.
# It also has other uses in modelling and plotting that are discussed elsewhere.
# To add a comment to an object, we simply assign something to the object and then assign it a comment:
d <- 1:10
d
comment(d) <- "This is my first vector"
d
# Adding a comment is similar to adding a `names` attribute to an object, but the comment is not printed when we call `d`.
# To see a comment for an object, we need to use the `comment` function again:
comment(d)
# If an object has no comment, we receive a NULL result:
e <- 1:5
comment(e)

# Note: Comments must be valid character vectors. It is not possible to store a numeric value as a comment, but one can have multiple comments:
comment(e) <- c("hi","bye")
comment(e)
# And this means that they can be indexed:
comment(e)[2]
# And that we can add additional comments:
comment(e)[length(comment(e))+1] <- "hello again"
comment(e)

# Because comments are not printed by default, it is easy to forget about them. But they can be quite useful.
