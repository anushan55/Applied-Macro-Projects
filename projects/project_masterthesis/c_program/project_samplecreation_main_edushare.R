# TARGET: Create a sample of share of educated individuals in each country at each phase
# INDATA: project_varcreation_merge
# OUTDATA/ OUTPUT:Summary database

################################################################################################################+
# All countries ####

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
# Load Main Data ####
df<-LOAD(dfinput=paste0(DFMERGE, "_control"))


#calculate whether educated or not
df$skilled<- ifelse(df$e>= 12, 1,0)
summary(df$skilled)
ggplot(df, aes(x = skilled)) +
  geom_histogram(binwidth = 1, fill = "skyblue", color = "black")
table(df$skilled)

#create combined country and phase code
df$country_phase <- paste(df$country_code, df$phase_number)
unique(df$country_phase)
colnames(df)

#Add share of education
df_country_phase_skilled <- aggregate(skilled ~ country_phase, data = df, FUN = mean, na.rm = TRUE)
ggplot(df_country_phase_skilled, aes(x = skilled))+ 
  geom_histogram(fill = "skyblue", color = "black")+
  ggtitle("Distribution of the share of skilled individuals in each country") +
  xlab("share of skilled")

#Add life expectancy 
df_country_phase_t<- aggregate(t ~ country_phase, data = df, FUN = mean, na.rm = TRUE)

#Add survival rate 
df_country_phase_pie<- aggregate(pie ~ country_phase, data = df, FUN = mean, na.rm = TRUE)
 
#Add GDP per capita
df_country_phase_gdp_pc<- aggregate(gdp_pc ~ country_phase, data = df, FUN = mean, na.rm = TRUE)

#Add fertility
df_country_phase_n<- aggregate(n ~ country_phase, data = df, FUN = mean, na.rm = TRUE)

#Combine lifex and share of education
df_summary<-inner_join(df_country_phase_skilled, df_country_phase_t, by = "country_phase")

#Combine survival rate
df_summary<-inner_join(df_summary, df_country_phase_pie, by = "country_phase")

#combine GDP per capita 
df_summary<-inner_join(df_summary, df_country_phase_gdp_pc, by = "country_phase")

#combine fertility
df_summary<-inner_join(df_summary, df_country_phase_n, by = "country_phase")



df_summary_2 <- df %>%
  group_by(country_code, phase_number) %>%
  summarise(
    count = n(),
    skilled = mean(skilled, na.rm = TRUE),
    t = mean(t, na.rm = TRUE),
    pie = mean(pie, na.rm = TRUE),
    gdp_pc = mean(gdp_pc, na.rm = TRUE),
    n = mean(n, na.rm = TRUE)
  )

# df_summary_2<-df_summary_2[df_summary_2$count>100, ]

head(df_summary_2)


##Obtain lagged for a generation variables 

#create seperate dataframe with phases for each country
country_codes <- unique(df_summary_2$country_code)
phase_numbers <- 1:7

df_new <- data.frame(country_code = rep(country_codes, each=length(phase_numbers)), 
                     phase_number=rep(phase_numbers, times=length(country_codes)))

df_summary_3<-left_join(df_new, df_summary_2, by=c("country_code", "phase_number"))



df_summary_3$phase_number_l<-ifelse(df_summary_3$phase_number>4, 
                                    ifelse(df_summary_3$phase_number==5,1,
                                           ifelse(df_summary_3$phase_number==6,2,3)),
                                    NA)



#Duplicate the df to join the lagged variables
df_summary_4<-df_summary_3

df_summary_4$phase_number_l<-df_summary_4$phase_number

df_summary_4$skilled_lag<-df_summary_4$skilled
df_summary_4$gdp_pc_lag<-df_summary_4$gdp_pc

df_summary_4$phase_country <- paste(df_summary_4$country_code,df_summary_4$phase_number)

df_summary_4<-df_summary_4[ , c("phase_country", "skilled_lag", "gdp_pc_lag")]


#create variable to join in og df 
df_summary_3$phase_country <- paste(df_summary_3$country_code,df_summary_3$phase_number_l)

##Join the lagged variables from duplicate
df_summary_5<- left_join(df_summary_3, df_summary_4, by="phase_country")



##Complete cases 
df_sum<- df_summary_5[complete.cases(df_summary_5), ]

colnames(df_sum) 






#Equation 1 ##########################################################################

#regress equation
reg1<- lm(t~skilled_lag, df_sum)
# reg0_1<-lm(I(ln(t))~I(ln(skilled_lag)))
stargazer(reg1, type ="text")
ggplot(df_summary, aes(t,skilled))+geom_point() +labs(title="All phases") + geom_smooth(method = 'lm')


#Equation 2#######################################################################

#Regression
reg2<- lm(pie~skilled_lag+gdp_pc_lag, df_sum)
stargazer(reg2, type ="text")


#Derive a 2nd stage equation
reg3<- lm(n~skilled_lag+gdp_pc_lag, df_sum)
stargazer(reg3, type ="text")


stargazer(reg1, reg2, reg3,type ="text" )




# ## Group data by a variable and compute summary statistics
# df_country_phase <- df %>%
#   group_by(country_phase) %>%
#   summarize(average_skilled = mean(skilled, na.rm = TRUE))


#restrict to non-missing rows
dim(df)
df <- df[complete.cases(df),]
dim(df)


#save 
SAVE(dfx=df, namex = MAINNAME, pattdir = A)


#####################################################################################################################



