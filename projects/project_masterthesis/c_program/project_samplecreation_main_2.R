# TARGET: Create a sample of main model with husband variables on education
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
df<-LOAD(dfinput=paste0(DFMERGE, "_husb"))

#check variables 
summary(df$husb_e)
summary(df$husb_work)

# df$husb_work <- NULL
# unique(husb_work)
# colnames(df)
# 
# df$husb_e <- NULL

#restrict to non-missing rows
dim(df)
df <- df[complete.cases(df),]
dim(df)


#save 
SAVE(dfx=df, namex = MAINNAME, pattdir = A)


#####################################################################################################################

