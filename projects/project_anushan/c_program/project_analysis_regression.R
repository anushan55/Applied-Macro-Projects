# TARGET: 
# INDATA: 
# OUTDATA/ OUTPUT:

################################################################################################################+
# INTRO	script-specific ####

#clear gobal environment of all but uppercase objects (globals, myfunctions, scalars)
CLEARCOND()

#adapt scriptname/ rfilename and extension if NOT executed in batch mode
MAINNAME_check <- rstudioapi::getActiveDocumentContext()$path #returns path+name of script currently executed (no outsourcing to program possible)
if ( !grepl("00_execute",MAINNAME_check)) {
  MAINNAME <- sub(".*/|^[^/]*$", "", MAINNAME_check)
  MAINNAME <- substr(MAINNAME,1,nchar(MAINNAME)-2) #cut off .R
}
######################+
#release unused memory 
gc()

################################################################################################################+
# MAIN PART ####
df<-LOAD(dfinput=paste0(DFMAIN),pattdir=A)



# run regression equation 
reg1<- plm(y~ymin1+k+hs
           +S_less20+S_20_24+S_25_29+S_30_34+S_35_39+S_40_44+S_45_49+S_55_59+S_60_64+S_65plus
           ,data = df,
           effect = "twoways",
           model = "within",
           index = c("t", "id"))

summary(reg1)

reg2<- plm(y~ymin1+k+hs,
           data = df,
           effect = "twoways",
           model = "within",
           index = t, id)

reg3<- plm(y~ymin1+k+S_less20+S_20_24+S_25_29+S_30_34+S_35_39+S_40_44+S_45_49+S_55_59+S_60_64+S_65plus, 
           data = df,
           effect = "twoways",
           model = "within",
           index = t, id)
             

#export
stargazer(reg1,reg2,reg3, type="latex")
stargazer(reg1,reg2,reg3, type="text")



