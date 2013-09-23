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



# Scatterplot

