# TARGET: 
# INDATA: 
# OUTDATA/ OUTPUT:

################################################################################################################+
# INTRO	script-specific ####

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
# MAIN PART ####
df<-LOAD(dfinput=paste0(DFBASE))

colnames(df)

###restrict
df <- df[,c("ADMIN_ID","work", "husb_occ", "urban" , "agemar", "africa" ,"lac", "asia", "post2005","gdp_pc", "pop" )]
colnames(df)


SAVE(dfx=df)