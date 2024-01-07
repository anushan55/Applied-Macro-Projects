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


###survey design specification ===================================================
df_design <- svydesign(ids = ~1,
                       data = df_svy,
                       weights = ~smpwt)




###Gini Calculation for all#####################################################
gini_coeff_weighted_e <- DescTools::Gini(df_svy$e, weights = df_svy$smpwt)
print(gini_coeff_weighted_e)

lorenz_e<- DescTools::Lc(df_svy$e, weights = df_svy$smpwt)


pdf(file=paste0(D,MAINNAME,"_overalledulorenz.pdf"))
plot(lorenz_e, 
     xlab = "Cumulative Share of Population",
     ylab = "Cumulative Share of Education",
     main = "Lorenz Curve for Education",
     col = "blue")
text(x = 0.2, y = 0.8,
     labels = paste("Gini coefficient:", round(gini_coeff_weighted_e, 2)),
     col = "red",
     cex = 0.8,
     pos = 4)
dev.off()
     


# lorenz by phase #############################################################
##Phase 6 ===========
df_svy_phase6<-df_svy[df_svy$phase_number == 6, ]
unique(df_svy_phase6$phase_number)

#inequality calculations
gini_coeff_weighted_e_phase6 <- DescTools::Gini(df_svy_phase6$e, weights = df_svy_phase6$smpwt)

lorenz_e_phase6<- DescTools::Lc(df_svy_phase6$e, weights = df_svy_phase6$smpwt)
pdf(file=paste0(D,MAINNAME,"_overalledulorenz_phase6.pdf"))
plot(lorenz_e_phase6, 
     xlab = "Cumulative Share of Population",
     ylab = "Cumulative Share of Education",
     main = "Lorenz Curve for Education:Phase 6",
     col = "blue")
text(x = 0.2, y = 0.8,
     labels = paste("Gini coefficient:", round(gini_coeff_weighted_e_phase6, 2)),
     col = "red",
     cex = 0.8,
     pos = 4)
dev.off()


## Phase 1 ===================
df_svy_phase1<-df_svy[df_svy$phase_number == 1, ]
unique(df_svy_phase1$phase_number)

#inequality calculations
gini_coeff_weighted_e_phase1 <- DescTools::Gini(df_svy_phase1$e, weights = df_svy_phase1$smpwt)

lorenz_e_phase1<- DescTools::Lc(df_svy_phase1$e, weights = df_svy_phase1$smpwt)
pdf(file=paste0(D,MAINNAME,"_overalledulorenz_phase1.pdf"))
plot(lorenz_e_phase1, 
     xlab = "Cumulative Share of Population",
     ylab = "Cumulative Share of Education",
     main = "Lorenz Curve for Education:Phase 1",
     col = "blue")
text(x = 0.2, y = 0.8,
     labels = paste("Gini coefficient:", round(gini_coeff_weighted_e_phase1, 2)),
     col = "red",
     cex = 0.8,
     pos = 4)
dev.off()


##Gini calculation for Indonesia ###############################################
## Phase 1 ==========================
df_svy_phase1<-df_svy[df_svy$phase_number == 1, ]
df_svy_phase1_indo<- df_svy_phase1[df_svy_phase1$country_code == "ID",]
unique(df_svy_phase1_indo$country_code)

#inequality calculations
gini_coeff_weighted_e_phase1_indo <- DescTools::Gini(df_svy_phase1_indo$e, weights = df_svy_phase1_indo$smpwt)

lorenz_e_phase1_indo<- DescTools::Lc(df_svy_phase1_indo$e, weights = df_svy_phase1_indo$smpwt)
pdf(file=paste0(D,MAINNAME,"_overalledulorenz_phase1_indo.pdf"))
plot(lorenz_e_phase1_indo, 
     xlab = "Cumulative Share of Population",
     ylab = "Cumulative Share of Education",
     main = "Lorenz Curve for Education in Indonesia:Phase 1",
     col = "blue")
text(x = 0.2, y = 0.8,
     labels = paste("Gini coefficient:", round(gini_coeff_weighted_e_phase1_indo, 2)),
     col = "red",
     cex = 0.8,
     pos = 4)
dev.off()

## Phase 6 ==========================
df_svy_phase6<-df_svy[df_svy$phase_number == 6, ]
df_svy_phase6_indo<- df_svy_phase6[df_svy_phase6$country_code == "ID",]
unique(df_svy_phase6_indo$country_code)

#inequality calculations
gini_coeff_weighted_e_phase6_indo <- DescTools::Gini(df_svy_phase6_indo$e, weights = df_svy_phase6_indo$smpwt)

lorenz_e_phase6_indo<- DescTools::Lc(df_svy_phase6_indo$e, weights = df_svy_phase6_indo$smpwt)
pdf(file=paste0(D,MAINNAME,"_overalledulorenz_phase6_indo.pdf"))
plot(lorenz_e_phase6_indo, 
     xlab = "Cumulative Share of Population",
     ylab = "Cumulative Share of Education",
     main = "Lorenz Curve for Education in Indonesia:Phase 6",
     col = "blue")
text(x = 0.2, y = 0.8,
     labels = paste("Gini coefficient:", round(gini_coeff_weighted_e_phase6_indo, 2)),
     col = "red",
     cex = 0.8,
     pos = 4)
dev.off()  

## Phase 7 ==========================
df_svy_phase7 <- df_svy[df_svy$phase_number == 7, ]
df_svy_phase7_indo <- df_svy_phase7[df_svy_phase7$country_code == "ID",]
unique(df_svy_phase7_indo$country_code)

#inequality calculations
gini_coeff_weighted_e_phase7_indo <- DescTools::Gini(df_svy_phase7_indo$e, weights = df_svy_phase7_indo$smpwt)

lorenz_e_phase7_indo <- DescTools::Lc(df_svy_phase7_indo$e, weights = df_svy_phase7_indo$smpwt)
pdf(file=paste0(D,MAINNAME,"_overalledulorenz_phase7_indo.pdf"))
plot(lorenz_e_phase7_indo, 
     xlab = "Cumulative Share of Population",
     ylab = "Cumulative Share of Education",
     main = "Lorenz Curve for Education in Indonesia:Phase 7",
     col = "blue")
text(x = 0.2, y = 0.8,
     labels = paste("Gini coefficient:", round(gini_coeff_weighted_e_phase7_indo, 2)),
     col = "red",
     cex = 0.8,
     pos = 4)
dev.off() 



##Gini Calculation for India ###########################
## Phase 2 (the earliest available) ==========================
df_svy_phase2<-df_svy[df_svy$phase_number == 2, ]
df_svy_phase2_india<- df_svy_phase2[df_svy_phase2$country_code == "IA",]
unique(df_svy_phase2_india$country_code)

#inequality calculations
gini_coeff_weighted_e_phase2_india <- DescTools::Gini(df_svy_phase2_india$e, weights = df_svy_phase2_india$smpwt)

lorenz_e_phase2_india<- DescTools::Lc(df_svy_phase2_india$e, weights = df_svy_phase2_india$smpwt)
pdf(file=paste0(D,MAINNAME,"_overalledulorenz_phase2_india.pdf"))
plot(lorenz_e_phase2_india, 
     xlab = "Cumulative Share of Population",
     ylab = "Cumulative Share of Education",
     main = "Lorenz Curve for Education in India:Phase 2",
     col = "blue")
text(x = 0.2, y = 0.8,
     labels = paste("Gini coefficient:", round(gini_coeff_weighted_e_phase2_india, 2)),
     col = "red",
     cex = 0.8,
     pos = 4)
dev.off()

## Phase 6 ==========================
df_svy_phase6<-df_svy[df_svy$phase_number == 6, ]
df_svy_phase6_india<- df_svy_phase6[df_svy_phase6$country_code == "IA",]
unique(df_svy_phase6_india$country_code)

#inequality calculations
gini_coeff_weighted_e_phase6_india <- DescTools::Gini(df_svy_phase6_india$e, weights = df_svy_phase6_india$smpwt)

lorenz_e_phase6_india<- DescTools::Lc(df_svy_phase6_india$e, weights = df_svy_phase6_india$smpwt)
pdf(file=paste0(D,MAINNAME,"_overalledulorenz_phase6_india.pdf"))
plot(lorenz_e_phase6_india, 
     xlab = "Cumulative Share of Population",
     ylab = "Cumulative Share of Education",
     main = "Lorenz Curve for Education in India:Phase 6",
     col = "blue")
text(x = 0.2, y = 0.8,
     labels = paste("Gini coefficient:", round(gini_coeff_weighted_e_phase6_india, 2)),
     col = "red",
     cex = 0.8,
     pos = 4)
dev.off()  










# #edu_gini one phase
# df_sum_phase6<- df_sum[df_sum$phase_number==6, ]
# 
# ggplot(df_sum_phase6, aes(edu_gini,n))+geom_point()+
#   geom_text(aes(label=country_code), check_overlap = TRUE, vjust = -0.5) +labs(title="Phase 6") + geom_smooth(method = 'lm', se=FALSE )
# reg_phase6<- lm(n~edu_gini, data = df_sum_phase6)
# summary(reg_phase6)
# 
# 

# 
# 
# #multiple phases for one country
# df_sum_id<- df_sum[df_sum$country_code=="ID", ]
# ggplot(df_sum_id, aes(x=phase_number, y=edu_gini))+
#   geom_line(color="red") + geom_point()+
#   labs(title="indianesia at different phases")
#   
#   #geom_line(aes(y=n), color="blue")
# 
# 
# 
# 
