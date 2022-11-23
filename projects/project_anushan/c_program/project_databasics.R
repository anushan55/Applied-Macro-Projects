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

# Import dataset
setwd(A)
df <- read_dta("ks_data_text_5y.dta")

str(df$id)

df$id<-as.numeric(df$id)

#create original row id
df$ADMIN_ID <- seq.int(nrow(df))

#create subset without high income countries from the excel id
#df<- subset(df, df$id!=4 & df$id!=8 & df$id!=9 & df$id!=10 & df$id!=13 & df$id!=18 & df$id!=19 & df$id!=25 & df$id!=26 
 #           & df$id!=30 & df$id!=31 & df$id!=32 & df$id!=43 & df$id!=44 & df$id!=45 & df$id!=48 & df$id!=54 & df$id!=55
  #          & df$id!=57 & df$id!=59 & df$id!=62 & df$id!=69 & df$id!=73 & df$id!=75 & df$id!=77 & df$id!=80 & df$id!=83
   #         & df$id!=84 & df$id!=85 & df$id!=88 & df$id!=94 & df$id!=95 & df$id!=96 & df$id!=102 & df$id!=105 & df$id!=106
    #        & df$id!=107 & df$id!=108 & df$id!=110 & df$id!=118 & df$id!=131 & df$id!=132 & df$id!=134 & df$id!=135 & df$id!=136
     #       & df$id!=143 & df$id!=145 & df$id!=147 & df$id!=148 & df$id!=151 & df$id!=154 & df$id!=158 & df$id!=164 & df$id!=165
      #      & df$id!=166 & df$id!=168 & df$id!=177 & df$id!=181 & df$id!=185 & df$id!=186)

unique(df$country)

summary(df$country)

df<- subset(df,df$sample_iiasa==1)

#save as.rda
SAVE(dfx=df)