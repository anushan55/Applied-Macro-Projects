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

#load all three databases
df_all<-LOAD(dfinput=paste0(DFMAIN, "_all"),pattdir=A)
df_developing<-LOAD(dfinput=paste0(DFMAIN, "_developing"),pattdir=A)
df_developed<-LOAD(dfinput=paste0(DFMAIN, "_developed"),pattdir=A)

#identify which year has more observation
ggplot(df_all, aes(x=t))+geom_histogram()


#Check the type of relationship between dependent and independent variable at one time period
df_all<-filter(df_all,t==13)
df_developing<-filter(df_developing,t==13)
df_developed<-filter(df_developed,t==13)

unique(df_all$t)

pdf(file=paste0(D,MAINNAME,"_relationship_y_ymin_all.pdf"))
ggplot(df_all, aes(ymin1,y))+geom_point()+geom_smooth()
dev.off()

pdf(file=paste0(D,MAINNAME,"_relationship_y_k_all.pdf"))
ggplot(df_all,aes(k,y))+geom_point()+geom_smooth()
dev.off()

pdf(file=paste0(D,MAINNAME,"_relationship_y_hs.pdf"))
ggplot(df_all, aes(x=hs,y=y))+geom_point()+geom_smooth(method=lm)+labs(title="All countries")
ggplot(df_all, aes(x=hs,y=y))+geom_point()+geom_smooth()+labs(title="All countries")
ggplot(df_developed, aes(x=hs,y=y))+geom_point()+geom_smooth(method=lm) +labs(title="Developed Countries")
ggplot(df_developing, aes(x=hs,y=y))+geom_point()+geom_smooth(method=lm)+labs(title="Developing Countries")
dev.off()

#Projected values of hs overtime for the 4 countries 

df_merge<-LOAD(dfinput=paste0(DFMERGE))

df_merge<- subset(df_merge, df_merge$id=="59"| df_merge$id=="45"| df_merge$id=="79" | df_merge$id=="103")

df_merge$country<- if_else(df_merge$id == "59",df_merge$country<-"france", 
                           if_else(df_merge$id == "45",df_merge$country<-"germany", 
                                   if_else(df_merge$id == "79",df_merge$country<-"india", df_merge$country<-"sri lanka") ) )

pdf(file=paste0(D,MAINNAME,"_hs_predicted.pdf"))
ggplot (data=df_merge, aes(x=year, y=hs, group=country, color=country))+
  geom_line()
dev.off()
