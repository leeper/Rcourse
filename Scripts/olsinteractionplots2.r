#' # Interaction Plots #
#'
#' When we have continuous-by-continuous interactions in linear regression, it is impossible to directly interpret the coefficients on the interactions. It is actually just generally difficult to interpret these kinds of models. Often, a better approach is to translate one of the continuous variables into a factor and interpet the interaction-term coefficients on each level of that variable. Another approach is to visualize graphically. Both will give us the same inference.
#' Let's start with some fake data:
set.seed(1)
x1 <- runif(100,0,1)
x2 <- sample(1:10,100,TRUE)/10
y <- 1 + 2*x1 + 3*x2 + 4*x1*x2 + rnorm(100)
#' We've built a model that has a strong interaction between `x1` and `x2`. We can model this as a continuous interaction:
m <- lm(y~x1*x2)
#' Alternatively, we can treat `x2` as a factor (because, while approximately continuous, it only takes on 10 discrete values):
m2 <- lm(y~x1*factor(x2))
#' Let's look at the output of both models and see if we can make sense of them:
summary(m)
summary(m2)
#' For our continuous-by-continuous interaction model, we have the interaction expressed as a single number: ~5.96. This doesn't tell us anything useful because its only interpretation is the additionaly expected value of `y` as an amount added to the intercept plus the coefficients on each covariate (but only for the point at which `x1==1` and `x2==1`). Thus, while we might be inclined to talk about this as an interaction term, it really isn't...it's just a mostly meaningless number.
#' In the second, continuous-by-factor model, things are more interpretable. Here our factor dummies for `x2` tell us the expected value of `y` (if added to the intercept) when `x1==0`. Similarly, the factor-"interaction" dummies tell us the expected value `y` (if added to the intercept and the coefficient on `x1`) when `x1==1`. These seem more interpretable.
#'
#' ## Three-Dimensional Interaction Plotting ##
#' Another approach to understanding continuous-by-continuous interaction terms is to plot them. We saw above that the continuous-by-factor model, while intretable, required a lot of numbers (in a large table) to communicate the relationships between `x1`, `x2`, and `y`. R offers a number of plotting functions to visualize these kinds of interaction "response surfaces".
#'
#' Let's start by estimating predicted values. Because by `x1` and `x2` are scaled [0,1], we'll just create a single vector of values on the 0-1 scale and use that for both of our prediction values.
nx <- seq(0,1,length.out=10)
#' The use of the `outer` function here is, again, a convenience because our input values are scaled [0,1]. Essentially, it builds a 10-by-10 matrix of input values and predicts `y` for each combination of `x1` and `x2`.
z <- outer(nx,nx, FUN=function(a,b) predict(m,data.frame(x1=a,x2=b)))
#' We can look at the `z` matrix to see what is going on:
z
#' All of the resulting functions require us to use this `z` matrix as the "height" of the plot at each combination of `x1` and `x2`. Sounds a little crazy, but it will become clear once we do the plotting.
#'
#' ### Perspective plots ###
#' A perspective plot draws a "response surface" (i.e., the values of the `z` matrix) across a two-dimensional grid. The plot is what you might typically think of when you hear "three-dimensional graph".
#' Let's take a look:
persp(nx,nx,z, theta=45, phi=10, shade=.75, xlab='x1', ylab='x2', zlab='y')
#' Note: The `theta` parameter refers to the horizontal rotation of the plot and the `phi` parameter refers to the tilt of the plot (see `?persp`).
#' The plot shows us many things, especially:
#' 1. The vertical height of the surface is the expected (predicted) value of `y` at each combination of `x1` and `x2`.
#' 2. The slope of the surface on each edge of the plot is a marginal effect. In other words, the shallow slope on the lefthand face of the plot is the marginal effect of `x1` when `x2==0`. Similarly, the steep slope on the righthand face of the plot is the marginal effect of `x2` when `x1==1`. The other marginal effects (`x1|x2==1` and `x2|x1==0`) are hidden from our view on the back of the plot.
#'
#' There are two problems with perspective plots:
#' 1. Because they are two-dimensional representations of three-dimensional objects, their scales are deceiving. Clearly the "height" of the plot is bigger in the front than in the back. It is therefore only a heuristic.
#' 2. Because they are three-dimensional, we cannot see the entire plot at once (as evidence by the two hidden marginal effects discussed above).
#' There is nothing we can do about the first point, unless you want to use a 3D printer to print out the response surface. On the second point, however, we can see different rotations of the plot in order to get a better grasp on the various marginal effects.
#'
#' Let's look at two different sets of rotations. One showing four plots on the diagonal (like above):
par(mai=rep(.2,4))
layout(matrix(1:4,nrow=2, byrow=TRUE))
s <- sapply(c(45, 135, 225, 315), function(i)
    persp(nx,nx,z, theta=i, phi=10, shade=.75, xlab='x1', ylab='x2', zlab='y'))
#' The plot in the upper-left corner is the same one we saw above. But now, we see three additional rotations (imagine the plots rotating 90 degrees each, right-to-left), so the lower-right plot highlights the two "hidden" marginal effects from above.
#'
#' Another set of plots shows the same plot at right angles, thus highlighting the marginal effects at approximately true scale but masking much of the curviture of the response surface:
par(mai=rep(.2,4))
layout(matrix(1:4,nrow=2))
sapply(c(90, 180, 270, 360), function(i)
    persp(nx,nx,z, theta=i, phi=10, shade=.75, xlab='x1', ylab='x2', zlab='y'))
#' While this highlights the marginal effects somewhat nicely, the two left-hand plots are quite difficult to actually look at due to the shape of the interaction.
#' Note: The plots can be colored in many interesting ways, but the details are complicated (see `? persp`).
#'
#' ### Matrix Plots ###
#' Because the perspective plots are somewhat difficult to interpret, we might want to produce a two-dimensional representation that better highlights our interaction without the confusion of flattening a three-dimensional surface to two dimensions. The `image` function supplies us with a way to use color (or grayscale, in the case below) to show the values of `y` across the `x1`-by-`x2` matrix. We again supply arguments quite similar to above:
layout(1)
par(mai=rep(1,4))
image(nx,nx,z, xlab='x1', ylab='x2', main='Expected Y', col=gray(50:1/50))
#' Here, the darker colors represent higher values of `y`. Because the mind can't interpret color differences as well as it can interpret differences in slope, the interaction becomes somewhat muddled. For example, the marginal effect of `x2|x1==0` is much less steep than the marginal effect of `x2|x1==1`, but it is difficult to quantify that by comparing the difference between white and gray on the left-hand side of the plot to the difference between gray and black on the right-hand side of the plot (those differences in color representing the marignal effects.
#' We could redraw the plot with some contour lines to try to better see things:
image(nx,nx,z, xlab='x1', ylab='x2', main='Expected Y', col=gray(50:1/50))
contour(z=z, add=TRUE)
#' Here we see that when `x1==0`, a change in `x2` from 0 to 1 increases `y` from about 1 to about 4. By contrast, when `x1==0`, the same change in `x2` is from about 3 to about 10, which is substantially larger.
#' 
#' ### Contour lines ###
#' Since the contours seemed to make all of the difference in terms of interpretability above, we could just draw those instead without the underlying `image` matrix:
filled.contour(z=z, xlab='x1', ylab='x2', main='Expected Y', col=gray(20:1/20))
#' Here we see the same relationship highlighted by the contour lines, but they are nicely scaled and the plot supplies a gradient scale (at right) to help quantify the different colors.
#'
#' Thus we have several different ways to look at continuous-by-continuous interactions. All of these techniques have advantages and disadvantages, but all do a better job at clarifying the nature of the relationships between `x1`, `x2`, and `y` than does the standard regression model or even the continuous-by-factor model.
#'

