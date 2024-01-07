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
df_all<-LOAD(dfinput=paste0(DFMAIN, "_all"),pattdir=A)
load("project_analysis_regression_all")
df_all$y_hat<-predict(reg4)
reg_all<-reg4

df_developing<-LOAD(dfinput=paste0(DFMAIN, "_developing"),pattdir=A)
load("project_analysis_regression_developing")
df_developing$y_hat<-predict(reg4)
reg_developing<-reg4

df_developed<-LOAD(dfinput=paste0(DFMAIN, "_developed"),pattdir=A)
reg_developed<-load("project_analysis_regression_developed")
df_developed$y_hat<-predict(reg4)
reg_developed<-reg4




# Coeeficient plots
pdf(file=paste0(D,MAINNAME,"_coefficientplots.pdf"))
multiplot(reg_all,reg_developed, reg_developing, coefficients=c("S_less20","S_20_24", "S_25_29", "S_30_34","S_35_39", "S_40_44", "S_45_49","S_55_59", "S_60_64", "S_65plus"),linetype=0,plot.shapes=FALSE, plot.linetypes=FALSE,title="Demographic coefficients")
dev.off()


reg_all<-data.frame(matrix(unlist(head(reg_all$coefficients, n=11L))))
reg_all<-tail(reg_all, n=10L)
names<- c(20,25,30,35,40,45,50,60,65,70)
reg_all<- data.frame(names,reg_all)
colnames(reg_all)<-c('coefficients', 'value')
reg_all<- rbind(reg_all, data.frame("coefficients"=55, "value"=0 ))

reg_developing<-data.frame(matrix(unlist(head(reg_developing$coefficients, n=11L))))
reg_developing<-tail(reg_developing, n=10L)
reg_developing<- data.frame(names,reg_developing)
colnames(reg_developing)<-c('coefficients', 'value')
reg_developing<- rbind(reg_developing, data.frame("coefficients"=55, "value"=0 ))

reg_developed<-data.frame(matrix(unlist(head(reg_developed$coefficients, n=11L))))
reg_developed<-tail(reg_developed, n=10L)
reg_developed<- data.frame(names,reg_developed)
colnames(reg_developed)<-c('coefficients', 'value')
reg_developed<- rbind(reg_developed, data.frame("coefficients"=55, "value"=0 ))

pdf(file=paste0(D,MAINNAME,"_coefficientplots_2.pdf"))
ggplot(reg_all, aes(x=coefficients, y=value))+geom_point(aes(y=value), color="black")+geom_line()+
  geom_point(aes(y=value), color="blue", data=reg_developing)+geom_line(aes(y=value), color="blue", data=reg_developing)+
  geom_point(aes(y=value), color="green", data=reg_developed)+geom_line(aes(y=value), color="green", data=reg_developed)
dev.off()

################################################################################
#France model fit on past data 
df_all_france<- subset(df_all,id=="59")
df_developed_france<- subset(df_developed,id=="59")

pdf(file=paste0(D,MAINNAME,"_modelfit_france.pdf"))
ggplot (data=df_all_france, aes(year))+
  geom_line(aes(y=y), color="black")+
  geom_line(aes(y=y_hat), color="red")+
  geom_line(aes(y=y_hat), color="green", data=df_developed_france)
dev.off()

#Germany model fit on past data
df_all_germany<- subset(df_all, id=="45")
df_developed_germany<- subset(df_developed,id=="45")

pdf(file=paste0(D,MAINNAME,"_modelfit_germany.pdf"))
ggplot (data=df_all_germany, aes(year))+
  geom_line(aes(y=y), color="black")+
  geom_line(aes(y=y_hat), color="red")+
  geom_line(aes(y=y_hat), color="green", data=df_developed_germany)
dev.off()

#India model fit on past data 
df_all_india<- subset(df_all, id=="79")
df_developing_india<- subset(df_developing,id=="79")

pdf(file=paste0(D,MAINNAME,"_modelfit_india.pdf"))
ggplot (data=df_all_india, aes(year))+
  geom_line(aes(y=y), color="black")+
  geom_line(aes(y=y_hat), color="red")+
  geom_line(aes(y=y_hat), color="green", data=df_developing_india)
dev.off()


#Sri Lanka model fit on past data 

df_all_sl<- subset(df_all, id=="103")
df_developing_sl<- subset(df_developing,id=="103")

pdf(file=paste0(D,MAINNAME,"_modelfit_sl.pdf"))
ggplot (data=df_all_sl, aes(year))+
  geom_line(aes(y=y), color="black")+
  geom_line(aes(y=y_hat), color="red")+
  geom_line(aes(y=y_hat), color="green", data=df_developing_sl)
dev.off()


###############################################################################






