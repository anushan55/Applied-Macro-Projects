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
df<-LOAD(dfinput=paste0(DFMAIN,"_ex1"),pattdir=A)

#plot and export
pdf(file=paste0(D,MAINNAME,"_scatter.pdf"))
plot(df$SCHOOLYEARS,df$GDPCAPLN)
abline(lm(GDPCAPLN ~ SCHOOLYEARS,data=df))
dev.off()


