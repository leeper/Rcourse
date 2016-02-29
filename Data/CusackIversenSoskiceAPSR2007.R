# Reproduction and Extension of Cusack, Iversen, and Soskice (2007)

library("rio")
cis <- import("CusackIversenSoskiceAPSR2007.dta")

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


# models combining all right-hand side variables
lm_extra1 <- lm(thresh ~ stthroct2 + coordds + dispro2 + fragdum,
    data=cis[cis$smpl==1 & !is.na(cis$coordds),])
lm_extra2 <- lm(thresh ~ stthroct2 + coordds + dispro2 + fragdum,
    data=cis[cis$smpl==1 & cis$oursmpl==1 & !is.na(cis$dispro2) & !cis$cow==220,])

# models also accounting for British colonial history
cis$brit <- 
c(1, # USA
1, # Canada
1, # UK
1, # Ireland
0, # Netherlands
0, # Belgium
0, # Luxembourg
0, # France
0, # Switzerland
0, # Spain
0, # Germany
0, # Austria
0, # Italy
0, # Greece
0, # Finland
0, # Sweden
0, # Norway
0, # Denmark
0, # Iceland
0, # Japan
1, # Australia
1, # New Zealand
rep(0, 9)) # duplicated countries

lm_extra3 <- lm(thresh ~ stthroct2 + coordds + dispro2 + fragdum + brit,
    data=cis[cis$smpl==1 & !is.na(cis$coordds),])
lm_extra4 <- lm(thresh ~ stthroct2 + coordds + dispro2 + fragdum + brit,
    data=cis[cis$smpl==1 & cis$oursmpl==1 & !is.na(cis$dispro2) & !cis$cow==220,])

summary(lm_extra1)
summary(lm_extra2)
summary(lm_extra3)
summary(lm_extra4)

