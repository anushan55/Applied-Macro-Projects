# TARGET: Create a sample of main model with treatment including the svydesign features
# INDATA: 
# OUTDATA/ OUTPUT:

################################################################################################################+
# All countries ####

#clear gobal environment of all but uppercase objects (globals, myfunctions, scalars)
CLEARCOND()

#adapt scriptname/ rfilename and extension if NOT executed in batch mode
MAINNAME <- current_filename()
MAINNAME <- sub(".*/|^[^/]*$", "", MAINNAME)
MAINNAME <- substr(MAINNAME,1,nchar(MAINNAME)-2) #cut off .R
######################+
#release unused memory 
gc()


################################################################################################################+
# Load Main Data ####
df<-LOAD(dfinput=paste0(DFMERGE, "_svydesign"))

#restrict to non-missing rows
dim(df)
df <- df[complete.cases(df),]
dim(df)


#save 
SAVE(dfx=df, namex = MAINNAME, pattdir = A)


#####################################################################################################################
