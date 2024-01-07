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
df1 <- LOAD(dfinput="project_varcreation_outcomes")
df2 <- LOAD(dfinput="project_varcreation_treatments")
#...

#merge
df <- merge(df1,df2,by="ADMIN_ID") 
colnames(df)
SAVE(dfx=df)
