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
# Main Sample All countries ####
df<-LOAD(dfinput=paste0(DFMAIN, "_svydesign"),pattdir=A)

colnames(df)

#survey design specification
df_design <- svydesign(ids = ~cluster,
                        data = df, 
                        weights = ~smpwt)


##log model 

reg_main_model1<- lm(ln_n~ln_tmine+ln_t+ln_pie, cluster=cluster, data=df)
#reg_main_model1<- lm(ln_n~ln_tmine+ln_t+ln_pie, design=df_design, data=df)
summary(reg_main_model1)
vif(reg_main_model1)


