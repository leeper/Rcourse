***REPLICATION OF CARRUBBA, GABEL, HANKLA ANALYSIS IN "JUDICIAL BEHAVIOR UNDER POLITICAL CONSTRAINTS", AMERICAN POLITICAL SCIENCE REIVEW, NOVEMBER 2008
***FILE CREATED NOVEMBER 18, 2998	

***create log file of results
set logtype textlog using apsrfinalresults.out, replace
***modify location of dataset to appropriate folder/driveclearset mem 500muse /Users/mjgabe1/Desktop/apsrreplication.dta

*Table 1

sum ECJPlAgree normnetwobs CommIsPl CommIsDef CommObsPl CommObsDef percham normwobsgov article177 govislit if ECJPlAgree ~=.
*Table 2
probit ECJPlAgree percham CommIsPl CommIsDef CommObsPl CommObsDef normnetwobs, cluster(casenumber)probit ECJPlAgree percham CommIsPl CommIsDef CommObsPl CommObsDef govislit normnetwobs normwobsgov, cluster(casenumber)lincom normnetwobs + normwobsgov

*Table 3

*normPl and normDef indicate the weighted observations for plaintiff and defendant, respectively, normalized for the increase in the number of member-states

probit ECJPlAgree percham normPl normDef if article169==1, cluster(casenumber)

probit ECJPlAgree percham CommObsPl CommObsDef normPl normDef if govislit==0 & article177==1, cluster(casenumber)



*Table 4

*without AG

probit ECJPlAgree percham CommIsPl CommIsDef CommObsPl CommObsDef govislit normnetwobs article177 normwobs177 normwobsgov govlit177 normwobsgov177, cluster(casenumber)lincom normnetwobs + normwobsgov

lincom normnetwobs + normwobs177
lincom normnetwobs + normwobs177 + normwobsgov + normwobsgov177 *with AGprobit ECJPlAgree percham AGforPl CommIsPl CommIsDef CommObsPl CommObsDef govislit normnetwobs article177 normwobs177 normwobsgov govlit177 normwobsgov177, cluster(casenumber)lincom normnetwobs + normwobsgov

lincom normnetwobs + normwobs177
lincom normnetwobs + normwobs177 + normwobsgov + normwobsgov177 * Supplemental Analyses presented in Table 6-8

*Table3-4 analyses with perobs in place of normnetwobsprobit ECJPlAgree percham CommIsPl CommIsDef CommObsPl CommObsDef perobs, cluster(casenumber)probit ECJPlAgree percham CommIsPl CommIsDef CommObsPl CommObsDef govislit perobs perobsgovlit, cluster(casenumber)lincom perobs + perobsgovlit
probit ECJPlAgree percham perobsPl perobsDef if article169==1, cluster(casenumber)

probit ECJPlAgree percham CommObsPl CommObsDef perobsPl perobsDef if govislit==0 & article177==1, cluster(casenumber)


***Table 3-4 analysis with GDP-weighted observationsprobit ECJPlAgree percham CommIsPl CommIsDef CommObsPl CommObsDef netGDPwobs, cluster(casenumber)probit ECJPlAgree percham CommIsPl CommIsDef CommObsPl CommObsDef govislit netGDPwobs netGDPwobsgov, cluster(casenumber)lincom netGDPwobs + netGDPwobsgov
probit ECJPlAgree percham GDPwobsPl GDPwobsDef if article169==1, cluster(casenumber)

probit ECJPlAgree percham GDPwobsPl CommObsDef GDPwobsPl GDPwobsDef if govislit==0 & article177==1, cluster(casenumber)


***Tables 3-4 analysis with trade-weighted observationsprobit ECJPlAgree percham CommIsPl CommIsDef CommObsPl CommObsDef nettradewobs, cluster(casenumber)probit ECJPlAgree percham CommIsPl CommIsDef CommObsPl CommObsDef govislit nettradewobs nettradewobsgov, cluster(casenumber)lincom nettradewobs + nettradewobsgov

probit ECJPlAgree percham tradewobsPl tradewobsDef if article169==1, cluster(casenumber)

probit ECJPlAgree percham CommObsPl CommObsDef tradewobsPl tradewobsDef if govislit==0 & article177==1, cluster(casenumber)
log close