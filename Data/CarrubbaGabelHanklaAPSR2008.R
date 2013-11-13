# Carrubba et al Replication

library(foreign)
cgh <- read.dta('CarrubbaGabelHanklaAPSR2008.dta')


# Table 1
tmpdf <- cgh[,c('ECJPlAgree','normnetwobs','CommIsPl','CommIsDef','CommObsPl','CommObsDef','percham','normwobsgov','article177','govislit')]
tmpdf <- na.omit(tmpdf)
t(sapply(tmpdf, function(i) signif(c(mean(i), sd(i), min(i), max(i)),2)))


# Table 2
# Model 1
glm2_1 <- glm(ECJPlAgree ~ percham + CommIsPl + CommIsDef + CommObsPl + CommObsDef + 
              normnetwobs, data=cgh, family=binomial(link='probit'))
# Model 2
glm2_2 <- glm(ECJPlAgree ~ percham + CommIsPl + CommIsDef + CommObsPl + CommObsDef + 
              govislit + normnetwobs + normwobsgov, data=cgh, family=binomial(link='probit'))
# Note: The `normobsgov` variable is actually an interaction between `normnetwobs` and `govislit`
# Here's the model with the interaction:
glm2_2s <- glm(ECJPlAgree ~ percham + CommIsPl + CommIsDef + CommObsPl + CommObsDef + 
              govislit*normnetwobs, data=cgh, family=binomial(link='probit'))


# Figure 1
# Note: The code for this is actually not in their do file
modes <- sapply(glm2_2s$model, function(i) as.numeric(names(which.max(table(i)))))
modes <- as.data.frame(sapply(modes,rep,100))
modes$percham <- mean(cgh$percham, na.rm=TRUE) # percham is mean, not mode
modes$normnetwobs <- seq(-4,.5,length.out=100) # sequence to predict over
# Create two separate DFs, one for each level of `govislit`:
govnotlit <- govlit <- modes
govnotlit$govislit <- 0
govlit$govislit <- 1
# Predictions:
fig1_1 <- predict(glm2_2s, newdata=govlit, se.fit=TRUE, type='response')
fig1_0 <- predict(glm2_2s, newdata=govnotlit, se.fit=TRUE, type='response')

# Plot:
plot(NA, xlim=c(-.4,.5), ylim=c(0,1))
lines(modes$normnetwobs, fig1_1$fit, col='gray', lwd=3)
lines(modes$normnetwobs, fig1_0$fit, col='black', lwd=3)
# 95% CIs:
lines(modes$normnetwobs, fig1_1$fit-1.96*fig1_1$se.fit, col='gray', lwd=1, lty=2)
lines(modes$normnetwobs, fig1_1$fit+1.96*fig1_1$se.fit, col='gray', lwd=1, lty=2)
lines(modes$normnetwobs, fig1_0$fit-1.96*fig1_0$se.fit, col='black', lwd=1, lty=2)
lines(modes$normnetwobs, fig1_0$fit+1.96*fig1_0$se.fit, col='black', lwd=1, lty=2)



# Table 3
# Model 1
glm3_1 <- glm(ECJPlAgree ~ percham + normPl + normDef,
              data=cgh[cgh$article169==1,], family=binomial(link='probit'))
# Model 2
glm3_2 <- glm(ECJPlAgree ~ percham + CommObsPl + CommObsDef + normPl + normDef,
              data=cgh[cgh$govislit==0 & cgh$article177==1,], family=binomial(link='probit'))


# Table 4
# Model 1
glm4_1 <- glm(ECJPlAgree ~ percham + CommIsPl + CommIsDef + CommObsPl + CommObsDef +
              govislit + normnetwobs + article177 + normwobs177 + normwobsgov +
              govlit177 + normwobsgov177, data=cgh, family=binomial(link='probit'))
# Model 2
glm4_2 <- glm(ECJPlAgree ~ percham + CommIsPl + CommIsDef + CommObsPl + CommObsDef +
              govislit + normnetwobs + article177 + normwobs177 + normwobsgov +
              govlit177 + normwobsgov177 + AGforPl, data=cgh, family=binomial(link='probit'))

# Gather all results:
sapply(ls(pattern='glm'), function(obj) round(summary(get(obj))$coef[,1:2],2))




