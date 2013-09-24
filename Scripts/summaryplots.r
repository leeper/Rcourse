# Plots as data summary

# While we can use tables and statistics to summarize data, it is often use to visually summarize data.
# This script describes how to produce some common summary plots.


# Histogram
# The simplest plot is a histogram, which shows the frequencies of different values in a distribution.
# Drawing a basic histogram in R is easy.
# First, let's generate a random vector:
set.seed(1)
a <- rnorm(30)
# Then we can draw a histogram of the data:
hist(a)
# This isn't the most attractive plot, though, and we can easily make it look different:
hist(a,col='gray20',border='lightgray')



# Density plot
# Another approach to summarizing the distribution of a variable is a density plot.
# This visualization is basically a "smoothed" histogram and it's easy to plot, too.
plot(density(a))

# Clearly, the two plots give us similar information. We can even overlay them.
# Doing so requires a few modifications to our code, though.
hist(a, freq=FALSE, col='gray20',border='lightgray')
lines(density(a), col='red', lwd=2)



# Barplot
# One of the simplest data summaries is a barplot.
# Like a histogram, it shows bars. But those bars are statistics rather than just counts (though they could be counts).
# We can make a barplot from a vector of numeric values:
b <- c(3, 4.5, 5, 8, 3, 6)
barplot(b)
# The result is something visually very similar to the histogram.
# We can easily label the bars by specifying a `names.arg` parameter:
barplot(b, names.arg=letters[1:6])
# We can also turn the plot on its side, if that looks better:
barplot(b, names.arg=letters[1:6], horiz=TRUE)

# We can also create a stacked barplot by providing a matrix rather than a vector of input data.
# Let's say we have counts of two types of objects (e.g., coins) from three groups:
d <- rbind(c(2,4,1), c(6,1,3))
d
barplot(d, names.arg=letters[1:3])
# Instead of stacking the bars of each type, we can present them side by side using the `beside` parameter:
barplot(d, names.arg=letters[1:3], beside=TRUE)



# Dotchart
# Rather than waste a lot of ink on bars, we can see the same kinds of relationships in dotcharts.
dotchart(b, labels=letters[1:6])
# As we can see, the barplot and the dotchart communicate the same information in more or less the same way:
layout(matrix(1:2, nrow=1))
barplot(b, names.arg=letters[1:6], horiz=TRUE, las=2)
dotchart(b, labels=letters[1:6], xlim=c(0,8))



# Boxplot
# It is often helpful to describe the distribution of those data with a box plot.
# The boxplot describes any continuous vector of data by showing the five number summary and any outliers:
boxplot(a)
# It can also compare distributions in two or more groups:
e <- rnorm(100,1,1)
f <- rnorm(100,2,4)
boxplot(e,f)
# We can also use a "formula" description of data if one of our variables describes which group our observations fall into:
g1 <- c(e,f)
g2 <- rep(c(1,2),each=100)
boxplot(g1 ~ g2)
# As we can see, both of these last two plots are identical. They're just different ways of telling `boxplot` what to plot.



# Scatterplot
# When we want to describe the relationships among variables, we often want a scatterplot.
x1 <- rnorm(1000)
x2 <- rnorm(1000)
x3 <- x1 + x2
x4 <- x1 + x3
# We can draw a scatterplot in one of two ways.
# (1) Naming vectors as sequential arguments:
plot(x1,x2)
# (2) Using a "formula" interface:
plot(x2~x1)
# We can plot the relationship between `x1` and the three other variables:
layout(matrix(1:3,nrow=1))
plot(x1,x2)
plot(x1,x3)
plot(x1,x4)
# We can also use the `pairs` function to do this for all relationships between all variables:
pairs(~x1+x2+x3+x4)
# This allows us to visualize a lot of information very quickly.
