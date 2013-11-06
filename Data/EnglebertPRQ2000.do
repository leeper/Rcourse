* Table 1
** model 1
reg growth lcon lconsq g i goodgov
** model 2
reg growth lcon lconsq g i ruleolaw
** model 3
reg growth lcon lconsq g i pubadmin

* calculate lconsq from lcon
gen lcon2 = lcon^2


* Table 2
** model 1
reg goodgov london paris brussels lisbon warciv hieafvs language elf
** model 2
reg goodgov london paris brussels lisbon warciv hieafvs language elf vlegit
** model 3
reg goodgov london paris brussels lisbon warciv hieafvs language elf vlegit hieafvm
** model 4
reg goodgov london paris brussels lisbon warciv hieafvs language elf hlegit
** model 5
reg goodgov london paris brussels lisbon warciv hieafvs language elf hlegit hieafvm


* Table 3
reg goodgov vlegit
predict goodgovvres, r
reg goodgov hlegit
predict goodgovhres, r
** model 1
reg growth lcon lconsq g i goodgovvres
*reg growth lcon lconsq g i goodgovhres
** model 2
reg growth lcon lconsq g i goodgovvres vlegit
** model 3
reg growth lcon lconsq g i goodgovhres hlegit
** model 4
reg growth lcon lconsq g i goodgovvres vlegit elf
** model 5
reg growth lcon lconsq g i goodgovhres hlegit elf


* Figure 1
scatter goodgov hlegit, mlabel(wbcode)
