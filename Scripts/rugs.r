# Scatterplot with marginal rugs

# When we want to compare the distributions of two variables in a scatterplot, sometimes it is hard to see the marginal distributions.
# To observe the marginal distributions more clearly, we can add "rugs" using the `rug` function.
# A rug is a one-dimensional density plot drawn on the axis of a plot.

# Let's start with some data for two groups.
set.seed(1)
x1 <- rnorm(1000)
x2 <- rbinom(1000,1,.7)
y <- x1 + 5*x2 + 3*(x1*x2) + rnorm(1000,0,3)

# We can plot the scatterplot for each group separately in red and blue.
plot(x1[x2==1], y[x2==1], col='tomato3',
    xaxt='n', yaxt='n', xlab='', ylab='', bty='n')
points(y[x2==0]~x1[x2==0], col='royalblue3')

# We can then add some marginal "rugs" to each side. We could do this for all the data or separately for each group.
# To do it separately for each group, we need to specify the `line` parameter so that the rugs don't overwrite each other.
# x-axis rugs for each group
rug(x1[x2==1], side=1, line=0, col='tomato1', tck=.01)
rug(x1[x2==0], side=1, line=.5, col='royalblue1', tck=.01)
# y-axis rugs for each group
rug(y[x2==1], side=2, line=0, col='tomato1', tck=.01)
rug(y[x2==0], side=2, line=.5, col='royalblue1', tck=.01)
# Note: The `tck` parameter specifies how tall the rug is. A shorter rug uses less ink to communicate the same information.
# Then we can add some axes a little farther out than they normally would be on the plot:s
axis(1, line=1)
axis(2, line=1)

# We might also want to add some more descriptives to the plot. For example, the marginal means for each group:
# means(on x-axis rugs)
Axis(at=mean(x1[x2==1]),side=1, line=0, labels='', col='black', lwd.ticks=3, tck=0.01)
Axis(at=mean(x1[x2==0]),side=1, line=.5, labels='', col='black', lwd.ticks=3, tck=0.01)
# means(on y-axis rugs)
Axis(at=mean(y[x2==1]),side=2, line=0, labels='', col='black', lwd.ticks=3, tck=0.01)
Axis(at=mean(y[x2==0]),side=2, line=.5, labels='', col='black', lwd.ticks=3, tck=0.01)
# As should be clear, the means of `x1` are similar in both groups, but the means of `y` in each group differ considerably.
# By combining the scatterplot with the rug, we are able to communicate considerable information with little ink.
