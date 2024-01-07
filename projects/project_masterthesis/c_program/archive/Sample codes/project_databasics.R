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

# Import dataset
setwd(A)
df <- read_dta("ks_data_text_5y.dta")

str(df$id)

df$id<-as.numeric(df$id)

#create original row id
df$ADMIN_ID <- seq.int(nrow(df))

#save as.rda
SAVE(dfx=df)



#df<- subset(df,t==10)
# unique(df$country)
# summary(df$country)
#unique(df$sample_iiasa)
#df<- subset(df,df$sample_iiasa==1)
# colnames(df)



