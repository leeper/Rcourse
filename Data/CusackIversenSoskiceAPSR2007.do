///Table 3:

///Column 1:

reg thresh  threat fragdum if smpl==1

///column 2: 

reg thresh threat fragdum if smpl==1 &  oursmpl==1


///Column 3:

reg thresh threat13 fragdum if smpl==1 &  oursmpl==1


///Column 4:

reg thresh  stthroct2 fragdum if smpl==1 &  oursmpl==1


///Table 5:

///Column 1:

reg thresh stthroct2 fragdum if smpl==1 &  oursmpl==1 & coordds~=.


///Col///umn 2:

reg thresh stthroct2 coordds fragdum if smpl==1 &  oursmpl==1 & coordds~=.


///Column 3: 


reg thresh coordds if smpl==1 & coordds~=.


///Column 4:

reg thresh  stthroct2 fragdum if smpl==1 &  oursmpl==1 &  dispro2~=. & cow~=220

///Column 5:

reg thresh  stthroct2 dispro2 fragdum if smpl==1 &  oursmpl==1 &  dispro2~=. & cow~=220

