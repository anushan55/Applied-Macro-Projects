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

#load all databases
df<-LOAD(dfinput=paste0(DFMAIN),pattdir=A)

df_6<-LOAD(dfinput=paste0(DFMAIN, "_phase6"),pattdir=A)

df_2<- LOAD(dfinput=paste0(DFMAIN, "_2"),pattdir=A)


#all phases##########################################################################################################
# identify which phase has more observation  ####################

pdf(file=paste0(D,MAINNAME,"_dist_phases.pdf"))
ggplot(df, aes(x=phase_number))+
  geom_histogram()+
  labs(title = "Number of observations in each phase",
       x = "Phase Number",
       y = "Observations")+
  scale_x_continuous(
    breaks = unique(df$phase_number),
    labels = unique(df$phase_number),
    )
dev.off()
  
table(df$phase_number)

colnames(df)



## distribution of each variable ###############

#fertility 
pdf(file=paste0(D,MAINNAME,"_dist_fertility.pdf"))
ggplot(df, aes(x = n)) +
  geom_histogram(binwidth = 1, fill = "skyblue", color = "black") +
  labs(title = "Distribution of gross fertility",
       x = "number of children ever born",
       y = "Count")
dev.off()
summary(df$n)

#education of mother
pdf(file=paste0(D,MAINNAME,"_dist_education.pdf"))
ggplot(df, aes(x = e)) +
  geom_histogram(binwidth = 1, fill = "skyblue", color = "black") +
  labs(title = "Distribution of highest education attained",
       x = "Education in single years",
       y = "Count")
dev.off()
summary(df$e)

# Generate ECDF plot
plot(ecdf(df$e), main="ECDF Plot", xlab="Values", ylab="ECDF")

qqnorm(df$e)


#life expectancy 
pdf(file=paste0(D,MAINNAME,"_dist_lifeexpectancy.pdf"))
ggplot(df, aes(x = t)) +
  geom_histogram(binwidth = 1, fill = "skyblue", color = "black") +
  labs(title = "Distribution of life expectancy",
       x = "Adult Life expectancy",
       y = "Count")
dev.off()
summary(df$t)

#countries
table(df$country_code)

#pie 
pdf(file=paste0(D,MAINNAME,"_dist_survival.pdf"))
ggplot(df, aes(x = pie)) +
  geom_histogram (fill = "skyblue", color = "black") +
  labs(title = "Distribution of survival rate",
       x = "Survival rate (pie)",
       y = "Count")
dev.off()
summary(df$pie)


pdf(file=paste0(D,MAINNAME,"_dist_ln_survival.pdf"))
ggplot(df, aes(x = ln_pie)) +
  geom_histogram (fill = "skyblue", color = "black") +
  labs(title = "Distribution of survival rate",
       x = "Survival rate (pie)",
       y = "Count")
dev.off()
summary(df$ln_pie) #min is -inf

infinite_ln_pie<- subset(df, ln_pie< -2)


#Check the type of relationship between dependent and independent variable 

unique(df$phase_number)
unique(df$country_code)

summary(df$n)
pdf(file=paste0(D,MAINNAME,"_relation_e_n.pdf"))
ggplot(df, aes(e,n))+geom_point() +labs(title="All phases") + geom_smooth(method = 'lm')
dev.off()

pdf(file=paste0(D,MAINNAME,"_relation_n_t.pdf"))
ggplot(df, aes(t,n))+geom_point() + geom_smooth(method = 'lm')+labs(title="All phases")
dev.off()

pdf(file=paste0(D,MAINNAME,"_relation_n_pie.pdf"))
ggplot(df, aes(pie,n))+geom_point() + geom_smooth(method = 'lm')+labs(title="All phases")
dev.off()

pdf(file=paste0(D,MAINNAME,"_relation_ln_tmine_ln_n.pdf"))
ggplot(df, aes(ln_tmine,ln_n))+geom_point() + geom_smooth(method = 'lm')+labs(title="All phases")
dev.off()



#check the type of relationship between independent variables 

pdf(file=paste0(D,MAINNAME,"_relation_t_pie.pdf"))
ggplot(df, aes(pie,t))+geom_point() + geom_smooth(method = 'lm')+labs(title="All phases")
dev.off()

pdf(file=paste0(D,MAINNAME,"_relation_t_e.pdf"))
ggplot(df, aes(e,t))+geom_point() + geom_smooth(method = 'lm')+labs(title="All phases")
dev.off()


##################################################################################
###Husband education######

pdf(file=paste0(D,MAINNAME,"_relation_e_husb_e.pdf"))
ggplot(df_2, aes(e,husb_e))+geom_point() + geom_smooth(method = 'lm')+labs(title="All phases")
dev.off()


######################################################################################################
# #phase 6 #######################################################################
# 
# ##distribution of each variable 
# 
# #fertility 
# pdf(file=paste0(D,MAINNAME,"_dist_fertility_phase6.pdf"))
# ggplot(df_6, aes(x = n)) +
#   geom_histogram(binwidth = 1, fill = "skyblue", color = "black") +
#   labs(title = "Distribution of gross fertility (Phase 6)",
#        x = "number of children ever born",
#        y = "Count")
# dev.off()
# 
# summary(df_6$n)
# 
# #education of mother
# pdf(file=paste0(D,MAINNAME,"_dist_education_phase6.pdf"))
# ggplot(df_6, aes(x = e)) +
#   geom_histogram(binwidth = 1, fill = "skyblue", color = "black") +
#   labs(title = "Distribution of highest education attained (Phase 6)",
#        x = "Education in single years",
#        y = "Count")
# dev.off()
# summary(df_6$e)
# 
# #life expectancy 
# pdf(file=paste0(D,MAINNAME,"_dist_lifeexpectancy_phase6.pdf"))
# ggplot(df_6, aes(x = t)) +
#   geom_histogram(binwidth = 1, fill = "skyblue", color = "black") +
#   labs(title = "Distribution of life expectancy (Phase 6)",
#        x = "Adult Life expectancy",
#        y = "Count")
# dev.off()
# summary(df_6$t)
# 
# #countries
# table(df_6$country_code)
# 
# #pie 
# pdf(file=paste0(D,MAINNAME,"_dist_survival_phase6.pdf"))
# ggplot(df_6, aes(x = pie)) +
#   geom_histogram(fill = "skyblue", color = "black") +
#   labs(title = "Distribution of survival rate (Phase 6)",
#        x = "Survival rate (pie)",
#        y = "Count")
# dev.off()
# summary(df_6$pie)
# 
# 
# #Check the type of relationship between dependent and independent variable 
# 
# unique(df_6$phase_number)
# unique(df_6$country_code)
# 
# summary(df_6$n)
# pdf(file=paste0(D,MAINNAME,"_relation_e_n_6.pdf"))
# ggplot(df_6, aes(e,n))+geom_point() +labs(title="Phase 6") + geom_smooth(method = 'lm')
# dev.off()
# 
# pdf(file=paste0(D,MAINNAME,"_relation_n_pie_6.pdf"))
# ggplot(df_6, aes(pie,n))+geom_point() + geom_smooth(method = 'lm')+labs(title="Phase 6")
# dev.off()
# 
# pdf(file=paste0(D,MAINNAME,"_relation_ln_tmine_ln_n_6.pdf"))
# ggplot(df_6, aes(ln_tmine,ln_n))+geom_point() + geom_smooth(method = 'lm')+labs(title="Phase 6")
# dev.off()
# 
# pdf(file=paste0(D,MAINNAME,"_relation_ln_t_ln_n_6.pdf"))
# ggplot(df_6, aes(ln_t,ln_n))+geom_point() + geom_smooth(method = 'lm')+labs(title="Phase 6")
# dev.off()
# 
# pdf(file=paste0(D,MAINNAME,"_relation_ln_t_ln_pie_6.pdf"))
# ggplot(df_6, aes(ln_pie,ln_n))+geom_point() + geom_smooth(method = 'lm')+labs(title="Phase 6")
# dev.off()



#check the type of relationship between independent variables 

pdf(file=paste0(D,MAINNAME,"_relation_t_pie_6.pdf"))
ggplot(df_6, aes(pie,t))+geom_point() + geom_smooth(method = 'lm')+labs(title="Phases 6")
dev.off()

pdf(file=paste0(D,MAINNAME,"_relation_t_e_6.pdf"))
ggplot(df_6, aes(e,t))+geom_point() + geom_smooth(method = 'lm')+labs(title="Phases 6")
dev.off()
