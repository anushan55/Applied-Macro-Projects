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
# Main Sample All countries ###################################################
df<-LOAD(dfinput=paste0(DFMAIN),pattdir=A)

colnames(df)

#=================run main regression equation======================================
#Model0 ### normal model
reg_main_model0<- lm(n~e+t+pie, df)
summary(reg_main_model0)
colinear0<-vif(reg_main_model0)

# reg_main_model0_1<- lm(n~e, df)
# reg_main_model0_2<- lm(n~e+t, df)
# reg_main_model0_3<- lm(n~I(t-e)+pie, df)

# reg_main_t_e<- lm(t~e, df)
# summary(reg_main_t_e)

# reg_main_pie_e<- lm(pie~e, df)
# summary(reg_main_pie_e)

##log model 
reg_main_model1<- lm(ln_n~ln_tmine+ln_t+ln_pie, df)
summary(reg_main_model1)
colinear1<-vif(reg_main_model1)

####Export 
# stargazer(reg_main_model0_1,reg_main_model0_2,reg_main_model0,reg_main_model0_3,  type="text", 
#           title = "Regression results of Main sample:Additive model")
# 
# stargazer(reg_main_model0,reg_main_model1, type="text", 
#           title = "Regression results of Main Sample: Additive model vs Log model")

stargazer(reg_main_model0,reg_main_model1, type="latex", 
          title = "Regression results of Main Sample: Normal model vs Log model", align = TRUE)

stargazer(colinear0,colinear1, type="text", 
          title = "Colinearity results of Main Sample: Normal model vs Log model", align = TRUE)

################################################################################################################+
# Control Sample All countries ####
df_cont<-LOAD(dfinput=paste0("project_samplecreation_controls"),pattdir=A)
colnames(df_cont)

  #Simple model######
  reg_cont_model0_1<- lm(n~e+t+pie, df_cont)
  reg_cont_model0_2<- lm(n~e+t+pie+agemar+work+urban+gdp_pc+pop, df_cont)
  reg_cont_model0_3<- lm(n~e+t+pie+agemar+work+urban+gdp_pc+pop+factor(year)+factor(country_code), df_cont)
  #reg_cont_model0_3<- lm(n~e+t+pie+agemar+work+urban+lac+africa , df_cont)
  #reg_cont_model0_5<- lm(n~e+t+pie+agemar+work+urban+gdp_pc+pop+factor(husb_occ), df_cont)
 
    #print
     stargazer(reg_cont_model0_1,reg_cont_model0_2,reg_cont_model0_3, type="text", 
              title = "Regression results of Control sample: Simple model")
     stargazer(reg_cont_model0_1,reg_cont_model0_2,reg_cont_model0_3, type="latex", 
               title = "Regression results of Control sample: Normal model")
     
     stargazer(reg_cont_model0_3, type="text", 
               title = "Regression results of Control sample: Normal model")
     
     #colinearity tests
     vif(reg_cont_model0_1)
     vif(reg_cont_model0_2)
     vif(reg_cont_model0_3)
     


  ##log model#####
  reg_cont_model1_1<- lm(ln_n~ln_tmine+ln_t+ln_pie, df_cont)
  reg_cont_model1_2<- lm(ln_n~ln_tmine+ln_t+ln_pie+agemar+work+urban+gdp_pc+pop, df_cont)
  reg_cont_model1_3<- lm(ln_n~ln_tmine+ln_t+ln_pie+agemar+work+urban+gdp_pc+pop+factor(year)+factor(country_code), df_cont)
  # reg_cont_model1_4<- lm(ln_n~ln_tmine+ln_t+ln_pie+agemar+work+urban+gdp_pc+pop+lac+africa, df_cont)
  # reg_cont_model1_5<- lm(ln_n~ln_tmine+ln_t+ln_pie+agemar+work+urban+gdp_pc+pop+factor(phase_number)+factor(country_code), df_cont)


  stargazer(reg_cont_model1_1, reg_cont_model1_2, reg_cont_model1_3, type="text", 
            title = "Regression results of Control sample: Log Model ")
  
  stargazer(reg_cont_model1_1, reg_cont_model1_2, reg_cont_model1_3, type="latex", 
            title = "Regression results of Control sample: Log Model")
  
  stargazer(reg_cont_model1_3,reg_cont_model1_5, type="text", 
            title = "Regression results of Control sample: Log Model")

  
  vif(reg_cont_model1_1)
  vif(reg_cont_model1_2)
  vif(reg_cont_model1_3)
  
  stargazer(colinear3,colinear4, colinear5, colinear6, type="text", 
            title = "Colinearity results of Control Sample:Log model")
  

  mean(df$n)
    


################################################################################################################+
#==============Husband Education added =========================================
  
  # # Husband education Sample All countries ####
  df_2<-LOAD(dfinput=paste0(DFMAIN, "_2"),pattdir=A)
  colnames(df_2)
  
  #Husband education
  
    #Model0 ### normal model
    reg_husb_model0_1<- lm(n~e+t+pie+agemar+work+urban+gdp_pc+pop+factor(year)+factor(country_code), df_2)
    reg_husb_model0_2<- lm(n~husb_e+t+pie+agemar+work+urban+gdp_pc+pop+factor(year)+factor(country_code), df_2)
    
    df_2$e_2<-((df_2$e+df_2$husb_e)/2)
    summary(df_2$e_2)
    reg_husb_model0_3<- lm(n~e_2+t+pie, df_2)
    
    #Model1###log model 
    reg_husb_model1_0<- lm(ln_n~ln_tmine+ln_t+ln_pie+agemar+work+urban+gdp_pc+pop+factor(year)+factor(country_code), df_2)
    reg_husb_model1_1<- lm(ln_n~ln_tmine_husb+ln_t+ln_pie+agemar+work+urban+gdp_pc+pop+factor(year)+factor(country_code), df_2) 
    reg_husb_model1_2<- lm(ln_n~ln_tmine_2+ln_t+ln_pie++agemar+work+urban+gdp_pc+pop+factor(year)+factor(country_code), df_2) #Husband and wife combined time 
    
    
    stargazer(reg_husb_model1_0, reg_husb_model1_1, reg_husb_model1_2,  type="latex", 
              title = "Regression results of Husband Education Sample: Log Model")
    
    stargazer(reg_husb_model0_1,reg_husb_model0_2,reg_husb_model0_3,  type="latex", 
              title = "Regression results of Husband Education Sample: Log Model")
    
    
  #husband and wife education correlation 
  reg_main_husb_test<- lm(e~husb_e,df_2)
  summary(reg_main_husb_test)
  
  stargazer(reg_main_husb_test, type="latex", 
            title = "Relationship between husband and wife's education")
    
    
    
    

#====Survey Design elements added =============================================
#no difference in result##################

# # Main Sample All countries ####
# df_svy<-LOAD(dfinput=paste0(DFMAIN, "_svydesign"),pattdir=A)
# 
# colnames(df_svy)
# summary(df_svy$cluster)
# 
# #survey design specification
# df_design <- svydesign(ids = ~cluster,
#                        data = df_svy, 
#                        weights = ~smpwt)
# 
# 
# ##log model 
# #reg_main_model1_svy<- lm(ln_n~ln_tmine+ln_t+ln_pie, cluster=cluster, data=df_svy)
# reg_main_model1_svy<- lm(ln_n~ln_tmine+ln_t+ln_pie, design=df_design, data=df_svy)
# summary(reg_main_model1_svy)
# vif(reg_main_model1)
# 
# stargazer(reg_main_model1,reg_main_model1_svy, type="text", 
#           title = "Regression results with survey design on Log model")
    
    
    

###################################################################################
###Sub-sample tests ###########

##Main Sample Phase 6 only ####
df_6<-LOAD(dfinput=paste0(DFMAIN, "_phase6"),pattdir=A)

#run regression equation 
reg_main_phase6_model1<- lm(ln_n~ln_tmine+ln_t+ln_pie+agemar+work+urban+gdp_pc+pop+factor(year)+factor(country_code), df_6)


#--------------------------------------------
#Indonesia over different phases
df_indo<-LOAD(dfinput=paste0(DFMAIN, "_indo"),pattdir=A)

#run regression equation 
reg_indo_model1<- lm(ln_n~ln_tmine+ln_t+ln_pie+agemar+work+urban+gdp_pc+pop+factor(year), df_indo)
summary(reg_indo_model1)
vif(reg_indo_model1)

##Ignore Indonesia, results are weird 

##export
stargazer(reg_main_model1,reg_main_phase6_model1,type="text", 
          title = "Regression results of different sub samples")



#######################################################################
#-----------------------------------------------
#Main Sample: India and No India ######
df_ind<-LOAD(dfinput=paste0(DFMAIN, "_india"),pattdir=A)
df_noind<-LOAD(dfinput=paste0(DFMAIN, "_noindia"),pattdir=A)


table(df_ind$year)

#run regression equation 
reg_main_india_model1<- lm(ln_n~ln_tmine+ln_t+ln_pie+agemar+work+urban+gdp_pc+pop, df_ind)
reg_main_noindia_model1<- lm(ln_n~ln_tmine+ln_t+ln_pie+agemar+work+urban+gdp_pc+pop, df_noind)

summary(reg_main_india_model1)

#export 
stargazer(reg_main_phase6_model1, reg_main_india_model1,type="latex", 
          title = "Regression results of Subsample: Phase 6 (1) and India(2) ")

#-----------------------------------------------
###Continents
#Main Sample: Africa ######
df_af<-LOAD(dfinput=paste0(DFMAIN, "_africa"),pattdir=A)
df_lac<-LOAD(dfinput=paste0(DFMAIN, "_lac"),pattdir=A)
df_asia<-LOAD(dfinput=paste0(DFMAIN, "_asia"),pattdir=A)


#run regression equation 
reg_main_af_model1<- lm(ln_n~ln_tmine+ln_t+ln_pie+agemar+work+urban+gdp_pc+pop+factor(year)+factor(country_code), df_af)
reg_main_lac_model1<- lm(ln_n~ln_tmine+ln_t+ln_pie+agemar+work+urban+gdp_pc+pop+factor(year)+factor(country_code), df_lac)
reg_main_asia_model1<- lm(ln_n~ln_tmine+ln_t+ln_pie+agemar+work+urban+gdp_pc+pop+factor(year)+factor(country_code), df_asia)



#export -------------------------------------------
stargazer(reg_main_af_model1,reg_main_lac_model1,reg_main_asia_model1, type="latex", 
          title = "Regression results of Main sample: different continents")





