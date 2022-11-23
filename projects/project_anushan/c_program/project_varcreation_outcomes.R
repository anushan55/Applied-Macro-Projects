# TARGET: 
# INDATA: 
# OUTDATA/ OUTPUT:

################################################################################################################+
# INTRO	script-specific ####

#clear gobal environment of all but uppercase objects (globals, myfunctions, scalars)
CLEARCOND()

#adapt scriptname/ rfilename and extension if NOT executed in batch mode
MAINNAME_check <- rstudioapi::getActiveDocumentContext()$path #returns path+name of script currently executed (no outsourcing to program possible)
if ( !grepl("",MAINNAME_check)) {
  MAINNAME <- sub(".*/|^[^/]*$", "", MAINNAME_check)
  MAINNAME <- substr(MAINNAME,1,nchar(MAINNAME)-2) #cut off .R
}
######################+
#release unused memory 
gc()

################################################################################################################+
# MAIN PART ####
df<-LOAD(dfinput=paste0(DFBASE))

#Create variable
colnames(df)
colnames(df) <- sub("^pwt_log_gdp_w$","y",colnames(df))



#restrict 
df <- df[,c("ADMIN_ID","y")]
colnames(df)
SAVE(dfx=df)


