# Replication of Cusack, Iversen, and Soskice (2007)


library(foreign)
cis <- read.dta('CusackIversenSoskiceAPSR2007.dta')

# Table 3
# Model 1
lm3_1 <- lm(thresh ~ threat + fragdum, data=cis[cis$smpl==1,])
# Model 2
lm3_2 <- lm(thresh ~ threat + fragdum, data=cis[cis$smpl==1 & cis$oursmpl==1,])
# Model 3
lm3_3 <- lm(thresh ~ threat13 + fragdum, data=cis[cis$smpl==1 & cis$oursmpl==1,])
# Model 4
lm3_4 <- lm(thresh ~ stthroct2 + fragdum, data=cis[cis$smpl==1 & cis$oursmpl==1,])


# Table 5
lm5_1 <- lm(thresh ~ stthroct2 + fragdum,
    data=cis[cis$smpl==1 & cis$oursmpl==1 & !is.na(cis$coordds),])
lm5_2 <- lm(thresh ~ stthroct2 + coordds + fragdum,
    data=cis[cis$smpl==1 & cis$oursmpl==1 & !is.na(cis$coordds),])
lm5_3 <- lm(thresh ~ stthroct2 + coordds,
    data=cis[cis$smpl==1 & !is.na(cis$coordds),])
lm5_4 <- lm(thresh ~ stthroct2 + fragdum,
    data=cis[cis$smpl==1 & cis$oursmpl==1 & !is.na(cis$dispro2) & !cis$cow==220,])
# Note: lm5_4 is not replicable in their do-file, either
lm5_5 <- lm(thresh ~ stthroct2 + dispro2 + fragdum,
    data=cis[cis$smpl==1 & cis$oursmpl==1 & !is.na(cis$dispro2) & !cis$cow==220,])
# Note: lm5_5 is not replicable in their do-file, either
lm5_6 <- lm(thresh ~ dispro2,
    data=cis[cis$smpl==1 & cis$oursmpl==1 & !is.na(cis$dispro2) & !cis$cow==220,])
# Note: lm5_6 is not in their do-file

# Get all regression results for all models
sapply(ls(pattern='lm'), function(obj) round(summary(get(obj))$coef[,1:2],2))


