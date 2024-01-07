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
df<-LOAD(dfinput=paste0("project_samplecreation_controls"),pattdir=A)
df_6<-LOAD(dfinput=paste0("project_samplecreation_controls_phase6"),pattdir=A)


#identify which phase has more observation
pdf(file=paste0(D,MAINNAME,"_dist_phases.pdf"))
ggplot(df, aes(x=phase_number))+
  geom_histogram()+
  scale_x_continuous(
    breaks = unique(df$phase_number),
    labels = unique(df$phase_number),
  )
dev.off()

table(df$phase_number)

colnames(df)

#all phases##########################################################################################################

#work 
summary(df$work)

#occupation of husband 
pdf(file=paste0(D,MAINNAME,"_dist_husb_occ.pdf"))
ggplot(df, aes(x = husb_occ)) +
  geom_histogram(binwidth = 1, fill = "skyblue", color = "black") +
  labs(title = "Distribution of husband occupation",
       x = "Type of occupation",
       y = "Count")
dev.off()
summary(df$husb_occ)

#urban 
summary(df$urban)
unique(df$urban)

#agemar
pdf(file=paste0(D,MAINNAME,"_dist_agemar.pdf"))
ggplot(df, aes(x = agemar)) +
  geom_histogram(binwidth = 1, fill = "skyblue", color = "black") +
  labs(title = "Distribution of age of marriage",
       x = "Age of marriage",
       y = "Count")
dev.off()
summary(df$agemar)

#gdp_pc
pdf(file=paste0(D,MAINNAME,"_dist_gdp_pc.pdf"))
ggplot(df, aes(x = gdp_pc)) +
  geom_histogram(binwidth = 1, fill = "skyblue", color = "black") +
  labs(title = "Distribution of GDP per capita",
       x = "GDP per Capita (USD Millions)",
       y = "Count")
dev.off()
summary(df$gdp_pc)

#pop
pdf(file=paste0(D,MAINNAME,"_dist_pop.pdf"))
ggplot(df, aes(x = pop)) +
  geom_histogram(binwidth = 1, fill = "skyblue", color = "black") +
  labs(title = "Distribution of Population",
       x = "Population (Millions)",
       y = "Count")
dev.off()
summary(df$pop)

#Check the type of relationship between dependent and independent variable 

pdf(file=paste0(D,MAINNAME,"_relation_n_work.pdf"))
ggplot(df, aes(work,n))+geom_point() + geom_smooth(method = 'lm')+labs(title="All phases")
dev.off()

pdf(file=paste0(D,MAINNAME,"_relation_n_husb_occ.pdf"))
ggplot(df, aes(husb_occ,n))+geom_point() +labs(title="All phases") + geom_smooth(method = 'lm')
dev.off()

df %>% 
  group_by (husb_occ) %>%
  summarise(average =mean(n))

pdf(file=paste0(D,MAINNAME,"_relation_n_urban.pdf"))
ggplot(df, aes(urban,n))+geom_point() + geom_smooth(method = 'lm')+labs(title="All phase")
dev.off()

pdf(file=paste0(D,MAINNAME,"_relation_n_agemar.pdf"))
ggplot(df, aes(agemar,n))+geom_point() + geom_smooth(method = 'lm')+labs(title="All phases")
dev.off()



###check relationship between main explanatory variable

pdf(file=paste0(D,MAINNAME,"_relation_e_work.pdf"))
ggplot(df, aes(work,e))+geom_point() + geom_smooth(method = 'lm')+labs(title="All phases")
dev.off()

pdf(file=paste0(D,MAINNAME,"_relation_e_husb_occ.pdf"))
ggplot(df, aes(husb_occ,e))+geom_point() +labs(title="All phases") + geom_smooth(method = 'lm')
dev.off()

df %>% 
  group_by (husb_occ) %>%
  summarise(average =mean(e))

pdf(file=paste0(D,MAINNAME,"_relation_e_urban.pdf"))
ggplot(df, aes(urban,e))+geom_point() + geom_smooth(method = 'lm')+labs(title="All phase")
dev.off()

pdf(file=paste0(D,MAINNAME,"_relation_e_agemar.pdf"))
ggplot(df, aes(agemar,e))+geom_point() + geom_smooth(method = 'lm')+labs(title="All phases")
dev.off()





# #phase 6 ##########################################################################################################
# 
# ##distribution of each variable 
# 
# #work 
# summary(df_6$work)
# 
# #occupation of husband 
# pdf(file=paste0(D,MAINNAME,"_dist_husb_occ_phase6.pdf"))
# ggplot(df_6, aes(x = husb_occ)) +
#   geom_histogram(binwidth = 1, fill = "skyblue", color = "black") +
#   labs(title = "Distribution of husband occupation",
#        x = "Type of occupation",
#        y = "Count")
# dev.off
# summary(df_6$husb_occ)
# 
# #urban 
# summary(df_6$urban)
# unique(df_6$urban)
# 
# #agemar
# pdf(file=paste0(D,MAINNAME,"_dist_education_phase6.pdf"))
# ggplot(df_6, aes(x = agemar)) +
#   geom_histogram(binwidth = 1, fill = "skyblue", color = "black") +
#   labs(title = "Distribution of age of marriage",
#        x = "Age of marriage",
#        y = "Count")
# dev.off
# summary(df_6$agemar)
# 
# 
# #Check the type of relationship between dependent and independent variable 
# # 
# pdf(file=paste0(D,MAINNAME,"_relation_n_work_6.pdf"))
#  ggplot(df_6, aes(work,n))+geom_point() + geom_smooth(method = 'lm')+labs(title="Phase 6")
#  dev.off()
# 
# pdf(file=paste0(D,MAINNAME,"_relation_n_husb_occ_6.pdf"))
# ggplot(df_6, aes(husb_occ,n))+geom_point() +labs(title="Phase 6") + geom_smooth(method = 'lm')
# dev.off()

# df_6 %>% 
#   group_by (husb_occ) %>%
#   summarise(average =mean(n)) 

# pdf(file=paste0(D,MAINNAME,"_relation_n_urban_6.pdf"))
# ggplot(df_6, aes(urban,n))+geom_point() + geom_smooth(method = 'lm')+labs(title="Phase 6")
# dev.off()
# 
# pdf(file=paste0(D,MAINNAME,"_relation_n_agemar_6.pdf"))
# ggplot(df_6, aes(agemar,n))+geom_point() + geom_smooth(method = 'lm')+labs(title="Phase 6")
# dev.off()


