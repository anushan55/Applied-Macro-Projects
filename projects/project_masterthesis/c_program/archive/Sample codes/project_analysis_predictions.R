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
# Main Part  ####

#load the relevant datasets and regression
pred<-LOAD(dfinput=paste0(DFMERGE))

pred_future<-subset(pred, t>13)

unique(pred_future$t)

#France general 
pred_future_france<-subset(pred_future,id=="59")

pred_future_france[,"k"] <- c(13.04487923,
                              13.22436846,
                              13.40385769,
                              13.58334692,
                              13.76283615,
                              13.94232538,
                              14.12181462,
                              14.30130385)

#France all countries fit
pred_future_all_france<-pred_future_france

pred_future_all_france$y_hat <- 4.280841-3.064794*(pred_future_all_france$S_less20)-1.835247*(pred_future_all_france$S_20_24)-3.123951*(pred_future_all_france$S_25_29)-2.737108*(pred_future_all_france$S_30_34)-3.708771*(pred_future_all_france$S_35_39)-1.350499*(pred_future_all_france$S_40_44)-3.074073*(pred_future_all_france$S_45_49)-4.367835*(pred_future_all_france$S_55_59)-5.500043*(pred_future_all_france$S_60_64)-3.243087*(pred_future_all_france$S_65plus)+0.334054*(pred_future_all_france$k)+1.08359*(pred_future_all_france$hs)+0.484375*(pred_future_all_france$ymin1)

pred_future_all_france <- pred_future_all_france %>%                            # Add lagged column
  dplyr::mutate(lagy_hat = dplyr::lag(y_hat, n = 1, default = NA)) %>% 
  as.data.frame()

pred_future_all_france$y_hat_2<- 4.280841-3.064794*(pred_future_all_france$S_less20)-1.835247*(pred_future_all_france$S_20_24)-3.123951*(pred_future_all_france$S_25_29)-2.737108*(pred_future_all_france$S_30_34)-3.708771*(pred_future_all_france$S_35_39)-1.350499*(pred_future_all_france$S_40_44)-3.074073*(pred_future_all_france$S_45_49)-4.367835*(pred_future_all_france$S_55_59)-5.500043*(pred_future_all_france$S_60_64)-3.243087*(pred_future_all_france$S_65plus)+0.334054*(pred_future_all_france$k)+1.08359*(pred_future_all_france$hs)+0.484375*(pred_future_all_france$lagy_hat)

pred_future_all_france <- pred_future_all_france %>%                            # Add lagged column
  dplyr::mutate(lagy_hat_2 = dplyr::lag(y_hat_2, n = 1, default = NA)) %>% 
  as.data.frame()

pred_future_all_france$y_hat_3<- 4.280841-3.064794*(pred_future_all_france$S_less20)-1.835247*(pred_future_all_france$S_20_24)-3.123951*(pred_future_all_france$S_25_29)-2.737108*(pred_future_all_france$S_30_34)-3.708771*(pred_future_all_france$S_35_39)-1.350499*(pred_future_all_france$S_40_44)-3.074073*(pred_future_all_france$S_45_49)-4.367835*(pred_future_all_france$S_55_59)-5.500043*(pred_future_all_france$S_60_64)-3.243087*(pred_future_all_france$S_65plus)+0.334054*(pred_future_all_france$k)+1.08359*(pred_future_all_france$hs)+0.484375*(pred_future_all_france$lagy_hat_2)

pred_future_all_france <- pred_future_all_france %>%                            # Add lagged column
  dplyr::mutate(lagy_hat_3 = dplyr::lag(y_hat_3, n = 1, default = NA)) %>% 
  as.data.frame()

pred_future_all_france$y_hat_4<- 4.280841-3.064794*(pred_future_all_france$S_less20)-1.835247*(pred_future_all_france$S_20_24)-3.123951*(pred_future_all_france$S_25_29)-2.737108*(pred_future_all_france$S_30_34)-3.708771*(pred_future_all_france$S_35_39)-1.350499*(pred_future_all_france$S_40_44)-3.074073*(pred_future_all_france$S_45_49)-4.367835*(pred_future_all_france$S_55_59)-5.500043*(pred_future_all_france$S_60_64)-3.243087*(pred_future_all_france$S_65plus)+0.334054*(pred_future_all_france$k)+1.08359*(pred_future_all_france$hs)+0.484375*(pred_future_all_france$lagy_hat_3)

pred_future_all_france <- pred_future_all_france %>%                            # Add lagged column
  dplyr::mutate(lagy_hat_4 = dplyr::lag(y_hat_4, n = 1, default = NA)) %>% 
  as.data.frame()

pred_future_all_france$y_hat_5<- 4.280841-3.064794*(pred_future_all_france$S_less20)-1.835247*(pred_future_all_france$S_20_24)-3.123951*(pred_future_all_france$S_25_29)-2.737108*(pred_future_all_france$S_30_34)-3.708771*(pred_future_all_france$S_35_39)-1.350499*(pred_future_all_france$S_40_44)-3.074073*(pred_future_all_france$S_45_49)-4.367835*(pred_future_all_france$S_55_59)-5.500043*(pred_future_all_france$S_60_64)-3.243087*(pred_future_all_france$S_65plus)+0.334054*(pred_future_all_france$k)+1.08359*(pred_future_all_france$hs)+0.484375*(pred_future_all_france$lagy_hat_4)

pred_future_all_france <- pred_future_all_france %>%                            # Add lagged column
  dplyr::mutate(lagy_hat_5 = dplyr::lag(y_hat_5, n = 1, default = NA)) %>% 
  as.data.frame()

pred_future_all_france$y_hat_6<- 4.280841-3.064794*(pred_future_all_france$S_less20)-1.835247*(pred_future_all_france$S_20_24)-3.123951*(pred_future_all_france$S_25_29)-2.737108*(pred_future_all_france$S_30_34)-3.708771*(pred_future_all_france$S_35_39)-1.350499*(pred_future_all_france$S_40_44)-3.074073*(pred_future_all_france$S_45_49)-4.367835*(pred_future_all_france$S_55_59)-5.500043*(pred_future_all_france$S_60_64)-3.243087*(pred_future_all_france$S_65plus)+0.334054*(pred_future_all_france$k)+1.08359*(pred_future_all_france$hs)+0.484375*(pred_future_all_france$lagy_hat_5)

pred_future_all_france <- pred_future_all_france %>%                            # Add lagged column
  dplyr::mutate(lagy_hat_6 = dplyr::lag(y_hat_6, n = 1, default = NA)) %>% 
  as.data.frame()

pred_future_all_france$y_hat_7<- 4.280841-3.064794*(pred_future_all_france$S_less20)-1.835247*(pred_future_all_france$S_20_24)-3.123951*(pred_future_all_france$S_25_29)-2.737108*(pred_future_all_france$S_30_34)-3.708771*(pred_future_all_france$S_35_39)-1.350499*(pred_future_all_france$S_40_44)-3.074073*(pred_future_all_france$S_45_49)-4.367835*(pred_future_all_france$S_55_59)-5.500043*(pred_future_all_france$S_60_64)-3.243087*(pred_future_all_france$S_65plus)+0.334054*(pred_future_all_france$k)+1.08359*(pred_future_all_france$hs)+0.484375*(pred_future_all_france$lagy_hat_6)

pred_future_all_france <- pred_future_all_france %>%                            # Add lagged column
  dplyr::mutate(lagy_hat_7 = dplyr::lag(y_hat_7, n = 1, default = NA)) %>% 
  as.data.frame()

pred_future_all_france$y_hat_8<- 4.280841-3.064794*(pred_future_all_france$S_less20)-1.835247*(pred_future_all_france$S_20_24)-3.123951*(pred_future_all_france$S_25_29)-2.737108*(pred_future_all_france$S_30_34)-3.708771*(pred_future_all_france$S_35_39)-1.350499*(pred_future_all_france$S_40_44)-3.074073*(pred_future_all_france$S_45_49)-4.367835*(pred_future_all_france$S_55_59)-5.500043*(pred_future_all_france$S_60_64)-3.243087*(pred_future_all_france$S_65plus)+0.334054*(pred_future_all_france$k)+1.08359*(pred_future_all_france$hs)+0.484375*(pred_future_all_france$lagy_hat_7)


pred_future_all_france$y_hat = replace( pred_future_all_france$y_hat, is.na(pred_future_all_france$y_hat), 0 )
pred_future_all_france$y_hat_2 = replace( pred_future_all_france$y_hat_2, is.na(pred_future_all_france$y_hat_2), 0 )
pred_future_all_france$y_hat_3 = replace( pred_future_all_france$y_hat_3, is.na(pred_future_all_france$y_hat_3), 0 )
pred_future_all_france$y_hat_4 = replace( pred_future_all_france$y_hat_4, is.na(pred_future_all_france$y_hat_4), 0 )
pred_future_all_france$y_hat_5 = replace( pred_future_all_france$y_hat_5, is.na(pred_future_all_france$y_hat_5), 0 )
pred_future_all_france$y_hat_6 = replace( pred_future_all_france$y_hat_6, is.na(pred_future_all_france$y_hat_6), 0 )
pred_future_all_france$y_hat_7 = replace( pred_future_all_france$y_hat_7, is.na(pred_future_all_france$y_hat_7), 0 )
pred_future_all_france$y_hat_8 = replace( pred_future_all_france$y_hat_8, is.na(pred_future_all_france$y_hat_8), 0 )

pred_future_all_france$y_hat_main = pred_future_all_france$y_hat+ pred_future_all_france$y_hat_2+ pred_future_all_france$y_hat_3+ pred_future_all_france$y_hat_4+ pred_future_all_france$y_hat_5+ pred_future_all_france$y_hat_6+ pred_future_all_france$y_hat_7+ pred_future_all_france$y_hat_8


SAVE(dfx=pred_future_all_france, namex ="pred_future_all_france")

################################################################################################################+
# FRANCE developed fit  ####

pred_future_developed_france<-pred_future_france

pred_future_developed_france$y_hat <- 1.5805946-0.2073961*(pred_future_developed_france$S_less20)+0.8007467*(pred_future_developed_france$S_20_24)-1.396259*(pred_future_developed_france$S_25_29)+1.0733377*(pred_future_developed_france$S_30_34)-0.0560155*(pred_future_developed_france$S_35_39)+0.3584896*(pred_future_developed_france$S_40_44)-1.138184*(pred_future_developed_france$S_45_49)-1.2991382*(pred_future_developed_france$S_55_59)-0.6771723*(pred_future_developed_france$S_60_64)-3.9143999*(pred_future_developed_france$S_65plus)+0.2960277*(pred_future_developed_france$k)+0.3101232*(pred_future_developed_france$hs)+0.5812736*(pred_future_developed_france$ymin1)

pred_future_developed_france <- pred_future_developed_france %>%                            # Add lagged column
  dplyr::mutate(lagy_hat = dplyr::lag(y_hat, n = 1, default = NA)) %>% 
  as.data.frame()

pred_future_developed_france$y_hat_2 <- 1.5805946-0.2073961*(pred_future_developed_france$S_less20)+0.8007467*(pred_future_developed_france$S_20_24)-1.396259*(pred_future_developed_france$S_25_29)+1.0733377*(pred_future_developed_france$S_30_34)-0.0560155*(pred_future_developed_france$S_35_39)+0.3584896*(pred_future_developed_france$S_40_44)-1.138184*(pred_future_developed_france$S_45_49)-1.2991382*(pred_future_developed_france$S_55_59)-0.6771723*(pred_future_developed_france$S_60_64)-3.9143999*(pred_future_developed_france$S_65plus)+0.2960277*(pred_future_developed_france$k)+0.3101232*(pred_future_developed_france$hs)+0.5812736*(lag(pred_future_developed_france$lagy_hat))

pred_future_developed_france <- pred_future_developed_france %>%                            # Add lagged column
  dplyr::mutate(lagy_hat_2 = dplyr::lag(y_hat_2, n = 1, default = NA)) %>% 
  as.data.frame()

pred_future_developed_france$y_hat_3 <- 1.5805946-0.2073961*(pred_future_developed_france$S_less20)+0.8007467*(pred_future_developed_france$S_20_24)-1.396259*(pred_future_developed_france$S_25_29)+1.0733377*(pred_future_developed_france$S_30_34)-0.0560155*(pred_future_developed_france$S_35_39)+0.3584896*(pred_future_developed_france$S_40_44)-1.138184*(pred_future_developed_france$S_45_49)-1.2991382*(pred_future_developed_france$S_55_59)-0.6771723*(pred_future_developed_france$S_60_64)-3.9143999*(pred_future_developed_france$S_65plus)+0.2960277*(pred_future_developed_france$k)+0.3101232*(pred_future_developed_france$hs)+0.5812736*(lag(pred_future_developed_france$lagy_hat_2))

pred_future_developed_france <- pred_future_developed_france %>%                            # Add lagged column
  dplyr::mutate(lagy_hat_3 = dplyr::lag(y_hat_3, n = 1, default = NA)) %>% 
  as.data.frame()

pred_future_developed_france$y_hat_4 <- 1.5805946-0.2073961*(pred_future_developed_france$S_less20)+0.8007467*(pred_future_developed_france$S_20_24)-1.396259*(pred_future_developed_france$S_25_29)+1.0733377*(pred_future_developed_france$S_30_34)-0.0560155*(pred_future_developed_france$S_35_39)+0.3584896*(pred_future_developed_france$S_40_44)-1.138184*(pred_future_developed_france$S_45_49)-1.2991382*(pred_future_developed_france$S_55_59)-0.6771723*(pred_future_developed_france$S_60_64)-3.9143999*(pred_future_developed_france$S_65plus)+0.2960277*(pred_future_developed_france$k)+0.3101232*(pred_future_developed_france$hs)+0.5812736*(lag(pred_future_developed_france$lagy_hat_3))

pred_future_developed_france <- pred_future_developed_france %>%                            # Add lagged column
  dplyr::mutate(lagy_hat_4 = dplyr::lag(y_hat_4, n = 1, default = NA)) %>% 
  as.data.frame()

pred_future_developed_france$y_hat_5 <- 1.5805946-0.2073961*(pred_future_developed_france$S_less20)+0.8007467*(pred_future_developed_france$S_20_24)-1.396259*(pred_future_developed_france$S_25_29)+1.0733377*(pred_future_developed_france$S_30_34)-0.0560155*(pred_future_developed_france$S_35_39)+0.3584896*(pred_future_developed_france$S_40_44)-1.138184*(pred_future_developed_france$S_45_49)-1.2991382*(pred_future_developed_france$S_55_59)-0.6771723*(pred_future_developed_france$S_60_64)-3.9143999*(pred_future_developed_france$S_65plus)+0.2960277*(pred_future_developed_france$k)+0.3101232*(pred_future_developed_france$hs)+0.5812736*(lag(pred_future_developed_france$lagy_hat_4))

pred_future_developed_france <- pred_future_developed_france %>%                            # Add lagged column
  dplyr::mutate(lagy_hat_5 = dplyr::lag(y_hat_5, n = 1, default = NA)) %>% 
  as.data.frame()

pred_future_developed_france$y_hat_6<- 1.5805946-0.2073961*(pred_future_developed_france$S_less20)+0.8007467*(pred_future_developed_france$S_20_24)-1.396259*(pred_future_developed_france$S_25_29)+1.0733377*(pred_future_developed_france$S_30_34)-0.0560155*(pred_future_developed_france$S_35_39)+0.3584896*(pred_future_developed_france$S_40_44)-1.138184*(pred_future_developed_france$S_45_49)-1.2991382*(pred_future_developed_france$S_55_59)-0.6771723*(pred_future_developed_france$S_60_64)-3.9143999*(pred_future_developed_france$S_65plus)+0.2960277*(pred_future_developed_france$k)+0.3101232*(pred_future_developed_france$hs)+0.5812736*(lag(pred_future_developed_france$lagy_hat_5))

pred_future_developed_france <- pred_future_developed_france %>%                            # Add lagged column
  dplyr::mutate(lagy_hat_6 = dplyr::lag(y_hat_6, n = 1, default = NA)) %>% 
  as.data.frame()

pred_future_developed_france$y_hat_7<- 1.5805946-0.2073961*(pred_future_developed_france$S_less20)+0.8007467*(pred_future_developed_france$S_20_24)-1.396259*(pred_future_developed_france$S_25_29)+1.0733377*(pred_future_developed_france$S_30_34)-0.0560155*(pred_future_developed_france$S_35_39)+0.3584896*(pred_future_developed_france$S_40_44)-1.138184*(pred_future_developed_france$S_45_49)-1.2991382*(pred_future_developed_france$S_55_59)-0.6771723*(pred_future_developed_france$S_60_64)-3.9143999*(pred_future_developed_france$S_65plus)+0.2960277*(pred_future_developed_france$k)+0.3101232*(pred_future_developed_france$hs)+0.5812736*(lag(pred_future_developed_france$lagy_hat_6))

pred_future_developed_france <- pred_future_developed_france %>%                            # Add lagged column
  dplyr::mutate(lagy_hat_7 = dplyr::lag(y_hat_7, n = 1, default = NA)) %>% 
  as.data.frame()
pred_future_developed_france$y_hat_8<- 1.5805946-0.2073961*(pred_future_developed_france$S_less20)+0.8007467*(pred_future_developed_france$S_20_24)-1.396259*(pred_future_developed_france$S_25_29)+1.0733377*(pred_future_developed_france$S_30_34)-0.0560155*(pred_future_developed_france$S_35_39)+0.3584896*(pred_future_developed_france$S_40_44)-1.138184*(pred_future_developed_france$S_45_49)-1.2991382*(pred_future_developed_france$S_55_59)-0.6771723*(pred_future_developed_france$S_60_64)-3.9143999*(pred_future_developed_france$S_65plus)+0.2960277*(pred_future_developed_france$k)+0.3101232*(pred_future_developed_france$hs)+0.5812736*(lag(pred_future_developed_france$lagy_hat_7))


pred_future_developed_france$y_hat = replace( pred_future_developed_france$y_hat, is.na(pred_future_developed_france$y_hat), 0 )
pred_future_developed_france$y_hat_2 = replace( pred_future_developed_france$y_hat_2, is.na(pred_future_developed_france$y_hat_2), 0 )
pred_future_developed_france$y_hat_3 = replace( pred_future_developed_france$y_hat_3, is.na(pred_future_developed_france$y_hat_3), 0 )
pred_future_developed_france$y_hat_4 = replace( pred_future_developed_france$y_hat_4, is.na(pred_future_developed_france$y_hat_4), 0 )
pred_future_developed_france$y_hat_5 = replace( pred_future_developed_france$y_hat_5, is.na(pred_future_developed_france$y_hat_5), 0 )
pred_future_developed_france$y_hat_6 = replace( pred_future_developed_france$y_hat_6, is.na(pred_future_developed_france$y_hat_6), 0 )
pred_future_developed_france$y_hat_7 = replace( pred_future_developed_france$y_hat_7, is.na(pred_future_developed_france$y_hat_7), 0 )
pred_future_developed_france$y_hat_8 = replace( pred_future_developed_france$y_hat_8, is.na(pred_future_developed_france$y_hat_8), 0 )

pred_future_developed_france$y_hat_main = pred_future_developed_france$y_hat+ pred_future_developed_france$y_hat_2+ pred_future_developed_france$y_hat_3+ pred_future_developed_france$y_hat_4+ pred_future_developed_france$y_hat_5+ pred_future_developed_france$y_hat_6+ pred_future_developed_france$y_hat_7+ pred_future_developed_france$y_hat_8


SAVE(dfx=pred_future_developed_france, namex ="pred_future_developed_france")


################################################################################


#Germany general 
pred_future_germany<-subset(pred_future,id=="45")

pred_future_germany[,"k"] <- c(12.83157385,
                               13.00614769,
                               13.18072154,
                               13.35529538,
                               13.52986923,
                               13.70444308,
                               13.87901692,
                               14.05359077)

#germany all countries fit
pred_future_all_germany<-pred_future_germany

pred_future_all_germany$y_hat <- 4.280841-3.064794*(pred_future_all_germany$S_less20)-1.835247*(pred_future_all_germany$S_20_24)-3.123951*(pred_future_all_germany$S_25_29)-2.737108*(pred_future_all_germany$S_30_34)-3.708771*(pred_future_all_germany$S_35_39)-1.350499*(pred_future_all_germany$S_40_44)-3.074073*(pred_future_all_germany$S_45_49)-4.367835*(pred_future_all_germany$S_55_59)-5.500043*(pred_future_all_germany$S_60_64)-3.243087*(pred_future_all_germany$S_65plus)+0.334054*(pred_future_all_germany$k)+1.08359*(pred_future_all_germany$hs)+0.484375*(pred_future_all_germany$ymin1)

pred_future_all_germany <- pred_future_all_germany %>%                            # Add lagged column
  dplyr::mutate(lagy_hat = dplyr::lag(y_hat, n = 1, default = NA)) %>% 
  as.data.frame()

pred_future_all_germany$y_hat_2<- 4.280841-3.064794*(pred_future_all_germany$S_less20)-1.835247*(pred_future_all_germany$S_20_24)-3.123951*(pred_future_all_germany$S_25_29)-2.737108*(pred_future_all_germany$S_30_34)-3.708771*(pred_future_all_germany$S_35_39)-1.350499*(pred_future_all_germany$S_40_44)-3.074073*(pred_future_all_germany$S_45_49)-4.367835*(pred_future_all_germany$S_55_59)-5.500043*(pred_future_all_germany$S_60_64)-3.243087*(pred_future_all_germany$S_65plus)+0.334054*(pred_future_all_germany$k)+1.08359*(pred_future_all_germany$hs)+0.484375*(pred_future_all_germany$lagy_hat)

pred_future_all_germany <- pred_future_all_germany %>%                            # Add lagged column
  dplyr::mutate(lagy_hat_2 = dplyr::lag(y_hat_2, n = 1, default = NA)) %>% 
  as.data.frame()

pred_future_all_germany$y_hat_3<- 4.280841-3.064794*(pred_future_all_germany$S_less20)-1.835247*(pred_future_all_germany$S_20_24)-3.123951*(pred_future_all_germany$S_25_29)-2.737108*(pred_future_all_germany$S_30_34)-3.708771*(pred_future_all_germany$S_35_39)-1.350499*(pred_future_all_germany$S_40_44)-3.074073*(pred_future_all_germany$S_45_49)-4.367835*(pred_future_all_germany$S_55_59)-5.500043*(pred_future_all_germany$S_60_64)-3.243087*(pred_future_all_germany$S_65plus)+0.334054*(pred_future_all_germany$k)+1.08359*(pred_future_all_germany$hs)+0.484375*(pred_future_all_germany$lagy_hat_2)

pred_future_all_germany <- pred_future_all_germany %>%                            # Add lagged column
  dplyr::mutate(lagy_hat_3 = dplyr::lag(y_hat_3, n = 1, default = NA)) %>% 
  as.data.frame()

pred_future_all_germany$y_hat_4<- 4.280841-3.064794*(pred_future_all_germany$S_less20)-1.835247*(pred_future_all_germany$S_20_24)-3.123951*(pred_future_all_germany$S_25_29)-2.737108*(pred_future_all_germany$S_30_34)-3.708771*(pred_future_all_germany$S_35_39)-1.350499*(pred_future_all_germany$S_40_44)-3.074073*(pred_future_all_germany$S_45_49)-4.367835*(pred_future_all_germany$S_55_59)-5.500043*(pred_future_all_germany$S_60_64)-3.243087*(pred_future_all_germany$S_65plus)+0.334054*(pred_future_all_germany$k)+1.08359*(pred_future_all_germany$hs)+0.484375*(pred_future_all_germany$lagy_hat_3)

pred_future_all_germany <- pred_future_all_germany %>%                            # Add lagged column
  dplyr::mutate(lagy_hat_4 = dplyr::lag(y_hat_4, n = 1, default = NA)) %>% 
  as.data.frame()

pred_future_all_germany$y_hat_5<- 4.280841-3.064794*(pred_future_all_germany$S_less20)-1.835247*(pred_future_all_germany$S_20_24)-3.123951*(pred_future_all_germany$S_25_29)-2.737108*(pred_future_all_germany$S_30_34)-3.708771*(pred_future_all_germany$S_35_39)-1.350499*(pred_future_all_germany$S_40_44)-3.074073*(pred_future_all_germany$S_45_49)-4.367835*(pred_future_all_germany$S_55_59)-5.500043*(pred_future_all_germany$S_60_64)-3.243087*(pred_future_all_germany$S_65plus)+0.334054*(pred_future_all_germany$k)+1.08359*(pred_future_all_germany$hs)+0.484375*(pred_future_all_germany$lagy_hat_4)

pred_future_all_germany <- pred_future_all_germany %>%                            # Add lagged column
  dplyr::mutate(lagy_hat_5 = dplyr::lag(y_hat_5, n = 1, default = NA)) %>% 
  as.data.frame()

pred_future_all_germany$y_hat_6<- 4.280841-3.064794*(pred_future_all_germany$S_less20)-1.835247*(pred_future_all_germany$S_20_24)-3.123951*(pred_future_all_germany$S_25_29)-2.737108*(pred_future_all_germany$S_30_34)-3.708771*(pred_future_all_germany$S_35_39)-1.350499*(pred_future_all_germany$S_40_44)-3.074073*(pred_future_all_germany$S_45_49)-4.367835*(pred_future_all_germany$S_55_59)-5.500043*(pred_future_all_germany$S_60_64)-3.243087*(pred_future_all_germany$S_65plus)+0.334054*(pred_future_all_germany$k)+1.08359*(pred_future_all_germany$hs)+0.484375*(pred_future_all_germany$lagy_hat_5)

pred_future_all_germany <- pred_future_all_germany %>%                            # Add lagged column
  dplyr::mutate(lagy_hat_6 = dplyr::lag(y_hat_6, n = 1, default = NA)) %>% 
  as.data.frame()

pred_future_all_germany$y_hat_7<- 4.280841-3.064794*(pred_future_all_germany$S_less20)-1.835247*(pred_future_all_germany$S_20_24)-3.123951*(pred_future_all_germany$S_25_29)-2.737108*(pred_future_all_germany$S_30_34)-3.708771*(pred_future_all_germany$S_35_39)-1.350499*(pred_future_all_germany$S_40_44)-3.074073*(pred_future_all_germany$S_45_49)-4.367835*(pred_future_all_germany$S_55_59)-5.500043*(pred_future_all_germany$S_60_64)-3.243087*(pred_future_all_germany$S_65plus)+0.334054*(pred_future_all_germany$k)+1.08359*(pred_future_all_germany$hs)+0.484375*(pred_future_all_germany$lagy_hat_6)

pred_future_all_germany <- pred_future_all_germany %>%                            # Add lagged column
  dplyr::mutate(lagy_hat_7 = dplyr::lag(y_hat_7, n = 1, default = NA)) %>% 
  as.data.frame()

pred_future_all_germany$y_hat_8<- 4.280841-3.064794*(pred_future_all_germany$S_less20)-1.835247*(pred_future_all_germany$S_20_24)-3.123951*(pred_future_all_germany$S_25_29)-2.737108*(pred_future_all_germany$S_30_34)-3.708771*(pred_future_all_germany$S_35_39)-1.350499*(pred_future_all_germany$S_40_44)-3.074073*(pred_future_all_germany$S_45_49)-4.367835*(pred_future_all_germany$S_55_59)-5.500043*(pred_future_all_germany$S_60_64)-3.243087*(pred_future_all_germany$S_65plus)+0.334054*(pred_future_all_germany$k)+1.08359*(pred_future_all_germany$hs)+0.484375*(pred_future_all_germany$lagy_hat_7)


pred_future_all_germany$y_hat = replace( pred_future_all_germany$y_hat, is.na(pred_future_all_germany$y_hat), 0 )
pred_future_all_germany$y_hat_2 = replace( pred_future_all_germany$y_hat_2, is.na(pred_future_all_germany$y_hat_2), 0 )
pred_future_all_germany$y_hat_3 = replace( pred_future_all_germany$y_hat_3, is.na(pred_future_all_germany$y_hat_3), 0 )
pred_future_all_germany$y_hat_4 = replace( pred_future_all_germany$y_hat_4, is.na(pred_future_all_germany$y_hat_4), 0 )
pred_future_all_germany$y_hat_5 = replace( pred_future_all_germany$y_hat_5, is.na(pred_future_all_germany$y_hat_5), 0 )
pred_future_all_germany$y_hat_6 = replace( pred_future_all_germany$y_hat_6, is.na(pred_future_all_germany$y_hat_6), 0 )
pred_future_all_germany$y_hat_7 = replace( pred_future_all_germany$y_hat_7, is.na(pred_future_all_germany$y_hat_7), 0 )
pred_future_all_germany$y_hat_8 = replace( pred_future_all_germany$y_hat_8, is.na(pred_future_all_germany$y_hat_8), 0 )

pred_future_all_germany$y_hat_main = pred_future_all_germany$y_hat+ pred_future_all_germany$y_hat_2+ pred_future_all_germany$y_hat_3+ pred_future_all_germany$y_hat_4+ pred_future_all_germany$y_hat_5+ pred_future_all_germany$y_hat_6+ pred_future_all_germany$y_hat_7+ pred_future_all_germany$y_hat_8


SAVE(dfx=pred_future_all_germany, namex ="pred_future_all_germany")

################################################################################################################+
# germany developed fit  ####

pred_future_developed_germany<-pred_future_germany

pred_future_developed_germany$y_hat <- 1.5805946-0.2073961*(pred_future_developed_germany$S_less20)+0.8007467*(pred_future_developed_germany$S_20_24)-1.396259*(pred_future_developed_germany$S_25_29)+1.0733377*(pred_future_developed_germany$S_30_34)-0.0560155*(pred_future_developed_germany$S_35_39)+0.3584896*(pred_future_developed_germany$S_40_44)-1.138184*(pred_future_developed_germany$S_45_49)-1.2991382*(pred_future_developed_germany$S_55_59)-0.6771723*(pred_future_developed_germany$S_60_64)-3.9143999*(pred_future_developed_germany$S_65plus)+0.2960277*(pred_future_developed_germany$k)+0.3101232*(pred_future_developed_germany$hs)+0.5812736*(pred_future_developed_germany$ymin1)

pred_future_developed_germany <- pred_future_developed_germany %>%                            # Add lagged column
  dplyr::mutate(lagy_hat = dplyr::lag(y_hat, n = 1, default = NA)) %>% 
  as.data.frame()

pred_future_developed_germany$y_hat_2 <- 1.5805946-0.2073961*(pred_future_developed_germany$S_less20)+0.8007467*(pred_future_developed_germany$S_20_24)-1.396259*(pred_future_developed_germany$S_25_29)+1.0733377*(pred_future_developed_germany$S_30_34)-0.0560155*(pred_future_developed_germany$S_35_39)+0.3584896*(pred_future_developed_germany$S_40_44)-1.138184*(pred_future_developed_germany$S_45_49)-1.2991382*(pred_future_developed_germany$S_55_59)-0.6771723*(pred_future_developed_germany$S_60_64)-3.9143999*(pred_future_developed_germany$S_65plus)+0.2960277*(pred_future_developed_germany$k)+0.3101232*(pred_future_developed_germany$hs)+0.5812736*(lag(pred_future_developed_germany$lagy_hat))

pred_future_developed_germany <- pred_future_developed_germany %>%                            # Add lagged column
  dplyr::mutate(lagy_hat_2 = dplyr::lag(y_hat_2, n = 1, default = NA)) %>% 
  as.data.frame()

pred_future_developed_germany$y_hat_3 <- 1.5805946-0.2073961*(pred_future_developed_germany$S_less20)+0.8007467*(pred_future_developed_germany$S_20_24)-1.396259*(pred_future_developed_germany$S_25_29)+1.0733377*(pred_future_developed_germany$S_30_34)-0.0560155*(pred_future_developed_germany$S_35_39)+0.3584896*(pred_future_developed_germany$S_40_44)-1.138184*(pred_future_developed_germany$S_45_49)-1.2991382*(pred_future_developed_germany$S_55_59)-0.6771723*(pred_future_developed_germany$S_60_64)-3.9143999*(pred_future_developed_germany$S_65plus)+0.2960277*(pred_future_developed_germany$k)+0.3101232*(pred_future_developed_germany$hs)+0.5812736*(lag(pred_future_developed_germany$lagy_hat_2))

pred_future_developed_germany <- pred_future_developed_germany %>%                            # Add lagged column
  dplyr::mutate(lagy_hat_3 = dplyr::lag(y_hat_3, n = 1, default = NA)) %>% 
  as.data.frame()

pred_future_developed_germany$y_hat_4 <- 1.5805946-0.2073961*(pred_future_developed_germany$S_less20)+0.8007467*(pred_future_developed_germany$S_20_24)-1.396259*(pred_future_developed_germany$S_25_29)+1.0733377*(pred_future_developed_germany$S_30_34)-0.0560155*(pred_future_developed_germany$S_35_39)+0.3584896*(pred_future_developed_germany$S_40_44)-1.138184*(pred_future_developed_germany$S_45_49)-1.2991382*(pred_future_developed_germany$S_55_59)-0.6771723*(pred_future_developed_germany$S_60_64)-3.9143999*(pred_future_developed_germany$S_65plus)+0.2960277*(pred_future_developed_germany$k)+0.3101232*(pred_future_developed_germany$hs)+0.5812736*(lag(pred_future_developed_germany$lagy_hat_3))

pred_future_developed_germany <- pred_future_developed_germany %>%                            # Add lagged column
  dplyr::mutate(lagy_hat_4 = dplyr::lag(y_hat_4, n = 1, default = NA)) %>% 
  as.data.frame()

pred_future_developed_germany$y_hat_5 <- 1.5805946-0.2073961*(pred_future_developed_germany$S_less20)+0.8007467*(pred_future_developed_germany$S_20_24)-1.396259*(pred_future_developed_germany$S_25_29)+1.0733377*(pred_future_developed_germany$S_30_34)-0.0560155*(pred_future_developed_germany$S_35_39)+0.3584896*(pred_future_developed_germany$S_40_44)-1.138184*(pred_future_developed_germany$S_45_49)-1.2991382*(pred_future_developed_germany$S_55_59)-0.6771723*(pred_future_developed_germany$S_60_64)-3.9143999*(pred_future_developed_germany$S_65plus)+0.2960277*(pred_future_developed_germany$k)+0.3101232*(pred_future_developed_germany$hs)+0.5812736*(lag(pred_future_developed_germany$lagy_hat_4))

pred_future_developed_germany <- pred_future_developed_germany %>%                            # Add lagged column
  dplyr::mutate(lagy_hat_5 = dplyr::lag(y_hat_5, n = 1, default = NA)) %>% 
  as.data.frame()

pred_future_developed_germany$y_hat_6<- 1.5805946-0.2073961*(pred_future_developed_germany$S_less20)+0.8007467*(pred_future_developed_germany$S_20_24)-1.396259*(pred_future_developed_germany$S_25_29)+1.0733377*(pred_future_developed_germany$S_30_34)-0.0560155*(pred_future_developed_germany$S_35_39)+0.3584896*(pred_future_developed_germany$S_40_44)-1.138184*(pred_future_developed_germany$S_45_49)-1.2991382*(pred_future_developed_germany$S_55_59)-0.6771723*(pred_future_developed_germany$S_60_64)-3.9143999*(pred_future_developed_germany$S_65plus)+0.2960277*(pred_future_developed_germany$k)+0.3101232*(pred_future_developed_germany$hs)+0.5812736*(lag(pred_future_developed_germany$lagy_hat_5))

pred_future_developed_germany <- pred_future_developed_germany %>%                            # Add lagged column
  dplyr::mutate(lagy_hat_6 = dplyr::lag(y_hat_6, n = 1, default = NA)) %>% 
  as.data.frame()

pred_future_developed_germany$y_hat_7<- 1.5805946-0.2073961*(pred_future_developed_germany$S_less20)+0.8007467*(pred_future_developed_germany$S_20_24)-1.396259*(pred_future_developed_germany$S_25_29)+1.0733377*(pred_future_developed_germany$S_30_34)-0.0560155*(pred_future_developed_germany$S_35_39)+0.3584896*(pred_future_developed_germany$S_40_44)-1.138184*(pred_future_developed_germany$S_45_49)-1.2991382*(pred_future_developed_germany$S_55_59)-0.6771723*(pred_future_developed_germany$S_60_64)-3.9143999*(pred_future_developed_germany$S_65plus)+0.2960277*(pred_future_developed_germany$k)+0.3101232*(pred_future_developed_germany$hs)+0.5812736*(lag(pred_future_developed_germany$lagy_hat_6))

pred_future_developed_germany <- pred_future_developed_germany %>%                            # Add lagged column
  dplyr::mutate(lagy_hat_7 = dplyr::lag(y_hat_7, n = 1, default = NA)) %>% 
  as.data.frame()
pred_future_developed_germany$y_hat_8<- 1.5805946-0.2073961*(pred_future_developed_germany$S_less20)+0.8007467*(pred_future_developed_germany$S_20_24)-1.396259*(pred_future_developed_germany$S_25_29)+1.0733377*(pred_future_developed_germany$S_30_34)-0.0560155*(pred_future_developed_germany$S_35_39)+0.3584896*(pred_future_developed_germany$S_40_44)-1.138184*(pred_future_developed_germany$S_45_49)-1.2991382*(pred_future_developed_germany$S_55_59)-0.6771723*(pred_future_developed_germany$S_60_64)-3.9143999*(pred_future_developed_germany$S_65plus)+0.2960277*(pred_future_developed_germany$k)+0.3101232*(pred_future_developed_germany$hs)+0.5812736*(lag(pred_future_developed_germany$lagy_hat_7))


pred_future_developed_germany$y_hat = replace( pred_future_developed_germany$y_hat, is.na(pred_future_developed_germany$y_hat), 0 )
pred_future_developed_germany$y_hat_2 = replace( pred_future_developed_germany$y_hat_2, is.na(pred_future_developed_germany$y_hat_2), 0 )
pred_future_developed_germany$y_hat_3 = replace( pred_future_developed_germany$y_hat_3, is.na(pred_future_developed_germany$y_hat_3), 0 )
pred_future_developed_germany$y_hat_4 = replace( pred_future_developed_germany$y_hat_4, is.na(pred_future_developed_germany$y_hat_4), 0 )
pred_future_developed_germany$y_hat_5 = replace( pred_future_developed_germany$y_hat_5, is.na(pred_future_developed_germany$y_hat_5), 0 )
pred_future_developed_germany$y_hat_6 = replace( pred_future_developed_germany$y_hat_6, is.na(pred_future_developed_germany$y_hat_6), 0 )
pred_future_developed_germany$y_hat_7 = replace( pred_future_developed_germany$y_hat_7, is.na(pred_future_developed_germany$y_hat_7), 0 )
pred_future_developed_germany$y_hat_8 = replace( pred_future_developed_germany$y_hat_8, is.na(pred_future_developed_germany$y_hat_8), 0 )

pred_future_developed_germany$y_hat_main = pred_future_developed_germany$y_hat+ pred_future_developed_germany$y_hat_2+ pred_future_developed_germany$y_hat_3+ pred_future_developed_germany$y_hat_4+ pred_future_developed_germany$y_hat_5+ pred_future_developed_germany$y_hat_6+ pred_future_developed_germany$y_hat_7+ pred_future_developed_germany$y_hat_8


SAVE(dfx=pred_future_developed_germany, namex ="pred_future_developed_germany")

##########################################################################################################

#India general 
pred_future_india<-subset(pred_future,id=="79")

pred_future_india[,"k"] <- c(10.46404231,
                             10.57032462,
                             10.67660692,
                             10.78288923,
                             10.88917154,
                             10.99545385,
                             11.10173615,
                             11.20801846)

#india all countries fit
pred_future_all_india<-pred_future_india

pred_future_all_india$y_hat <- 4.280841-3.064794*(pred_future_all_india$S_less20)-1.835247*(pred_future_all_india$S_20_24)-3.123951*(pred_future_all_india$S_25_29)-2.737108*(pred_future_all_india$S_30_34)-3.708771*(pred_future_all_india$S_35_39)-1.350499*(pred_future_all_india$S_40_44)-3.074073*(pred_future_all_india$S_45_49)-4.367835*(pred_future_all_india$S_55_59)-5.500043*(pred_future_all_india$S_60_64)-3.243087*(pred_future_all_india$S_65plus)+0.334054*(pred_future_all_india$k)+1.08359*(pred_future_all_india$hs)+0.484375*(pred_future_all_india$ymin1)

pred_future_all_india <- pred_future_all_india %>%                            # Add lagged column
  dplyr::mutate(lagy_hat = dplyr::lag(y_hat, n = 1, default = NA)) %>% 
  as.data.frame()

pred_future_all_india$y_hat_2<- 4.280841-3.064794*(pred_future_all_india$S_less20)-1.835247*(pred_future_all_india$S_20_24)-3.123951*(pred_future_all_india$S_25_29)-2.737108*(pred_future_all_india$S_30_34)-3.708771*(pred_future_all_india$S_35_39)-1.350499*(pred_future_all_india$S_40_44)-3.074073*(pred_future_all_india$S_45_49)-4.367835*(pred_future_all_india$S_55_59)-5.500043*(pred_future_all_india$S_60_64)-3.243087*(pred_future_all_india$S_65plus)+0.334054*(pred_future_all_india$k)+1.08359*(pred_future_all_india$hs)+0.484375*(pred_future_all_india$lagy_hat)

pred_future_all_india <- pred_future_all_india %>%                            # Add lagged column
  dplyr::mutate(lagy_hat_2 = dplyr::lag(y_hat_2, n = 1, default = NA)) %>% 
  as.data.frame()

pred_future_all_india$y_hat_3<- 4.280841-3.064794*(pred_future_all_india$S_less20)-1.835247*(pred_future_all_india$S_20_24)-3.123951*(pred_future_all_india$S_25_29)-2.737108*(pred_future_all_india$S_30_34)-3.708771*(pred_future_all_india$S_35_39)-1.350499*(pred_future_all_india$S_40_44)-3.074073*(pred_future_all_india$S_45_49)-4.367835*(pred_future_all_india$S_55_59)-5.500043*(pred_future_all_india$S_60_64)-3.243087*(pred_future_all_india$S_65plus)+0.334054*(pred_future_all_india$k)+1.08359*(pred_future_all_india$hs)+0.484375*(pred_future_all_india$lagy_hat_2)

pred_future_all_india <- pred_future_all_india %>%                            # Add lagged column
  dplyr::mutate(lagy_hat_3 = dplyr::lag(y_hat_3, n = 1, default = NA)) %>% 
  as.data.frame()

pred_future_all_india$y_hat_4<- 4.280841-3.064794*(pred_future_all_india$S_less20)-1.835247*(pred_future_all_india$S_20_24)-3.123951*(pred_future_all_india$S_25_29)-2.737108*(pred_future_all_india$S_30_34)-3.708771*(pred_future_all_india$S_35_39)-1.350499*(pred_future_all_india$S_40_44)-3.074073*(pred_future_all_india$S_45_49)-4.367835*(pred_future_all_india$S_55_59)-5.500043*(pred_future_all_india$S_60_64)-3.243087*(pred_future_all_india$S_65plus)+0.334054*(pred_future_all_india$k)+1.08359*(pred_future_all_india$hs)+0.484375*(pred_future_all_india$lagy_hat_3)

pred_future_all_india <- pred_future_all_india %>%                            # Add lagged column
  dplyr::mutate(lagy_hat_4 = dplyr::lag(y_hat_4, n = 1, default = NA)) %>% 
  as.data.frame()

pred_future_all_india$y_hat_5<- 4.280841-3.064794*(pred_future_all_india$S_less20)-1.835247*(pred_future_all_india$S_20_24)-3.123951*(pred_future_all_india$S_25_29)-2.737108*(pred_future_all_india$S_30_34)-3.708771*(pred_future_all_india$S_35_39)-1.350499*(pred_future_all_india$S_40_44)-3.074073*(pred_future_all_india$S_45_49)-4.367835*(pred_future_all_india$S_55_59)-5.500043*(pred_future_all_india$S_60_64)-3.243087*(pred_future_all_india$S_65plus)+0.334054*(pred_future_all_india$k)+1.08359*(pred_future_all_india$hs)+0.484375*(pred_future_all_india$lagy_hat_4)

pred_future_all_india <- pred_future_all_india %>%                            # Add lagged column
  dplyr::mutate(lagy_hat_5 = dplyr::lag(y_hat_5, n = 1, default = NA)) %>% 
  as.data.frame()

pred_future_all_india$y_hat_6<- 4.280841-3.064794*(pred_future_all_india$S_less20)-1.835247*(pred_future_all_india$S_20_24)-3.123951*(pred_future_all_india$S_25_29)-2.737108*(pred_future_all_india$S_30_34)-3.708771*(pred_future_all_india$S_35_39)-1.350499*(pred_future_all_india$S_40_44)-3.074073*(pred_future_all_india$S_45_49)-4.367835*(pred_future_all_india$S_55_59)-5.500043*(pred_future_all_india$S_60_64)-3.243087*(pred_future_all_india$S_65plus)+0.334054*(pred_future_all_india$k)+1.08359*(pred_future_all_india$hs)+0.484375*(pred_future_all_india$lagy_hat_5)

pred_future_all_india <- pred_future_all_india %>%                            # Add lagged column
  dplyr::mutate(lagy_hat_6 = dplyr::lag(y_hat_6, n = 1, default = NA)) %>% 
  as.data.frame()

pred_future_all_india$y_hat_7<- 4.280841-3.064794*(pred_future_all_india$S_less20)-1.835247*(pred_future_all_india$S_20_24)-3.123951*(pred_future_all_india$S_25_29)-2.737108*(pred_future_all_india$S_30_34)-3.708771*(pred_future_all_india$S_35_39)-1.350499*(pred_future_all_india$S_40_44)-3.074073*(pred_future_all_india$S_45_49)-4.367835*(pred_future_all_india$S_55_59)-5.500043*(pred_future_all_india$S_60_64)-3.243087*(pred_future_all_india$S_65plus)+0.334054*(pred_future_all_india$k)+1.08359*(pred_future_all_india$hs)+0.484375*(pred_future_all_india$lagy_hat_6)

pred_future_all_india <- pred_future_all_india %>%                            # Add lagged column
  dplyr::mutate(lagy_hat_7 = dplyr::lag(y_hat_7, n = 1, default = NA)) %>% 
  as.data.frame()

pred_future_all_india$y_hat_8<- 4.280841-3.064794*(pred_future_all_india$S_less20)-1.835247*(pred_future_all_india$S_20_24)-3.123951*(pred_future_all_india$S_25_29)-2.737108*(pred_future_all_india$S_30_34)-3.708771*(pred_future_all_india$S_35_39)-1.350499*(pred_future_all_india$S_40_44)-3.074073*(pred_future_all_india$S_45_49)-4.367835*(pred_future_all_india$S_55_59)-5.500043*(pred_future_all_india$S_60_64)-3.243087*(pred_future_all_india$S_65plus)+0.334054*(pred_future_all_india$k)+1.08359*(pred_future_all_india$hs)+0.484375*(pred_future_all_india$lagy_hat_7)


pred_future_all_india$y_hat = replace( pred_future_all_india$y_hat, is.na(pred_future_all_india$y_hat), 0 )
pred_future_all_india$y_hat_2 = replace( pred_future_all_india$y_hat_2, is.na(pred_future_all_india$y_hat_2), 0 )
pred_future_all_india$y_hat_3 = replace( pred_future_all_india$y_hat_3, is.na(pred_future_all_india$y_hat_3), 0 )
pred_future_all_india$y_hat_4 = replace( pred_future_all_india$y_hat_4, is.na(pred_future_all_india$y_hat_4), 0 )
pred_future_all_india$y_hat_5 = replace( pred_future_all_india$y_hat_5, is.na(pred_future_all_india$y_hat_5), 0 )
pred_future_all_india$y_hat_6 = replace( pred_future_all_india$y_hat_6, is.na(pred_future_all_india$y_hat_6), 0 )
pred_future_all_india$y_hat_7 = replace( pred_future_all_india$y_hat_7, is.na(pred_future_all_india$y_hat_7), 0 )
pred_future_all_india$y_hat_8 = replace( pred_future_all_india$y_hat_8, is.na(pred_future_all_india$y_hat_8), 0 )

pred_future_all_india$y_hat_main = pred_future_all_india$y_hat+ pred_future_all_india$y_hat_2+ pred_future_all_india$y_hat_3+ pred_future_all_india$y_hat_4+ pred_future_all_india$y_hat_5+ pred_future_all_india$y_hat_6+ pred_future_all_india$y_hat_7+ pred_future_all_india$y_hat_8


SAVE(dfx=pred_future_all_india, namex ="pred_future_all_india")

################################################################################################################+
# india developing fit  ####

pred_future_developing_india<-pred_future_india

pred_future_developing_india$y_hat <- 6.67762-5.05842*(pred_future_developing_india$S_less20)-4.66812*(pred_future_developing_india$S_20_24)-3.45042*(pred_future_developing_india$S_25_29)-7.0118*(pred_future_developing_india$S_30_34)-3.319*(pred_future_developing_india$S_35_39)-6.00305*(pred_future_developing_india$S_40_44)-3.04026*(pred_future_developing_india$S_45_49)-8.30647*(pred_future_developing_india$S_55_59)-8.9792*(pred_future_developing_india$S_60_64)-5.05149*(pred_future_developing_india$S_65plus)+0.35419*(pred_future_developing_india$k)+1.25337*(pred_future_developing_india$hs)+0.4191*(pred_future_developing_india$ymin1)

pred_future_developing_india <- pred_future_developing_india %>%                            # Add lagged column
  dplyr::mutate(lagy_hat = dplyr::lag(y_hat, n = 1, default = NA)) %>% 
  as.data.frame()

pred_future_developing_india$y_hat_2<- 6.67762-5.05842*(pred_future_developing_india$S_less20)-4.66812*(pred_future_developing_india$S_20_24)-3.45042*(pred_future_developing_india$S_25_29)-7.0118*(pred_future_developing_india$S_30_34)-3.319*(pred_future_developing_india$S_35_39)-6.00305*(pred_future_developing_india$S_40_44)-3.04026*(pred_future_developing_india$S_45_49)-8.30647*(pred_future_developing_india$S_55_59)-8.9792*(pred_future_developing_india$S_60_64)-5.05149*(pred_future_developing_india$S_65plus)+0.35419*(pred_future_developing_india$k)+1.25337*(pred_future_developing_india$hs)+0.4191*(pred_future_developing_india$lagy_hat)

pred_future_developing_india <- pred_future_developing_india %>%                            # Add lagged column
  dplyr::mutate(lagy_hat_2 = dplyr::lag(y_hat_2, n = 1, default = NA)) %>% 
  as.data.frame()

pred_future_developing_india$y_hat_3<- 6.67762-5.05842*(pred_future_developing_india$S_less20)-4.66812*(pred_future_developing_india$S_20_24)-3.45042*(pred_future_developing_india$S_25_29)-7.0118*(pred_future_developing_india$S_30_34)-3.319*(pred_future_developing_india$S_35_39)-6.00305*(pred_future_developing_india$S_40_44)-3.04026*(pred_future_developing_india$S_45_49)-8.30647*(pred_future_developing_india$S_55_59)-8.9792*(pred_future_developing_india$S_60_64)-5.05149*(pred_future_developing_india$S_65plus)+0.35419*(pred_future_developing_india$k)+1.25337*(pred_future_developing_india$hs)+0.4191*(pred_future_developing_india$lagy_hat_2)

pred_future_developing_india <- pred_future_developing_india %>%                            # Add lagged column
  dplyr::mutate(lagy_hat_3 = dplyr::lag(y_hat_3, n = 1, default = NA)) %>% 
  as.data.frame()

pred_future_developing_india$y_hat_4<- 6.67762-5.05842*(pred_future_developing_india$S_less20)-4.66812*(pred_future_developing_india$S_20_24)-3.45042*(pred_future_developing_india$S_25_29)-7.0118*(pred_future_developing_india$S_30_34)-3.319*(pred_future_developing_india$S_35_39)-6.00305*(pred_future_developing_india$S_40_44)-3.04026*(pred_future_developing_india$S_45_49)-8.30647*(pred_future_developing_india$S_55_59)-8.9792*(pred_future_developing_india$S_60_64)-5.05149*(pred_future_developing_india$S_65plus)+0.35419*(pred_future_developing_india$k)+1.25337*(pred_future_developing_india$hs)+0.4191*(pred_future_developing_india$lagy_hat_3)

pred_future_developing_india <- pred_future_developing_india %>%                            # Add lagged column
  dplyr::mutate(lagy_hat_4 = dplyr::lag(y_hat_4, n = 1, default = NA)) %>% 
  as.data.frame()

pred_future_developing_india$y_hat_5<- 6.67762-5.05842*(pred_future_developing_india$S_less20)-4.66812*(pred_future_developing_india$S_20_24)-3.45042*(pred_future_developing_india$S_25_29)-7.0118*(pred_future_developing_india$S_30_34)-3.319*(pred_future_developing_india$S_35_39)-6.00305*(pred_future_developing_india$S_40_44)-3.04026*(pred_future_developing_india$S_45_49)-8.30647*(pred_future_developing_india$S_55_59)-8.9792*(pred_future_developing_india$S_60_64)-5.05149*(pred_future_developing_india$S_65plus)+0.35419*(pred_future_developing_india$k)+1.25337*(pred_future_developing_india$hs)+0.4191*(pred_future_developing_india$lagy_hat_4)

pred_future_developing_india <- pred_future_developing_india %>%                            # Add lagged column
  dplyr::mutate(lagy_hat_5 = dplyr::lag(y_hat_5, n = 1, default = NA)) %>% 
  as.data.frame()

pred_future_developing_india$y_hat_6<- 6.67762-5.05842*(pred_future_developing_india$S_less20)-4.66812*(pred_future_developing_india$S_20_24)-3.45042*(pred_future_developing_india$S_25_29)-7.0118*(pred_future_developing_india$S_30_34)-3.319*(pred_future_developing_india$S_35_39)-6.00305*(pred_future_developing_india$S_40_44)-3.04026*(pred_future_developing_india$S_45_49)-8.30647*(pred_future_developing_india$S_55_59)-8.9792*(pred_future_developing_india$S_60_64)-5.05149*(pred_future_developing_india$S_65plus)+0.35419*(pred_future_developing_india$k)+1.25337*(pred_future_developing_india$hs)+0.4191*(pred_future_developing_india$lagy_hat_5)

pred_future_developing_india <- pred_future_developing_india %>%                            # Add lagged column
  dplyr::mutate(lagy_hat_6 = dplyr::lag(y_hat_6, n = 1, default = NA)) %>% 
  as.data.frame()

pred_future_developing_india$y_hat_7<- 6.67762-5.05842*(pred_future_developing_india$S_less20)-4.66812*(pred_future_developing_india$S_20_24)-3.45042*(pred_future_developing_india$S_25_29)-7.0118*(pred_future_developing_india$S_30_34)-3.319*(pred_future_developing_india$S_35_39)-6.00305*(pred_future_developing_india$S_40_44)-3.04026*(pred_future_developing_india$S_45_49)-8.30647*(pred_future_developing_india$S_55_59)-8.9792*(pred_future_developing_india$S_60_64)-5.05149*(pred_future_developing_india$S_65plus)+0.35419*(pred_future_developing_india$k)+1.25337*(pred_future_developing_india$hs)+0.4191*(pred_future_developing_india$lagy_hat_6)

pred_future_developing_india <- pred_future_developing_india %>%                            # Add lagged column
  dplyr::mutate(lagy_hat_7 = dplyr::lag(y_hat_7, n = 1, default = NA)) %>% 
  as.data.frame()

pred_future_developing_india$y_hat_8<- 6.67762-5.05842*(pred_future_developing_india$S_less20)-4.66812*(pred_future_developing_india$S_20_24)-3.45042*(pred_future_developing_india$S_25_29)-7.0118*(pred_future_developing_india$S_30_34)-3.319*(pred_future_developing_india$S_35_39)-6.00305*(pred_future_developing_india$S_40_44)-3.04026*(pred_future_developing_india$S_45_49)-8.30647*(pred_future_developing_india$S_55_59)-8.9792*(pred_future_developing_india$S_60_64)-5.05149*(pred_future_developing_india$S_65plus)+0.35419*(pred_future_developing_india$k)+1.25337*(pred_future_developing_india$hs)+0.4191*(pred_future_developing_india$lagy_hat_7)


pred_future_developing_india$y_hat = replace( pred_future_developing_india$y_hat, is.na(pred_future_developing_india$y_hat), 0 )
pred_future_developing_india$y_hat_2 = replace( pred_future_developing_india$y_hat_2, is.na(pred_future_developing_india$y_hat_2), 0 )
pred_future_developing_india$y_hat_3 = replace( pred_future_developing_india$y_hat_3, is.na(pred_future_developing_india$y_hat_3), 0 )
pred_future_developing_india$y_hat_4 = replace( pred_future_developing_india$y_hat_4, is.na(pred_future_developing_india$y_hat_4), 0 )
pred_future_developing_india$y_hat_5 = replace( pred_future_developing_india$y_hat_5, is.na(pred_future_developing_india$y_hat_5), 0 )
pred_future_developing_india$y_hat_6 = replace( pred_future_developing_india$y_hat_6, is.na(pred_future_developing_india$y_hat_6), 0 )
pred_future_developing_india$y_hat_7 = replace( pred_future_developing_india$y_hat_7, is.na(pred_future_developing_india$y_hat_7), 0 )
pred_future_developing_india$y_hat_8 = replace( pred_future_developing_india$y_hat_8, is.na(pred_future_developing_india$y_hat_8), 0 )

pred_future_developing_india$y_hat_main = pred_future_developing_india$y_hat+ pred_future_developing_india$y_hat_2+ pred_future_developing_india$y_hat_3+ pred_future_developing_india$y_hat_4+ pred_future_developing_india$y_hat_5+ pred_future_developing_india$y_hat_6+ pred_future_developing_india$y_hat_7+ pred_future_developing_india$y_hat_8


SAVE(dfx=pred_future_developing_india, namex ="pred_future_developing_india")


################################################################################

##########################################################################################################

#Sri Lanka general 
pred_future_sl<-subset(pred_future,id=="103")

pred_future_sl[,"k"] <- c(11.19577554,
                          11.33257108,
                          11.46936662,
                          11.60616215,
                          11.74295769,
                          11.87975323,
                          12.01654877,
                          12.15334431)

#Sri Lanka all countries fit
pred_future_all_sl<-pred_future_sl

pred_future_all_sl$y_hat <- 4.280841-3.064794*(pred_future_all_sl$S_less20)-1.835247*(pred_future_all_sl$S_20_24)-3.123951*(pred_future_all_sl$S_25_29)-2.737108*(pred_future_all_sl$S_30_34)-3.708771*(pred_future_all_sl$S_35_39)-1.350499*(pred_future_all_sl$S_40_44)-3.074073*(pred_future_all_sl$S_45_49)-4.367835*(pred_future_all_sl$S_55_59)-5.500043*(pred_future_all_sl$S_60_64)-3.243087*(pred_future_all_sl$S_65plus)+0.334054*(pred_future_all_sl$k)+1.08359*(pred_future_all_sl$hs)+0.484375*(pred_future_all_sl$ymin1)

pred_future_all_sl <- pred_future_all_sl %>%                            # Add lagged column
  dplyr::mutate(lagy_hat = dplyr::lag(y_hat, n = 1, default = NA)) %>% 
  as.data.frame()

pred_future_all_sl$y_hat_2<- 4.280841-3.064794*(pred_future_all_sl$S_less20)-1.835247*(pred_future_all_sl$S_20_24)-3.123951*(pred_future_all_sl$S_25_29)-2.737108*(pred_future_all_sl$S_30_34)-3.708771*(pred_future_all_sl$S_35_39)-1.350499*(pred_future_all_sl$S_40_44)-3.074073*(pred_future_all_sl$S_45_49)-4.367835*(pred_future_all_sl$S_55_59)-5.500043*(pred_future_all_sl$S_60_64)-3.243087*(pred_future_all_sl$S_65plus)+0.334054*(pred_future_all_sl$k)+1.08359*(pred_future_all_sl$hs)+0.484375*(pred_future_all_sl$lagy_hat)

pred_future_all_sl <- pred_future_all_sl %>%                            # Add lagged column
  dplyr::mutate(lagy_hat_2 = dplyr::lag(y_hat_2, n = 1, default = NA)) %>% 
  as.data.frame()

pred_future_all_sl$y_hat_3<- 4.280841-3.064794*(pred_future_all_sl$S_less20)-1.835247*(pred_future_all_sl$S_20_24)-3.123951*(pred_future_all_sl$S_25_29)-2.737108*(pred_future_all_sl$S_30_34)-3.708771*(pred_future_all_sl$S_35_39)-1.350499*(pred_future_all_sl$S_40_44)-3.074073*(pred_future_all_sl$S_45_49)-4.367835*(pred_future_all_sl$S_55_59)-5.500043*(pred_future_all_sl$S_60_64)-3.243087*(pred_future_all_sl$S_65plus)+0.334054*(pred_future_all_sl$k)+1.08359*(pred_future_all_sl$hs)+0.484375*(pred_future_all_sl$lagy_hat_2)

pred_future_all_sl <- pred_future_all_sl %>%                            # Add lagged column
  dplyr::mutate(lagy_hat_3 = dplyr::lag(y_hat_3, n = 1, default = NA)) %>% 
  as.data.frame()

pred_future_all_sl$y_hat_4<- 4.280841-3.064794*(pred_future_all_sl$S_less20)-1.835247*(pred_future_all_sl$S_20_24)-3.123951*(pred_future_all_sl$S_25_29)-2.737108*(pred_future_all_sl$S_30_34)-3.708771*(pred_future_all_sl$S_35_39)-1.350499*(pred_future_all_sl$S_40_44)-3.074073*(pred_future_all_sl$S_45_49)-4.367835*(pred_future_all_sl$S_55_59)-5.500043*(pred_future_all_sl$S_60_64)-3.243087*(pred_future_all_sl$S_65plus)+0.334054*(pred_future_all_sl$k)+1.08359*(pred_future_all_sl$hs)+0.484375*(pred_future_all_sl$lagy_hat_3)

pred_future_all_sl <- pred_future_all_sl %>%                            # Add lagged column
  dplyr::mutate(lagy_hat_4 = dplyr::lag(y_hat_4, n = 1, default = NA)) %>% 
  as.data.frame()

pred_future_all_sl$y_hat_5<- 4.280841-3.064794*(pred_future_all_sl$S_less20)-1.835247*(pred_future_all_sl$S_20_24)-3.123951*(pred_future_all_sl$S_25_29)-2.737108*(pred_future_all_sl$S_30_34)-3.708771*(pred_future_all_sl$S_35_39)-1.350499*(pred_future_all_sl$S_40_44)-3.074073*(pred_future_all_sl$S_45_49)-4.367835*(pred_future_all_sl$S_55_59)-5.500043*(pred_future_all_sl$S_60_64)-3.243087*(pred_future_all_sl$S_65plus)+0.334054*(pred_future_all_sl$k)+1.08359*(pred_future_all_sl$hs)+0.484375*(pred_future_all_sl$lagy_hat_4)

pred_future_all_sl <- pred_future_all_sl %>%                            # Add lagged column
  dplyr::mutate(lagy_hat_5 = dplyr::lag(y_hat_5, n = 1, default = NA)) %>% 
  as.data.frame()

pred_future_all_sl$y_hat_6<- 4.280841-3.064794*(pred_future_all_sl$S_less20)-1.835247*(pred_future_all_sl$S_20_24)-3.123951*(pred_future_all_sl$S_25_29)-2.737108*(pred_future_all_sl$S_30_34)-3.708771*(pred_future_all_sl$S_35_39)-1.350499*(pred_future_all_sl$S_40_44)-3.074073*(pred_future_all_sl$S_45_49)-4.367835*(pred_future_all_sl$S_55_59)-5.500043*(pred_future_all_sl$S_60_64)-3.243087*(pred_future_all_sl$S_65plus)+0.334054*(pred_future_all_sl$k)+1.08359*(pred_future_all_sl$hs)+0.484375*(pred_future_all_sl$lagy_hat_5)

pred_future_all_sl <- pred_future_all_sl %>%                            # Add lagged column
  dplyr::mutate(lagy_hat_6 = dplyr::lag(y_hat_6, n = 1, default = NA)) %>% 
  as.data.frame()

pred_future_all_sl$y_hat_7<- 4.280841-3.064794*(pred_future_all_sl$S_less20)-1.835247*(pred_future_all_sl$S_20_24)-3.123951*(pred_future_all_sl$S_25_29)-2.737108*(pred_future_all_sl$S_30_34)-3.708771*(pred_future_all_sl$S_35_39)-1.350499*(pred_future_all_sl$S_40_44)-3.074073*(pred_future_all_sl$S_45_49)-4.367835*(pred_future_all_sl$S_55_59)-5.500043*(pred_future_all_sl$S_60_64)-3.243087*(pred_future_all_sl$S_65plus)+0.334054*(pred_future_all_sl$k)+1.08359*(pred_future_all_sl$hs)+0.484375*(pred_future_all_sl$lagy_hat_6)

pred_future_all_sl <- pred_future_all_sl %>%                            # Add lagged column
  dplyr::mutate(lagy_hat_7 = dplyr::lag(y_hat_7, n = 1, default = NA)) %>% 
  as.data.frame()

pred_future_all_sl$y_hat_8<- 4.280841-3.064794*(pred_future_all_sl$S_less20)-1.835247*(pred_future_all_sl$S_20_24)-3.123951*(pred_future_all_sl$S_25_29)-2.737108*(pred_future_all_sl$S_30_34)-3.708771*(pred_future_all_sl$S_35_39)-1.350499*(pred_future_all_sl$S_40_44)-3.074073*(pred_future_all_sl$S_45_49)-4.367835*(pred_future_all_sl$S_55_59)-5.500043*(pred_future_all_sl$S_60_64)-3.243087*(pred_future_all_sl$S_65plus)+0.334054*(pred_future_all_sl$k)+1.08359*(pred_future_all_sl$hs)+0.484375*(pred_future_all_sl$lagy_hat_7)


pred_future_all_sl$y_hat = replace( pred_future_all_sl$y_hat, is.na(pred_future_all_sl$y_hat), 0 )
pred_future_all_sl$y_hat_2 = replace( pred_future_all_sl$y_hat_2, is.na(pred_future_all_sl$y_hat_2), 0 )
pred_future_all_sl$y_hat_3 = replace( pred_future_all_sl$y_hat_3, is.na(pred_future_all_sl$y_hat_3), 0 )
pred_future_all_sl$y_hat_4 = replace( pred_future_all_sl$y_hat_4, is.na(pred_future_all_sl$y_hat_4), 0 )
pred_future_all_sl$y_hat_5 = replace( pred_future_all_sl$y_hat_5, is.na(pred_future_all_sl$y_hat_5), 0 )
pred_future_all_sl$y_hat_6 = replace( pred_future_all_sl$y_hat_6, is.na(pred_future_all_sl$y_hat_6), 0 )
pred_future_all_sl$y_hat_7 = replace( pred_future_all_sl$y_hat_7, is.na(pred_future_all_sl$y_hat_7), 0 )
pred_future_all_sl$y_hat_8 = replace( pred_future_all_sl$y_hat_8, is.na(pred_future_all_sl$y_hat_8), 0 )

pred_future_all_sl$y_hat_main = pred_future_all_sl$y_hat+ pred_future_all_sl$y_hat_2+ pred_future_all_sl$y_hat_3+ pred_future_all_sl$y_hat_4+ pred_future_all_sl$y_hat_5+ pred_future_all_sl$y_hat_6+ pred_future_all_sl$y_hat_7+ pred_future_all_sl$y_hat_8


SAVE(dfx=pred_future_all_sl, namex ="pred_future_all_sl")

################################################################################################################+
# Sri Lanka developing fit  ####

pred_future_developing_sl<-pred_future_sl

pred_future_developing_sl$y_hat <- 6.67762-5.05842*(pred_future_developing_sl$S_less20)-4.66812*(pred_future_developing_sl$S_20_24)-3.45042*(pred_future_developing_sl$S_25_29)-7.0118*(pred_future_developing_sl$S_30_34)-3.319*(pred_future_developing_sl$S_35_39)-6.00305*(pred_future_developing_sl$S_40_44)-3.04026*(pred_future_developing_sl$S_45_49)-8.30647*(pred_future_developing_sl$S_55_59)-8.9792*(pred_future_developing_sl$S_60_64)-5.05149*(pred_future_developing_sl$S_65plus)+0.35419*(pred_future_developing_sl$k)+1.25337*(pred_future_developing_sl$hs)+0.4191*(pred_future_developing_sl$ymin1)

pred_future_developing_sl <- pred_future_developing_sl %>%                            # Add lagged column
  dplyr::mutate(lagy_hat = dplyr::lag(y_hat, n = 1, default = NA)) %>% 
  as.data.frame()

pred_future_developing_sl$y_hat_2<- 6.67762-5.05842*(pred_future_developing_sl$S_less20)-4.66812*(pred_future_developing_sl$S_20_24)-3.45042*(pred_future_developing_sl$S_25_29)-7.0118*(pred_future_developing_sl$S_30_34)-3.319*(pred_future_developing_sl$S_35_39)-6.00305*(pred_future_developing_sl$S_40_44)-3.04026*(pred_future_developing_sl$S_45_49)-8.30647*(pred_future_developing_sl$S_55_59)-8.9792*(pred_future_developing_sl$S_60_64)-5.05149*(pred_future_developing_sl$S_65plus)+0.35419*(pred_future_developing_sl$k)+1.25337*(pred_future_developing_sl$hs)+0.4191*(pred_future_developing_sl$lagy_hat)

pred_future_developing_sl <- pred_future_developing_sl %>%                            # Add lagged column
  dplyr::mutate(lagy_hat_2 = dplyr::lag(y_hat_2, n = 1, default = NA)) %>% 
  as.data.frame()

pred_future_developing_sl$y_hat_3<- 6.67762-5.05842*(pred_future_developing_sl$S_less20)-4.66812*(pred_future_developing_sl$S_20_24)-3.45042*(pred_future_developing_sl$S_25_29)-7.0118*(pred_future_developing_sl$S_30_34)-3.319*(pred_future_developing_sl$S_35_39)-6.00305*(pred_future_developing_sl$S_40_44)-3.04026*(pred_future_developing_sl$S_45_49)-8.30647*(pred_future_developing_sl$S_55_59)-8.9792*(pred_future_developing_sl$S_60_64)-5.05149*(pred_future_developing_sl$S_65plus)+0.35419*(pred_future_developing_sl$k)+1.25337*(pred_future_developing_sl$hs)+0.4191*(pred_future_developing_sl$lagy_hat_2)

pred_future_developing_sl <- pred_future_developing_sl %>%                            # Add lagged column
  dplyr::mutate(lagy_hat_3 = dplyr::lag(y_hat_3, n = 1, default = NA)) %>% 
  as.data.frame()

pred_future_developing_sl$y_hat_4<- 6.67762-5.05842*(pred_future_developing_sl$S_less20)-4.66812*(pred_future_developing_sl$S_20_24)-3.45042*(pred_future_developing_sl$S_25_29)-7.0118*(pred_future_developing_sl$S_30_34)-3.319*(pred_future_developing_sl$S_35_39)-6.00305*(pred_future_developing_sl$S_40_44)-3.04026*(pred_future_developing_sl$S_45_49)-8.30647*(pred_future_developing_sl$S_55_59)-8.9792*(pred_future_developing_sl$S_60_64)-5.05149*(pred_future_developing_sl$S_65plus)+0.35419*(pred_future_developing_sl$k)+1.25337*(pred_future_developing_sl$hs)+0.4191*(pred_future_developing_sl$lagy_hat_3)

pred_future_developing_sl <- pred_future_developing_sl %>%                            # Add lagged column
  dplyr::mutate(lagy_hat_4 = dplyr::lag(y_hat_4, n = 1, default = NA)) %>% 
  as.data.frame()

pred_future_developing_sl$y_hat_5<- 6.67762-5.05842*(pred_future_developing_sl$S_less20)-4.66812*(pred_future_developing_sl$S_20_24)-3.45042*(pred_future_developing_sl$S_25_29)-7.0118*(pred_future_developing_sl$S_30_34)-3.319*(pred_future_developing_sl$S_35_39)-6.00305*(pred_future_developing_sl$S_40_44)-3.04026*(pred_future_developing_sl$S_45_49)-8.30647*(pred_future_developing_sl$S_55_59)-8.9792*(pred_future_developing_sl$S_60_64)-5.05149*(pred_future_developing_sl$S_65plus)+0.35419*(pred_future_developing_sl$k)+1.25337*(pred_future_developing_sl$hs)+0.4191*(pred_future_developing_sl$lagy_hat_4)

pred_future_developing_sl <- pred_future_developing_sl %>%                            # Add lagged column
  dplyr::mutate(lagy_hat_5 = dplyr::lag(y_hat_5, n = 1, default = NA)) %>% 
  as.data.frame()

pred_future_developing_sl$y_hat_6<- 6.67762-5.05842*(pred_future_developing_sl$S_less20)-4.66812*(pred_future_developing_sl$S_20_24)-3.45042*(pred_future_developing_sl$S_25_29)-7.0118*(pred_future_developing_sl$S_30_34)-3.319*(pred_future_developing_sl$S_35_39)-6.00305*(pred_future_developing_sl$S_40_44)-3.04026*(pred_future_developing_sl$S_45_49)-8.30647*(pred_future_developing_sl$S_55_59)-8.9792*(pred_future_developing_sl$S_60_64)-5.05149*(pred_future_developing_sl$S_65plus)+0.35419*(pred_future_developing_sl$k)+1.25337*(pred_future_developing_sl$hs)+0.4191*(pred_future_developing_sl$lagy_hat_5)

pred_future_developing_sl <- pred_future_developing_sl %>%                            # Add lagged column
  dplyr::mutate(lagy_hat_6 = dplyr::lag(y_hat_6, n = 1, default = NA)) %>% 
  as.data.frame()

pred_future_developing_sl$y_hat_7<- 6.67762-5.05842*(pred_future_developing_sl$S_less20)-4.66812*(pred_future_developing_sl$S_20_24)-3.45042*(pred_future_developing_sl$S_25_29)-7.0118*(pred_future_developing_sl$S_30_34)-3.319*(pred_future_developing_sl$S_35_39)-6.00305*(pred_future_developing_sl$S_40_44)-3.04026*(pred_future_developing_sl$S_45_49)-8.30647*(pred_future_developing_sl$S_55_59)-8.9792*(pred_future_developing_sl$S_60_64)-5.05149*(pred_future_developing_sl$S_65plus)+0.35419*(pred_future_developing_sl$k)+1.25337*(pred_future_developing_sl$hs)+0.4191*(pred_future_developing_sl$lagy_hat_6)

pred_future_developing_sl <- pred_future_developing_sl %>%                            # Add lagged column
  dplyr::mutate(lagy_hat_7 = dplyr::lag(y_hat_7, n = 1, default = NA)) %>% 
  as.data.frame()

pred_future_developing_sl$y_hat_8<- 6.67762-5.05842*(pred_future_developing_sl$S_less20)-4.66812*(pred_future_developing_sl$S_20_24)-3.45042*(pred_future_developing_sl$S_25_29)-7.0118*(pred_future_developing_sl$S_30_34)-3.319*(pred_future_developing_sl$S_35_39)-6.00305*(pred_future_developing_sl$S_40_44)-3.04026*(pred_future_developing_sl$S_45_49)-8.30647*(pred_future_developing_sl$S_55_59)-8.9792*(pred_future_developing_sl$S_60_64)-5.05149*(pred_future_developing_sl$S_65plus)+0.35419*(pred_future_developing_sl$k)+1.25337*(pred_future_developing_sl$hs)+0.4191*(pred_future_developing_sl$lagy_hat_7)


pred_future_developing_sl$y_hat = replace( pred_future_developing_sl$y_hat, is.na(pred_future_developing_sl$y_hat), 0 )
pred_future_developing_sl$y_hat_2 = replace( pred_future_developing_sl$y_hat_2, is.na(pred_future_developing_sl$y_hat_2), 0 )
pred_future_developing_sl$y_hat_3 = replace( pred_future_developing_sl$y_hat_3, is.na(pred_future_developing_sl$y_hat_3), 0 )
pred_future_developing_sl$y_hat_4 = replace( pred_future_developing_sl$y_hat_4, is.na(pred_future_developing_sl$y_hat_4), 0 )
pred_future_developing_sl$y_hat_5 = replace( pred_future_developing_sl$y_hat_5, is.na(pred_future_developing_sl$y_hat_5), 0 )
pred_future_developing_sl$y_hat_6 = replace( pred_future_developing_sl$y_hat_6, is.na(pred_future_developing_sl$y_hat_6), 0 )
pred_future_developing_sl$y_hat_7 = replace( pred_future_developing_sl$y_hat_7, is.na(pred_future_developing_sl$y_hat_7), 0 )
pred_future_developing_sl$y_hat_8 = replace( pred_future_developing_sl$y_hat_8, is.na(pred_future_developing_sl$y_hat_8), 0 )

pred_future_developing_sl$y_hat_main = pred_future_developing_sl$y_hat+ pred_future_developing_sl$y_hat_2+ pred_future_developing_sl$y_hat_3+ pred_future_developing_sl$y_hat_4+ pred_future_developing_sl$y_hat_5+ pred_future_developing_sl$y_hat_6+ pred_future_developing_sl$y_hat_7+ pred_future_developing_sl$y_hat_8


SAVE(dfx=pred_future_developing_sl, namex ="pred_future_developing_sl")


################################################################################

