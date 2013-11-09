#' # Multinomial Outcome Models #
#' 
#' One important, but sometimes problematic, class of regression models deals with nominal or multinomial outcomes (i.e., outcomes that are not continuous or even ordered). Estimating these models is not possible with `glm`, but can be estimated using the *nnet* add-on package, which is recommended and therefore simply needs to be loaded.
#' Let's start by loading the package, or installing then loading it if it isn't already on our system:
if(!library(nnet)){
    install.packages('nnet',repos='http://cran.r-project.org')
    library(nnet)
}
#' Then let's create some simple bivariate data where the outcome `y` takes three values
set.seed(100)
y <- sort(sample(1:3,600,TRUE))
x <- numeric(length=600)
x[1:200] <- -1*x[1:200] + rnorm(200,4,2)
x[201:400] <- 1*x[201:400] + rnorm(200)
x[401:600] <- 2*x[401:600] + rnorm(200,2,2)
#' We can plot the data to see what's going on:
plot(y~x, col=rgb(0,0,0,.3), pch=19)
abline(lm(y~x),col='red') # a badly fitted regression line
#' Clearly, there is a relationship between `x` and `y`, but it's certainly not linear and if we tried to draw a line through through the data (i.e., the straight red regression line), many of the predicted values would be problematic because `y` can only take on discrete values 1,2, and 3 and, in fact, the line hardly fits the data at all.
#' We might therefore rely on a multinomial model, which will give us the coefficients for `x` for each level of the outcome. In other words, the coefficients from a multinomial logistic model express effects in terms of moving from the baseline category of the outcome to the other levels of the outcome (essentially combining several binary logistic regression models into a single model).
#' Let's look at the output from the `multinom` function to see what these results look like:
m1 <- multinom(y~x)
summary(m1)
#' Our model only consists of one covariate, but we now see two intercept coefficients and two slope coefficients because the model is telling us the relationship between `x` and `y` in terms of moving from category 1 to category 2 in `y` and from category 1 to category 3 in `y`, respectively. The standard errors are printed below the coefficients.
#' Unfortunately, its almost impossible to interpret the coefficients here because a unit change in `x` has some kind of negative impact on both levels of `y`, but we don't know how much.
#'
#' ## Predicted values from multinomial models ##
#' A better way to examine the effects in a multinomial model is to look at predicted probabilities. We need to start with some new data representing the full scale of the `x` variable:
newdata <- data.frame(x=seq(min(x),max(x),length.out=100))
#' Like with binary models, we can extract different kinds of predictions from the model using `predict`. The first type of prediction is simply the fitted "class" or level of the outcome:
p1 <- predict(m1, newdata, type="class")
#' The second is a predicted probability of being in each category of `y`. In other words, for each value of our new data, `predict` with `type="class"` will return, in our example, three predicted probabilities.
p2 <- predict(m1, newdata, type="probs")
#' These probabilities also all sum to a value of 1, which means that the model requires that the categories of `y` be mutually exclusive and comprehensive. There's no opportunity for `x` to predict a value outside of those included in the model.
#' You can verify this using `rowSums`:
rowSums(p2)
#' If you want to relax this constraint, you can separately model your data using two or more binary logistic regressions comparing different categories. For example, we could model the data, predicting `y==2` against `y==1` and separately `y==3` against `y==1`. Do this we can create two subsets of our original data to separately `y==2` from `y==3`.
df1 <- data.frame(x=x,y=y)[y %in% c(1,2),]
df1$y <- df1$y-1 # recode 2 to 1 and 1 to 0
df2 <- data.frame(x=x,y=y)[y %in% c(1,3),]
df2$y[df2$y==1] <- 0 # recode 1 to 0
df2$y[df2$y==3] <- 1 # recode 3 to 1
#' We can then model this and compare to the coefficients from the multinomial model:
coef(glm(y~x, data=df1, family=binomial)) # predict 2 against 1
coef(glm(y~x, data=df2, family=binomial)) # predict 3 against 1
coef(m1) # multinomial model
#' Clearly, the coefficients from the two modeling strategies are similar, but not identical. The multinomial probably imposes a more plausible assumption (that predicted probabilities sum to 1), but you can easily try both approaches.
#'
#' ### Plotting predicted classes ###
#' One way to visualize the results of a multinomial model is simply to plot our fitted values for `y` on top of our original data:
plot(y~x, col=rgb(0,0,0,.05), pch=19)
lines(newdata$x, p1, col=rgb(1,0,0,.75), lwd=5)
#' This plot shows that as we increase along `x`, observations are first likely to be in `y==2`, then `y==3`, and finally `y==1`. Unfortunately, using the `lines` function gives a slight misrepresentation because of the vertical discontinuities. We can draw three separate lines to have a more accurate picture:
plot(y~x, col=rgb(0,0,0,.05), pch=19)
lines(newdata$x[p1==1], p1[p1==1], col='red', lwd=5)
lines(newdata$x[p1==2], p1[p1==2], col='red', lwd=5)
lines(newdata$x[p1==3], p1[p1==3], col='red', lwd=5)
#'
#' ### Plotting predicted probabilities ###
#' Plotting fitted values is helpful, but doesn't give us a sense of uncertainty. Obviously the red lines in the previous plots show the category that we are *most* likely to observe for a given value of `x`, but it doesn't show us how likely an observation is to be in the other categories.
#' To see that, we need to look at predicted probabilities. Let's start by looking at the predicted probabilities object `p2`:
head(p2)
#' As stated above, this object contains a predicted probability of being in each category of `y` for a given value of `x`.
#' The simplest plot of this is simply three lines, each of which is color coded to represent categories 1,2, and 3 of `y`, respectively:
plot(NA, xlim=c(min(x),max(x)), ylim=c(0,1), xlab='x', ylab='Predicted Probability')
lines(newdata$x, p2[,1], col='red', lwd=2)
lines(newdata$x, p2[,2], col='blue', lwd=2)
lines(newdata$x, p2[,3], col='green', lwd=2)
# some text labels help clarify things:
text(9, .75, 'y==1', col='red')
text(6, .4, 'y==3', col='green')
text(5, .15, 'y==2', col='blue')
#' This plot gives us a bit more information than simply plotting predicted classes (as above). We now see that middling values of `x` are only somewhat more likely to be in category `y==3` than in the other categories, whereas at extreme values of `x`, the data are much more likely to be in categories `y==1` and `y==2`.
#' A slightly more attractive variance of this uses the `polygon` plotting function rather than `lines`. Text labels might higlight We can also optionally add a horizontal bar at the base of the plot to highlight the predicted class for each value of `x`:
plot(NA, xlim=c(min(x),max(x)), ylim=c(0,1), xlab='x', ylab='Predicted Probability', bty='l')
# polygons
polygon(c(newdata$x,rev(newdata$x)), c(p2[,1],rep(0,nrow(p2))), col=rgb(1,0,0,.3), border=rgb(1,0,0,.3))
polygon(c(newdata$x,rev(newdata$x)), c(p2[,2],rep(0,nrow(p2))), col=rgb(0,0,1,.3), border=rgb(0,0,1,.3))
polygon(c(newdata$x,rev(newdata$x)), c(p2[,3],rep(0,nrow(p2))), col=rgb(0,1,0,.3), border=rgb(0,1,0,.3))
# text labels
text(9, .4, 'y=1', font=2)
text(2.5, .4, 'y=3', font=2)
text(-1.5, .4, 'y=2', font=2)
# optionally highlight predicted class:
lines(newdata$x[p1==1], rep(0,sum(p1==1)), col='red', lwd=3)
lines(newdata$x[p1==2], rep(0,sum(p1==2)), col='blue', lwd=3)
lines(newdata$x[p1==3], rep(0,sum(p1==3)), col='green', lwd=3)
#' This plot nicely highlights both the fitted class but also the uncertainty associated with similar predicted probabilities at some values of `x`.
#' Multinomial regression models can be difficult to interpret, but taking the few simple steps to estimate predicted probabilities and fitted classes and then plotting those estimates in some way can make the models much more intuitive.
#'