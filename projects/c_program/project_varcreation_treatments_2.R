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
unique(df$husb_occ)
table(df$husb_occ)

colnames(df) <- sub("^edyrs$","e",colnames(df))
colnames(df) <- sub("^husb_edyrs$","husb_e",colnames(df))
colnames(df) <- sub("^husb_occ$","husb_work",colnames(df))
colnames(df) <- sub("^lifeex_tmin1$","t",colnames(df))

df$ln_t<- ln(df$t)
df$tmine<- (df$t-df$e)
df$ln_tmine<- ln(df$tmine)

df$ln_husb_e<-ln(df$husb_e)
df$tmine_husb<- (df$t-df$husb_e)
df$ln_tmine_husb<-ln(df$tmine_husb)

df$e_2<-(df$e+df$husb_e)/2
df$tmine_2<- df$t - df$e_2
df$ln_tmine_2 <- ln(df$tmine_2)

colnames(df)

df$ln_pie<- ln(df$pie)

#remove pie=0 
df<-subset(df, pie!=0)
summary(df$ln_pie)

colnames(df)

###restrict
df <- df[ , c("ADMIN_ID",
                "husb_e", "husb_work","tmine_husb","ln_husb_e", 
                "ln_tmine_husb","e_2", "tmine_2", "ln_tmine_2")]

###restrict
# df <- df[ , c("ADMIN_ID","year", "country_code" ,"phase_number",
#               "pie" ,"e","t","tmine", 
#               "ln_tmine", "ln_t", "ln_pie",
#               "husb_e", "husb_work","tmine_husb","ln_husb_e", 
#               "ln_tmine_husb","e_2", "tmine_2", "ln_tmine_2")]


colnames(df)

SAVE(dfx=df)

