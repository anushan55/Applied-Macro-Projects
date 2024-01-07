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
# All countries ####
df<-LOAD(dfinput=paste0(DFMAIN,"_all"),pattdir=A)

#run regression equation 
reg1<- plm(y~S_less20+S_20_24+S_25_29+S_30_34+S_35_39+S_40_44+S_45_49+S_55_59+S_60_64+S_65plus
           +ymin1+k, 
           data = df,
           effect = "twoways",
           model = "within",
           index = c("id","t"))

reg2<- plm(y~ymin1+k+hs, 
           data = df,
           effect = "twoways",
           model = "within",
           index = c("id","t"))


reg3<- plm(y~1+S_less20+S_20_24+S_25_29+S_30_34+S_35_39+S_40_44+S_45_49+S_55_59+S_60_64+S_65plus
           +ymin1+k+hs, 
           data = df,
           effect = "twoways",
           model = "within",
           index = c("id","t"))

reg4<- lm(y~S_less20+S_20_24+S_25_29+S_30_34+S_35_39+S_40_44+S_45_49+S_55_59+S_60_64+S_65plus
          +ymin1+k+hs+ as.factor(t) + as.factor(id), data = df)



summary(reg4)

#export

stargazer(reg1,reg2,reg3, type="latex", 
          title = "Regression results of ageing and education on economic performance: All countries",
          out =paste0(D,MAINNAME,"_all.tex"))

stargazer(reg1,reg2,reg3, type="text", title = "Regression results of ageing and education on economic performance: All countries")


#save

save(reg4,file = "project_analysis_regression_all" )

################################################################################
################################################################################################################+
# Developing countries specific ####
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
# All countries ####
df<-LOAD(dfinput=paste0(DFMAIN,"_developing"),pattdir=A)

#run regression equation 
reg1<- plm(y~S_less20+S_20_24+S_25_29+S_30_34+S_35_39+S_40_44+S_45_49+S_55_59+S_60_64+S_65plus
           +ymin1+k, 
           data = df,
           effect = "twoways",
           model = "within",
           index = c("id","t"))

reg2<- plm(y~ymin1+k+hs, 
           data = df,
           effect = "twoways",
           model = "within",
           index = c("id","t"))


reg3<- plm(y~1+S_less20+S_20_24+S_25_29+S_30_34+S_35_39+S_40_44+S_45_49+S_55_59+S_60_64+S_65plus
           +ymin1+k+hs, 
           data = df,
           effect = "twoways",
           model = "within",
           index = c("id","t"))

reg4<- lm(y~S_less20+S_20_24+S_25_29+S_30_34+S_35_39+S_40_44+S_45_49+S_55_59+S_60_64+S_65plus
          +ymin1+k+hs+ as.factor(t) + as.factor(id), data = df)



summary(reg4)

#export

stargazer(reg1,reg2,reg3, type="latex", 
          title = "Regression results of ageing and education on economic performance: Developing countries",
          out =paste0(D,MAINNAME,"_developing.tex"))

stargazer(reg1,reg2,reg3, type="text", title = "Regression results of ageing and education on economic performance: Developing countries")


#save

save(reg4,file = "project_analysis_regression_developing" )



################################################################################################################+
# Developed countries specific ####
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
df<-LOAD(dfinput=paste0(DFMAIN,"_developed"),pattdir=A)



#run regression equation 
reg1<- plm(y~S_less20+S_20_24+S_25_29+S_30_34+S_35_39+S_40_44+S_45_49+S_55_59+S_60_64+S_65plus
           +ymin1+k, 
           data = df,
           effect = "twoways",
           model = "within",
           index = c("id","t"))

reg2<- plm(y~ymin1+k+hs, 
           data = df,
           effect = "twoways",
           model = "within",
           index = c("id","t"))


reg3<- plm(y~1+S_less20+S_20_24+S_25_29+S_30_34+S_35_39+S_40_44+S_45_49+S_55_59+S_60_64+S_65plus
           +ymin1+k+hs, 
           data = df,
           effect = "twoways",
           model = "within",
           index = c("id","t"))

reg4<- lm(y~S_less20+S_20_24+S_25_29+S_30_34+S_35_39+S_40_44+S_45_49+S_55_59+S_60_64+S_65plus
          +ymin1+k+hs+ as.factor(t) + as.factor(id), data = df)



summary(reg4)

#export

stargazer(reg1,reg2,reg3, type="latex",
          title = "Regression results of ageing and education on economic performance: Developed countries",
          out =paste0(D,MAINNAME,"_developed.tex")
          )

stargazer(reg1,reg2,reg3, type="text", title = "Regression results of ageing and education on economic performance: Developed countries")


#save

save(reg4,file = "project_analysis_regression_developed" )

################################################################################









