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

#France predictions

df<-LOAD(dfinput=paste0(DFMERGE))


pred_future_developed_france_constantedu<-LOAD(dfinput=paste0("pred_future_developed_france_constantedu"))


pred_future_developed_france<-LOAD(dfinput=paste0("pred_future_developed_france"))

df_france<- subset(df,id=="59")


pdf(file=paste0(D,MAINNAME,"_modelprediction_france_constantedu.pdf"))
ggplot (data=df_france, aes(year))+
  geom_line(aes(y=y), color="black")+
  geom_line(aes(y=y_hat_main), color="red", data =pred_future_developed_france_constantedu )+
  geom_line(aes(y=y_hat_main), color="blue", data=pred_future_developed_france)
dev.off()


#Germany predictions

pred_future_developed_germany_constantedu<-LOAD(dfinput=paste0("pred_future_developed_germany_constantedu"))

pred_future_developed_germany<-LOAD(dfinput=paste0("pred_future_developed_germany"))

df_germany<- subset(df,id=="45")


pdf(file=paste0(D,MAINNAME,"_modelprediction_germany_constantedu.pdf"))
ggplot (data=df_germany, aes(year))+
  geom_line(aes(y=y), color="black")+
  geom_line(aes(y=y_hat_main), color="red", data =pred_future_developed_germany_constantedu )+
  geom_line(aes(y=y_hat_main), color="blue", data=pred_future_developed_germany)
dev.off()


#India predictions

pred_future_developing_india_constantedu<-LOAD(dfinput=paste0("pred_future_developing_india_constantedu"))
pred_future_developing_india<-LOAD(dfinput=paste0("pred_future_developing_india"))

df_india<- subset(df,id=="79")


pdf(file=paste0(D,MAINNAME,"_modelprediction_india_constantedu.pdf"))
ggplot (data=df_india, aes(year))+
  geom_line(aes(y=y), color="black")+
  geom_line(aes(y=y_hat_main), color="red", data =pred_future_developing_india_constantedu )+
  geom_line(aes(y=y_hat_main), color="blue", data=pred_future_developing_india)
dev.off()


#Sri Lanka predictions

pred_future_developing_sl_constantedu<-LOAD(dfinput=paste0("pred_future_developing_sl_constantedu"))
pred_future_developing_sl<-LOAD(dfinput=paste0("pred_future_developing_sl"))

df_sl<- subset(df,id=="103")


pdf(file=paste0(D,MAINNAME,"_modelprediction_sl_constantedu.pdf"))
ggplot (data=df_sl, aes(year), title("Sri Lanka"))+
  geom_line(aes(y=y), color="black")+
  geom_line(aes(y=y_hat_main), color="red", data =pred_future_developing_sl_constantedu )+
  geom_line(aes(y=y_hat_main), color="blue", data=pred_future_developing_sl)
dev.off()


