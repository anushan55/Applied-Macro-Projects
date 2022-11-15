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
df<-LOAD(dfinput=paste0(DFMERGE,"_ex5"))

#restrict cols -> already in varcreation section given only vars of specific type are saved for merge

#restrict to non-missing rows
dim(df)
df <- df[complete.cases(df),]
dim(df)

#save 
SAVE(dfx=df,namex=MAINNAME,pattdir=A)