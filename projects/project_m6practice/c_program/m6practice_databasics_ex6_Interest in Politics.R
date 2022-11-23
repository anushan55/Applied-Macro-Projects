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

# Import dataset
setwd(A)
df <- read_dta("GoodBad_Control (simulated) - Interest in Politics.dta")

#create original row id
df$ADMIN_ID <- seq.int(nrow(df))

#save as.rda
SAVE(dfx=df,namex=MAINNAME,pattdir=A)