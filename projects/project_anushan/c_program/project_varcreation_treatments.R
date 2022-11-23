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
df<-LOAD(dfinput=paste0(DFBASE))


#create variable

#lag y 
df <- df %>%                            # Add lagged column
  group_by(id) %>%
  dplyr::mutate(ymin1 = dplyr::lag(pwt_log_gdp_w, n = 1, default = NA)) %>% 
  as.data.frame()


#continue adding other variables ..........................

colnames(df) <- sub("^pwt_log_kw$","k",colnames(df))

colnames(df) <- sub("^iiasa_share_hs_15_69","hs",colnames(df))

colnames(df) <- sub("^iiasa_w_15_19","S_less20",colnames(df))
colnames(df) <- sub("^iiasa_w_20_24","S_20_24",colnames(df))
colnames(df) <- sub("^iiasa_w_25_29","S_25_29",colnames(df))
colnames(df) <- sub("^iiasa_w_30_34","S_30_34",colnames(df))
colnames(df) <- sub("^iiasa_w_35_39","S_35_39",colnames(df))
colnames(df) <- sub("^iiasa_w_40_44","S_40_44",colnames(df))
colnames(df) <- sub("^iiasa_w_45_49","S_45_49",colnames(df))
colnames(df) <- sub("^iiasa_w_55_59","S_55_59",colnames(df))
colnames(df) <- sub("^iiasa_w_60_64","S_60_64",colnames(df))
colnames(df) <- sub("^iiasa_w_65_69","S_65plus" ,colnames(df))


colnames(df)


#df$edu2<-(df$edu)^2

#rename
#colnames(df) <- sub("urateb","UNEMRATE",colnames(df))

#restrict 

df <- df[,c("id","t","ymin1", "k", "hs", "S_less20", "S_20_24", "S_25_29", "S_30_34", "S_35_39",
            "S_40_44", "S_45_49", "S_55_59", "S_60_64", "S_65plus", "ADMIN_ID")]
colnames(df)

SAVE(dfx=df)
