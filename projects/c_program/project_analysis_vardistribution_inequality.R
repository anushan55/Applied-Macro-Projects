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

df_svy<- df_svy[df_svy$country_code=="ID", ]

unique(df_svy$country_code)

colnames(df_svy)


###Unweighted deciles ============================================================
deciles_e <- quantile(df_svy$e, probs=seq(0.1, 0.9, by = 0.1))
plot(deciles_e, type='l', 
     main="Deciles of education", xlab="Decile", ylab="Years of Education")

#there is a difference between weighted and unweighted deciles


###survey design specification ===================================================
df_design <- svydesign(ids = ~1,
                         data = df_svy,
                         weights = ~smpwt)

###Calculate the weighted deciles
weighted_deciles_e <- wtd.quantile(df_svy$e, 
                                   weights=df_svy$smpwt, 
                                   probs= seq(0.0, 1.0, by = 0.1))
weighted_deciles_e

plot(seq(0.0, 1.0, by = 0.1), weighted_deciles_e, type='l', 
     main="Weighted deciles", xlab="Deciles", ylab="Year of Education")


################################################################################
###Fertility values for each decile
# Calculate the ranks of 'e'
df_svy$e_rank <- rank(df_svy$e)
summary(df_svy$e_rank)
ggplot(df_svy, aes(x=e_rank))+geom_histogram()


# Create a new variable indicating the decile of 'e' based on the ranks
df_svy$e_decile <- cut(df_svy$e_rank, 
                         breaks = 10, 
                         labels = 1:10, 
                         include.lowest = TRUE)


# Update the survey design
df_design <- update(df_design, e_decile = df_svy$e_decile)

# Calculate the weighted mean of 'n' within each decile of 'e'
average_fertility_by_decile <- svyby(formula = ~n, 
                                     by = ~e_decile, 
                                     design = df_design, 
                                     FUN = svymean)


average_education_by_decile <- svyby(formula = ~e, 
                                     by = ~e_decile, 
                                     design = df_design, 
                                     FUN = svymean)

# Print the average fertility by decile
plot(average_fertility_by_decile)

plot(average_fertility_by_decile, type='l', 
     main="Average fertility for each decile of education in Indonesia", xlab="Decile of education", ylab="Fertility")

ggplot(average_fertility_by_decile, aes(e_decile, n)) +
  geom_point() +
  geom_line(aes(group = 1), color = "red")+
  labs(title = "Average Fertility for Each Decile of Education in Indonesia",
       x = "Decile of Education",
       y = "Average Fertility")


#find average fertility based on model













#other useful funtions =========================================================
# plot(ecdf(df_svy$e), main="ECDF Plot", xlab="Values", ylab="ECDF")
#qqnorm(df$e)
