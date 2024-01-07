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


colnames(df) <- sub("^edyrs$","e",colnames(df))
colnames(df) <- sub("^lifeex_tmin1$","t",colnames(df))
df$tmine<- (df$t - df$e)

df$ln_tmine <- ln(df$tmine)
df$ln_t <- ln(df$t)
df$ln_pie<- ln(df$pie)

#remove pie=0 
df<-subset(df, pie!=0)
summary(df$ln_pie)


###restrict
df <- df[,c("ADMIN_ID", "year", "country_code" ,"phase_number", "ln_tmine", "ln_t", "ln_pie" ,  "pie" ,"e","t","tmine")]
colnames(df)

SAVE(dfx=df)






