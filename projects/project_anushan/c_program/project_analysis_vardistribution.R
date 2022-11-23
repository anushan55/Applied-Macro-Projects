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

#summarystats
summary(df)

dim(df)
head(df,20)
tail(df)
ggplot(df, aes(k,y))+geom_point()

ggplot(df, aes(ymin1,y))+geom_point()

ggplot(df, aes(hs,y))+geom_point()

#save 
#SAVE(dfx=df,namex=MAINNAME,pattdir=A)