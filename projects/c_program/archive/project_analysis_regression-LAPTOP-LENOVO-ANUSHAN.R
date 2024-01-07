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
df<-LOAD(dfinput=paste0(DFMAIN),pattdir=A)

colnames(df)

#run regression equation 
#Model0 ### additive model
reg_main_model0<- lm(n~e+t+pie, df)
summary(reg_main_model0)
vif(reg_main_model0)

reg_main_model0_1<- lm(n~e, df)
reg_main_model0_2<- lm(n~e+t, df)
reg_main_model0_3<- lm(n~I(t-e)+pie, df)

# reg_main_t_e<- lm(t~e, df)
# summary(reg_main_t_e)

# reg_main_pie_e<- lm(pie~e, df)
# summary(reg_main_pie_e)

##log model 
reg_main_model1<- lm(ln_n~ln_tmine+ln_t+ln_pie, df)
summary(reg_main_model1)
vif(reg_main_model1)

#Export 

stargazer(reg_main_model0_1,reg_main_model0_2,reg_main_model0,reg_main_model0_3,  type="text", 
          title = "Regression results of Main sample:Additive model")



stargazer(reg_main_model0,reg_main_model1, type="text", 
          title = "Regression results of Main Sample: Additive model vs Log model")






################################################################################################################+
# Control Sample All countries ####
df_cont<-LOAD(dfinput=paste0("project_samplecreation_controls"),pattdir=A)
colnames(df_cont)

#model 0 
reg_cont_model0_1<- lm(n~e+t+pie, df_cont)
summary(reg_cont_model0_1)
vif(reg_cont_model0_1)

reg_cont_model0_2<- lm(n~e+t+pie+agemar, df_cont)
summary(reg_cont_model0_2)
vif(reg_cont_model0_2)

reg_cont_model0_3<- lm(n~e+t+pie+agemar+work, df_cont)
summary(reg_cont_model0_3)
vif(reg_cont_model0_3)

reg_cont_model0_4<- lm(n~e+t+pie+agemar+work+urban, df_cont)
summary(reg_cont_model0_4)
vif(reg_cont_model0_4)

reg_cont_model0_5<- lm(n~e+t+pie+agemar+work+urban+lac+africa , df_cont)
summary(reg_cont_model0_5)
vif(reg_cont_model0_4)

reg_cont_model0_6<- lm(n~e+t+pie+agemar+work+urban+factor(phase_number)+factor(country_code) , df_cont)
summary(reg_cont_model0_6)
vif(reg_cont_model0_6)

stargazer(reg_cont_model0_1,reg_cont_model0_2,reg_cont_model0_4, type="text", 
          title = "Regression results of Control sample: Additive model")

stargazer(reg_cont_model0_1,reg_cont_model0_4,reg_cont_model0_5, type="text", 
          title = "Regression results of Control sample: Additive model")

stargazer(reg_cont_model0_1,reg_cont_model0_4,reg_cont_model0_6, type="text", 
          title = "Regression results of Control sample: Additive model")

#model 1
reg_cont_model1_1<- lm(ln_n~ln_tmine+ln_t+ln_pie, df_cont)
summary(reg_cont_model1_1)
vif(reg_cont_model1_1)

reg_cont_model1_1_2<- lm(ln_n~ln_tmine+ln_pie+ln_t+agemar+work+urban, df_cont)
summary(reg_cont_model1_1_2)
vif(reg_cont_model1_1_2)

reg_cont_model1_1_3<- lm(ln_n~ln_tmine+ln_pie+ln_t+agemar+work+urban+factor(phase_number)+factor(country_code), df_cont)
summary(reg_cont_model1_1_2)
vif(reg_cont_model1_1_2)


stargazer(reg_cont_model1_1, reg_cont_model1_1_2, reg_cont_model1_1_3, type="text", 
          title = "Regression results of Control sample:Log Model ")


mean(df$n)

################################################################################################################+
# Phase 6 Sample ####
df_phase6<-LOAD(dfinput=paste0(DFMAIN, "_phase6"),pattdir=A)

### additive model
reg_main_phase6_model0<- lm(n~e+t+pie, df_phase6)

##log model 
reg_main_phase6_model1<- lm(ln_n~ln_tmine+ln_t+ln_pie, df_phase6)

#Export 
stargazer(reg_main_phase6_model0, reg_main_phase6_model1,reg_main_model1, type="text", 
          title = "Regression results of Phase 6  vs Main Sample")


################################################################################################################+
# Main Indo Sample ####
df_indo<-LOAD(dfinput=paste0(DFMAIN, "_indo"),pattdir=A)

### additive model
reg_main_indo_model0<- lm(n~e+t+pie, df_indo)

##log model 
reg_main_indo_model1<- lm(ln_n~ln_tmine+ln_t+ln_pie, df_indo)

#Export 
stargazer(reg_main_indo_model0, reg_main_indo_model1,reg_main_model1, type="text", 
          title = "Regression results of Indo Sample vs Main")

# #Indo: phase 1
# 
# ### additive model
# reg_main_indo_model0_1<- lm(n~e+t+pie, df_indo[df_indo$phase_number==1, ])
# 
# ##log model 
# reg_main_indo_model1_1<- lm(ln_n~ln_tmine+ln_t+ln_pie, df_indo[df_indo$phase_number==1, ])
# 
# #Export 
# stargazer(reg_main_indo_model0_1, reg_main_indo_model1_1,reg_main_model1, type="text", 
#           title = "Regression results of Indo Sample vs Main")
# 
# 
# #Indo: phase 6
# 
# ### additive model
# reg_main_indo_model0_6<- lm(n~e+t+pie, df_indo[df_indo$phase_number==6, ])
# 
# ##log model 
# reg_main_indo_model1_6<- lm(ln_n~ln_tmine+ln_t+ln_pie, df_indo[df_indo$phase_number==6, ])
# 
# #Export 
# stargazer(reg_main_indo_model0_6, reg_main_indo_model1_6,reg_main_indo_model1_1, type="text", 
#           title = "Regression results of Indo Sample phase 1 vs phase 6")



#### Main No India and Indonesia Sample
df_noindia<-LOAD(dfinput=paste0(DFMAIN, "_noindia"),pattdir=A)
unique(df_noindia$country_code)

### additive model
reg_main_noindia_model0<- lm(n~e+t+pie, df_noindia)

##log model 
reg_main_noindia_model1<- lm(ln_n~ln_tmine+ln_t+ln_pie, df_noindia)

#Export 
stargazer(reg_main_noindia_model0, reg_main_noindia_model1,reg_main_model1, type="text", 
          title = "Regression results of Main Sample without India")


...
....
.....





