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
  MAINNAME <- MAINNAME_check
  MAINNAME <- sub(".*/|^[^/]*$", "", MAINNAME)
}
######################+
#release unused memory 
gc()

################################################################################################################+
# MAIN PART ####
df<-LOAD(dfinput=paste0(DFMAIN,"_ex3"),pattdir=A)


# run regression equation 
reg1<- lm(logwphy ~ urateb, data = df)
summary (reg1) 

reg2 <- lm(logwphy ~ urateb + (urateb)^2, data=df)
summary(reg2)


#export
stargazer(reg1,reg2,type="text")
