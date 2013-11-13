# Englebert Replication

library(foreign)
eng <- read.dta('EnglebertPRQ2000.dta')

# Table 1
# Model 1
lm1_1 <- lm(growth ~ lcon + lconsq + g + i + goodgov, data=eng)
# Model 2
lm1_2 <- lm(growth ~ lcon + lconsq + g + i + ruleolaw, data=eng)
# Model 3
lm1_3 <- lm(growth ~ lcon + lconsq + g + i + pubadmin, data=eng)

# Table 2
# Model 1
lm2_1 <- lm(goodgov ~ london + paris + brussels + lisbon + warciv + hieafvs +
                      language + elf, data=eng)
# Model 2
lm2_2 <- lm(goodgov ~ london + paris + brussels + lisbon + warciv + hieafvs +
                      language + elf + vlegit, data=eng)
# Model 3
lm2_3 <- lm(goodgov ~ london + paris + brussels + lisbon + warciv + hieafvs +
                      language + elf + vlegit + hieafvm, data=eng)
# Model 4
lm2_4 <- lm(goodgov ~ london + paris + brussels + lisbon + warciv + hieafvs +
                      language + elf + hlegit, data=eng)
# Model 5
lm2_5 <- lm(goodgov ~ london + paris + brussels + lisbon + warciv + hieafvs +
                      language + elf + hlegit + hieafvm, data=eng)

# Table 3
# Note: NAs create problems here
vtmp <- lm(goodgov ~ vlegit, data=eng)
htmp <- lm(goodgov ~ hlegit, data=eng)
engv <- eng[-vtmp$na.action,]
engh <- eng[-htmp$na.action,]
engv$goodgovvres <- vtmp$residuals
engh$goodgovhres <- htmp$residuals

# Model 1
lm3_1 <- lm(growth ~ lcon + lconsq + g + i + goodgovvres, data=engv)
# Model 2
lm3_2 <- lm(growth ~ lcon + lconsq + g + i + goodgovvres + vlegit, data=engv)
# Model 3
lm3_3 <- lm(growth ~ lcon + lconsq + g + i + goodgovhres + hlegit, data=engh)
# Model 4
lm3_4 <- lm(growth ~ lcon + lconsq + g + i + goodgovvres + vlegit + elf, data=engv)
# Model 5
lm3_5 <- lm(growth ~ lcon + lconsq + g + i + goodgovhres + hlegit + elf, data=engh)

# Figure 1
plot(eng$hlegit, eng$goodgov, col='white')
text(eng$hlegit, eng$goodgov, labels=as.character(eng$wbcode), cex=.8)


# Get all regression results for all models
sapply(ls(pattern='lm'), function(obj) signif(summary(get(obj))$coef[,c(1,3)],2))


