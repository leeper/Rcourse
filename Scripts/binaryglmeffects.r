#' # Binary Outcome GLM Effects Plots #
#'

#' Simple multivariate model (no interaction)
set.seed(1)
x1 <- rbinom(100,1,.5)
x2 <- runif(100,0,1)
x3 <- runif(100,0,5)
y1 <- 2*x1 + 5*x2 + rnorm(100,0,3)
y1s <- rbinom(100,1,(y1-min(y1))/(max(y1)-min(y1))) # the math here is just to rescale to [0,1]

#' Simple multivariate model (with interaction)
y2 <- 2*x1 + 5*x2 + 2*x1*x2 + rnorm(100,0,3)
y2s <- rbinom(100,1,(y2-min(y2))/(max(y2)-min(y2)))

#' Simple multivariate model (with interaction and an extra term)
y3 <- 2*x1 + 5*x2 + 2*x1*x2 + x3 + rnorm(100,0,3)
y3s <- rbinom(100,1,(y2-min(y2))/(max(y2)-min(y2)))


m1 <- glm(y1s ~ x1 + x2, family=binomial)
m2a <- glm(y2s ~ x1 + x2, family=binomial)
m2b <- glm(y2s ~ x1*x2, family=binomial)
m3a <- glm(y1s ~ x1 + x2 + x3, family=binomial)
m3b <- glm(y1s ~ x1*x2 + x3, family=binomial)

newdata1 <- expand.grid(x1=0:1,x2=seq(0,1,length.out=10))
newdata2 <- expand.grid(x1=0:1,x2=seq(0,1,length.out=10),x3=seq(0,5,length.out=25))
p1 <- predict(m1,newdata1,type='response', se.fit=TRUE)
p2a <- predict(m2a,newdata1,type='response', se.fit=TRUE)
p2b <- predict(m2b,newdata1,type='response', se.fit=TRUE)
p3a <- predict(m3a,newdata2,type='response', se.fit=TRUE)
p3b <- predict(m3b,newdata2,type='response', se.fit=TRUE)

#' ## Predicted Probability Plots ##

#' Simple model
plot(NA,xlim=c(0,1), ylim=c(0,1))
# `x1==0`
lines(newdata1$x2[newdata1$x1==0], p1$fit[newdata1$x1==0], col='red')
lines(newdata1$x2[newdata1$x1==0], p1$fit[newdata1$x1==0]+1.96*p1$se.fit[newdata1$x1==0], col='red', lty=2)
lines(newdata1$x2[newdata1$x1==0], p1$fit[newdata1$x1==0]-1.96*p1$se.fit[newdata1$x1==0], col='red', lty=2)
# `x1==1`
lines(newdata1$x2[newdata1$x1==1], p1$fit[newdata1$x1==1], col='blue')
lines(newdata1$x2[newdata1$x1==1], p1$fit[newdata1$x1==1]+1.96*p1$se.fit[newdata1$x1==1], col='blue', lty=2)
lines(newdata1$x2[newdata1$x1==1], p1$fit[newdata1$x1==1]-1.96*p1$se.fit[newdata1$x1==1], col='blue', lty=2)


#' Interaction model (improperly modeled)
plot(NA,xlim=c(0,1), ylim=c(0,1))
# `x1==0`
lines(newdata1$x2[newdata1$x1==0], p2a$fit[newdata1$x1==0], col='red')
lines(newdata1$x2[newdata1$x1==0], p2a$fit[newdata1$x1==0]+1.96*p2a$se.fit[newdata1$x1==0], col='red', lty=2)
lines(newdata1$x2[newdata1$x1==0], p2a$fit[newdata1$x1==0]-1.96*p2a$se.fit[newdata1$x1==0], col='red', lty=2)
# `x1==1`
lines(newdata1$x2[newdata1$x1==1], p2a$fit[newdata1$x1==1], col='blue')
lines(newdata1$x2[newdata1$x1==1], p2a$fit[newdata1$x1==1]+1.96*p2a$se.fit[newdata1$x1==1], col='blue', lty=2)
lines(newdata1$x2[newdata1$x1==1], p2a$fit[newdata1$x1==1]-1.96*p2a$se.fit[newdata1$x1==1], col='blue', lty=2)

#' Interaction model (properly modeled)
plot(NA,xlim=c(0,1), ylim=c(0,1))
# `x1==0`
lines(newdata1$x2[newdata1$x1==0], p2b$fit[newdata1$x1==0], col='red')
lines(newdata1$x2[newdata1$x1==0], p2b$fit[newdata1$x1==0]+1.96*p2b$se.fit[newdata1$x1==0], col='red', lty=2)
lines(newdata1$x2[newdata1$x1==0], p2b$fit[newdata1$x1==0]-1.96*p2b$se.fit[newdata1$x1==0], col='red', lty=2)
# `x1==1`
lines(newdata1$x2[newdata1$x1==1], p2b$fit[newdata1$x1==1], col='blue')
lines(newdata1$x2[newdata1$x1==1], p2b$fit[newdata1$x1==1]+1.96*p2b$se.fit[newdata1$x1==1], col='blue', lty=2)
lines(newdata1$x2[newdata1$x1==1], p2b$fit[newdata1$x1==1]-1.96*p2b$se.fit[newdata1$x1==1], col='blue', lty=2)


#' No-Interaction model with an additional covariate
plot(NA,xlim=c(0,1), ylim=c(0,1))
s <- sapply(unique(newdata2$x3), function(i) {
    # `x1==0`
    lines(newdata2$x2[newdata2$x1==0 & newdata2$x3==i], p3a$fit[newdata2$x1==0 & newdata2$x3==i], col=rgb(1,0,0,.5))
    lines(newdata2$x2[newdata2$x1==0 & newdata2$x3==i],
          p3a$fit[newdata2$x1==0 & newdata2$x3==i]+1.96*p3a$se.fit[newdata2$x1==0 & newdata2$x3==i], col=rgb(1,0,0,.5), lty=2)
    lines(newdata2$x2[newdata2$x1==0 & newdata2$x3==i],
          p3a$fit[newdata2$x1==0 & newdata2$x3==i]-1.96*p3a$se.fit[newdata2$x1==0 & newdata2$x3==i], col=rgb(1,0,0,.5), lty=2)
    # `x1==1`
    lines(newdata2$x2[newdata2$x1==1 & newdata2$x3==i], p3a$fit[newdata2$x1==1 & newdata2$x3==i], col=rgb(0,0,1,.5))
    lines(newdata2$x2[newdata2$x1==1 & newdata2$x3==i],
          p3a$fit[newdata2$x1==1 & newdata2$x3==i]+1.96*p3a$se.fit[newdata2$x1==1 & newdata2$x3==i], col=rgb(0,0,1,.5), lty=2)
    lines(newdata2$x2[newdata2$x1==1 & newdata2$x3==i],
          p3a$fit[newdata2$x1==1 & newdata2$x3==i]-1.96*p3a$se.fit[newdata2$x1==1 & newdata2$x3==i], col=rgb(0,0,1,.5), lty=2)
})


#' Interaction model with an additional covariate
plot(NA,xlim=c(0,1), ylim=c(0,1))
s <- sapply(unique(newdata2$x3), function(i) {
    # `x1==0`
    lines(newdata2$x2[newdata2$x1==0 & newdata2$x3==i], p3b$fit[newdata2$x1==0 & newdata2$x3==i], col=rgb(1,0,0,.5))
    lines(newdata2$x2[newdata2$x1==0 & newdata2$x3==i],
          p3b$fit[newdata2$x1==0 & newdata2$x3==i]+1.96*p3b$se.fit[newdata2$x1==0 & newdata2$x3==i], col=rgb(1,0,0,.5), lty=2)
    lines(newdata2$x2[newdata2$x1==0 & newdata2$x3==i],
          p3b$fit[newdata2$x1==0 & newdata2$x3==i]-1.96*p3b$se.fit[newdata2$x1==0 & newdata2$x3==i], col=rgb(1,0,0,.5), lty=2)
    # `x1==1`
    lines(newdata2$x2[newdata2$x1==1 & newdata2$x3==i], p3b$fit[newdata2$x1==1 & newdata2$x3==i], col=rgb(0,0,1,.5))
    lines(newdata2$x2[newdata2$x1==1 & newdata2$x3==i],
          p3b$fit[newdata2$x1==1 & newdata2$x3==i]+1.96*p3b$se.fit[newdata2$x1==1 & newdata2$x3==i], col=rgb(0,0,1,.5), lty=2)
    lines(newdata2$x2[newdata2$x1==1 & newdata2$x3==i],
          p3b$fit[newdata2$x1==1 & newdata2$x3==i]-1.96*p3b$se.fit[newdata2$x1==1 & newdata2$x3==i], col=rgb(0,0,1,.5), lty=2)
})

#' Predicted probabilities at median levels of `x3`
lines(newdata2$x2[newdata2$x1==0 & newdata2$x3==median(newdata2$x3)], p3b$fit[newdata2$x1==0 & newdata2$x3==median(newdata2$x3)], col='black', lwd=2)
lines(newdata2$x2[newdata2$x1==1 & newdata2$x3==median(newdata2$x3)], p3b$fit[newdata2$x1==1 & newdata2$x3==median(newdata2$x3)], col='black', lwd=2)



p3b.fitted <- predict(m3b,type='response',se.fit=TRUE)
plot(NA,xlim=c(0,1), ylim=c(0,1))
points(x2[x1==0], p3b.fitted$fit[x1==0], col=rgb(1,0,0,.5))
points(x2[x1==1], p3b.fitted$fit[x1==1], col=rgb(0,0,1,.5))



#' plot all marginal effects


