# Bivariate Regression



# Regression on a binary covariate
# Comparability to a two-sample t-test


# Regression on a continuous covariate
x <- runif(1000,0,10)
y <- 3*x + rnorm(1000,0,5)

x1 <- ifelse(x<2,1,ifelse(x >=2 & x<4,2,ifelse(x >=4 & x<6,3,ifelse(x >=6 & x<8,4,ifelse(x >=8 & x<10,5,NA)))))
d1 <- density(y[x1==1])
d2 <- density(y[x1==2])
d3 <- density(y[x1==3])
d4 <- density(y[x1==4])
d5 <- density(y[x1==5])

plot(x,y, col='gray')
abline(coef(lm(y~x)), col='blue')
abline(v=c(1,3,5,7,9), col='gray', lty=2)
points(1+d1$y*10, d1$x, type='l', col='black')
points(3+d1$y*10, d2$x, type='l', col='black')
points(5+d2$y*10, d3$x, type='l', col='black')
points(7+d3$y*10, d4$x, type='l', col='black')
points(9+d4$y*10, d5$x, type='l', col='black')



# Regression on a discrete covariate
# as factor



# Variable transformations

