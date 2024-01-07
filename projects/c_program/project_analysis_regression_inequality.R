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


###Load database
df_svy<-LOAD(dfinput=paste0(DFMAIN, "_svydesign"),pattdir=A)
df_cont<-LOAD(dfinput=paste0("project_samplecreation_controls"),pattdir=A)
df_codes<-read_dta("dhs_country_codes.dta")


###Gini Calculation for each country and phase ################################
#df_svy_cont<-left_join(df_svy, df_cont[ ,c("ADMIN_ID", "gdp_pc", "africa", "lac")], by = "ADMIN_ID")


df_sum <- df_svy %>%
  group_by(country_code,phase_number) %>%
  summarise(edu_gini = DescTools::Gini(e, weights = smpwt),
            n_gini = DescTools::Gini(n, weights = smpwt),
            e= weighted.mean(e,weights = smpwt),
            t= weighted.mean(t,weights = smpwt), 
            pie = weighted.mean(pie,weights = smpwt),
            n=weighted.mean(n,weights = smpwt),
            .groups = "drop")

###############################################################################

##Regression ###########
reg_1<- lm(n~edu_gini, data = df_sum)
reg_2<- lm(n~edu_gini+e, data = df_sum)
reg_2_1<- lm(n~edu_gini+I(edu_gini^2)+e, data = df_sum)
vif(reg_2)
reg_3<-lm(edu_gini~e, data = df_sum)

reg_4<- lm(edu_gini~e+factor(phase_number), data=df_sum)
summary(reg_2_1)

stargazer(reg_1, reg_2,reg_2_1, type = "latex", 
          title = "Relationship between education inequality and fertility outcomes in a country")
stargazer(reg_3, type = "latex", 
          title = "Relationship between education inequality and education outcomes")


###predict the movements between gini and fertility 

edugini_predict <- data.frame(edu_gini= seq(from = min(0), to = max(1), length.out = 100),
                              e = 8)

edugini_predict$predicted_n<-predict(reg_2,edugini_predict )

pdf(file=paste0(D,MAINNAME,"_edugini_fertility_predict.pdf"))
plot(edugini_predict$edu_gini, edugini_predict$predicted_n,
     xlab = "Education Gini", ylab = "Predicted Fertility",
     main = "Effect of Education Gini on Fertility", type = "l")
dev.off()


edugini_predict$predicted_n_2<-predict(reg_2_1,edugini_predict )

pdf(file=paste0(D,MAINNAME,"_edugini_fertility_predict_2.pdf"))
plot(edugini_predict$edu_gini, edugini_predict$predicted_n_2,
     xlab = "Education Gini", ylab = "Predicted Fertility",
     main = "Effect of Education Gini on Fertility", type = "l")
dev.off()



###Regression based on residual of both education and fertility 

reg_edugini<- lm(edu_gini~e, df_sum)
residual_edugini<- resid(reg_edugini)

reg_n<- lm(n~e, df_sum)
residual_n<- resid(reg_n)

reg_resid<- lm(residual_n~residual_edugini)
reg_resid_2<- lm(residual_n~residual_edugini+I(residual_edugini^2) )

summary(reg_resid)
stargazer(reg_resid,reg_resid_2, type = "latex", 
          title = "Effects of education Inequality on fertility" )


################################################################################


###Regression of education gini and fertillity gini 

colnames(df_sum)
reg_gini_fe<- lm(n_gini~edu_gini, df_sum)
summary(reg_gini_fe)

stargazer(reg_gini_fe, type = "latex", 
          title = "Relationship between fertility inequality and education inequality")

pdf(file=paste0(D,MAINNAME,"_edugini and fertility_gini.pdf"))
ggplot(df_sum, aes(edu_gini,n_gini))+geom_point() +labs(title="All phases") + geom_smooth(method = 'lm', se=FALSE)
dev.off()



################################################################################

##regression of main model 

#create variables for regression
df_sum$tmine<- (df_sum$t - df_sum$e)
df_sum$ln_tmine <- ln(df_sum$tmine)
df_sum$ln_t <- ln(df_sum$t)
df_sum$ln_pie<- ln(df_sum$pie)
df_sum$ln_n<- ln(df_sum$n)
df_sum$ln_edu_gini<- ln(df_sum$edu_gini)


##log model 
reg_main_model1<- lm(ln_n~ln_tmine+ln_t+ln_pie, df_sum)
summary(reg_main_model1)
vif(reg_main_model1)

##log model 
reg_main_model2<- lm(ln_n~ln_tmine+ln_t+ln_pie+ln_edu_gini, df_sum)
summary(reg_main_model2)
vif(reg_main_model2)

stargazer(reg_main_model1,reg_main_model2, type = "latex", 
          title = "Education Inequality added to the main log model" )




################################################################################

####PRINT SUMMARY TABLES ###########################################

#Create table for print with all figures 
df_sum_print <- df_sum %>%
  mutate(edu_gini=round(edu_gini, 2),
         n_gini=round(n_gini, 2), 
         e=round(e, 2),
         t=round(t, 2),
         pie=round(pie, 2),
         n=round(n, 2)
  )


##Edit country codes for Print
df_codes_na<-data.frame(country_code_str = c("CR", "FJ", "KR", "MY", "PA", "SY"),
                        CountryName = c("Costa Rica ", "Fiji", "Korea", "Malaysia", "Panama", "Syria"))

df_codes <- dplyr::bind_rows(df_codes, df_codes_na)

colnames(df_codes) <- sub("country_code_str","country_code",colnames(df_codes))

df_sum_print<-left_join(df_sum_print, df_codes, by="country_code")

df_sum_print<-df_sum_print[ , c("CountryName", "phase_number", "edu_gini", "e", "n", "n_gini", "t", "pie", "n")]

stargazer(df_sum_print,summary=FALSE, rownames=FALSE, type="text")


#FIGURE: average for multiple phases ##########################################
df_sum_phase_avg <- df_sum %>%
  group_by(phase_number) %>%
  summarise(edu_gini_avg=mean(edu_gini),
            .groups = "drop")

pdf(file=paste0(D,MAINNAME,"_edugini_avg_overtime.pdf"))
ggplot(df_sum_phase_avg, aes(x=phase_number,y=edu_gini_avg))+geom_line()+geom_point()+
  labs(title="Education Gini for all countries averages at different phases")+xlab("Phase Number") + ylab("Education Gini (Average)")
dev.off()


#relationship between edugini and fertility ##################################
pdf(file=paste0(D,MAINNAME,"_edugini and fertility_allphases.pdf"))
ggplot(df_sum, aes(edu_gini,n))+geom_point() +
  labs(title="All phases")+ xlab("Education Gini") + ylab("Average Fertility")+ 
  geom_smooth(method = 'lm', se=FALSE)
dev.off()

#edu_gini one phase
df_sum_phase6<- df_sum[df_sum$phase_number==6, ]

pdf(file=paste0(D,MAINNAME,"_edugini and fertility_phase6.pdf"))
ggplot(df_sum_phase6, aes(edu_gini,n))+geom_point()+
  geom_text(aes(label=country_code), check_overlap = TRUE, vjust = -0.5) +
  labs(title="Phase 6") + xlab("Education Gini") + ylab("Average Fertility")+
  geom_smooth(method = 'lm', se=FALSE )
dev.off()


#education and edu gini
pdf(file=paste0(D,MAINNAME,"_edugini and education_allphases.pdf"))
ggplot(df_sum, aes(e,edu_gini))+geom_point() +
  labs(title="All phases") + xlab("Average years of Education") + ylab("Education Gini")+
  geom_smooth(method = 'lm', se=FALSE)
dev.off()




