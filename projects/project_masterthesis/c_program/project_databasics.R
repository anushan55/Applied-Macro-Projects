# TARGET: Load the main Dataset
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

# Import dataset
setwd(A)
df<- read_dta("dhs_wfs_clean.dta")
df_codes<-read_dta("dhs_country_codes.dta")

#study data 
unique(df$svy_id)
summary(df$svy_id)
str(df$svy_id)
names(df)
tail(df$svy_id)
unique(df$svyid_str)

################################################################################################################

# create country code and phase number separately
df <- df %>%
  separate(svyid_str, into = c("country_code", "phase_number"), sep = "(?<=\\D)(?=\\d)")

unique(df$country_code)
unique(df$phase_number)
df$phase_number<- as.numeric(df$phase_number)
df$phase_number<- replace_na(df$phase_number, 1)


# 
# ##Add additional country codes
# df_codes_na<-data.frame(country_code_str = c("CR", "FJ", "KR", "MY", "PA", "SY"),
#                         CountryName = c("Costa Rica ", "Fiji", "Korea", "Malaysia", "Panama", "Syria"))
# 
# df_codes <- dplyr::bind_rows(df_codes, df_codes_na)
# 
# colnames(df_codes) <- sub("country_code_str","country_code",colnames(df_codes))



# #observations for each country
# df_countries <- df %>% #country summary
#   group_by(svy_id, country_code, phase_number,africa, lac, asia ) %>%
#   summarise(observation = n(),
#             .groups = 'drop')
# 
# colnames(df_codes) <- sub("country_code_str","country_code",colnames(df_codes))
# colnames(df_codes) <- sub("CountryName","country_name",colnames(df_codes))
# 
# df_countries_meta<- df_countries %>%
#   left_join(df_codes, by = "country_code")
# colnames(df_countries_meta)
# 
# 
# df_countries_unique<- df_countries_meta %>% #time period of phases
#   group_by(country_code, country_name, africa, asia, lac)%>%
#   summarise(phases = n(), .groups = 'drop')
# print(df_countries_unique)
# 
# num_rows_africa <- sum(df_countries_unique$africa == 1)
# num_rows_asia <- sum(df_countries_unique$asia == 1)
# num_rows_lac <- sum(df_countries_unique$lac == 1)
# 
# df_phases<- df %>% #time period of phases
#   group_by(phase_number, year)%>%
#   summarise(observations = n(), .groups = 'drop')
# 
# 
# ###
# 
# df_wide <- df_countries_meta %>% 
#   mutate(value = 1) %>% 
#   spread(key = phase_number, value = value, fill = 0)
# 
# print(df_wide)


################################################################################
#Explore the variables 


# Create a function to extract variable names and labels

# get_variable_labels <- function(df) {
#   var_names <- names(df)
#   var_labels <- unlist(sapply(df, label))
#   return(tibble(Variable = var_names, Label = var_labels))
# }
# 
# table <- get_variable_labels(df)

#Compare with actual model data from DHS

# df_model_india<-read_dta("Model_India.dta")
# 
# get_variable_labels_2 <- function(df_model_india) {
#   var_names <- names(df_model_india)
#   var_labels <- unlist(sapply(df_model_india, label))
#   return(tibble(Variable = var_names, Label = var_labels))
# }
# 
# table_model <- get_variable_labels(df_model_india)
# 
# print(table)
# 
# write.csv(table_model,file = "model_variables.csv", row.names = FALSE)

#
# #Identify variable used: years of education 
# 
# unique(df$edyrs)
# summary(df$edyrs)
# tail(df$edyrs, n=15)
# 
# table(df$edyrs)
# 
# unique(df$husb_edyrs)
# summary(df$husb_edyrs)
# table(df$husb_edyrs)
# 
# 
# ##Identify variable used: age
# 
# unique(df$age)
# summary(df$age)
# table(df$age)
# 
# 
# ###Identify variable used: fertility
# 
# unique(df$evborn)
# summary(df$evborn)
# table(df$evborn)
# 
# 
# unique(df$surv)
# summary(df$surv)
# table(df$surv)
# 
# 
# ##Identify control variables 
# 
# unique(df$agemar)
# summary(df$agemar)
# table(df$agemar)
# 
# 
# unique(df$work)
# summary(df$work)
# table(df$work)
# 
# unique(df$husb_occ)
# summary(df$husb_occ)
# table(df$husb_occ)
# 
# unique(df$urban)
# summary(df$urban)
# table(df$urban)
# 
##non DHS data

df_nondhs<- df[df$dhs_data== 0, ]
unique(df_nondhs$country_code)
table(df_nondhs$country_code)

unique(df_nondhs$year)
# 
# unique(df$urban)
# 

################################################################################ 
#Add or amend variables in the original data


## Add life expectancy data 
df_lifeex<-read.csv("Lifeexpectancy_wdi.csv")

df_lifeex <- df_lifeex %>%
  pivot_longer(
    cols = starts_with("X"),  # Columns to pivot into longer format
    names_to = "year",  # New column name for the year
    names_prefix = "X",  # Remove prefix from the year column
    values_to = "lifeex"  # New column name for the life expectancy values
  )

df_lifeex$year <- as.numeric(df_lifeex$year)
colnames(df_lifeex) <- sub("Country.Name","country_name",colnames(df_lifeex))
colnames(df_lifeex) <- sub("Country.Code","country_code",colnames(df_lifeex))

  #lag lifeex
  df_lifeex <- df_lifeex %>%                            # Add lagged column
    group_by(country_code) %>%
    dplyr::mutate(lifeex_tmin1 = dplyr::lag(lifeex, n = 1, default = NA)) %>% 
    as.data.frame()

df_lifeex<- df_lifeex[ , c("country_code", "year", "lifeex_tmin1") ]

df<-merge(df, df_lifeex, by=c("country_code", "year"), all.x = TRUE)
sum(is.na(df$lifeex_tmin1))


################################################################################
##Add GDP per capita data and population from penn world table
df_penn<-read_dta("pwt1001_na_data.dta")
colnames(df_penn)

colnames(df_penn) <- sub("countrycode","penn_country_code",colnames(df_penn))
colnames(df_penn) <- sub("v_gdp","gdp",colnames(df_penn))
colnames(df_penn) <- sub("xr","exrate",colnames(df_penn))

df_penn<- df_penn[ , c("penn_country_code","year","gdp","exrate", "pop")]


df_penn$gdp_usd <- df_penn$gdp/df_penn$exrate
df_penn$gdp_pc<- (df_penn$gdp_usd/df_penn$pop)
attr(df_penn$gdp_pc, "label")<- "GDP per capita in current USD"

length(unique(df_penn$penn_country_code))

# Subset the Penn data frame
penn_country_codes <- c("AFG", "ALB", "AGO", "ARM", "AZE", "BGD", "BEN", "BOL", "BTN", "BRA", "BFA", "BDI",
                        "KHM", "CMR", "CPV", "CAF", "TCD", "COL", "COM", "COG", "COD", "CIV", "DMA", "ECU", 
                        "EGY", "SLV", "GNQ", "ERI", "ETH", "GAB", "GMB", "GHA", "GTM", "GIN", "GUY", "HTI", 
                        "HND", "IND", "IDN", "JOR", "KAZ", "KEN", "KGZ", "LAO", "LSO", "LBR", "MDG", "MWI", 
                        "MDV", "MLI", "MRT", "MEX", "MDA", "MAR", "MOZ", "MMR", "NAM", "NPL", "NIC", "NER", 
                        "NGA", "PAK", "PNG", "PRY", "PER", "PHL", "RWA", "WSM", "STP", "SEN", "SLE", "ZAF", 
                        "LKA", "SDN", "SWZ", "TJK", "TZA", "THA", "TLS", "TGO", "TTO", "TUN", "TUR", "TKM", 
                        "UGA", "UKR", "UZB", "VNM", "YEM", "ZMB", "ZWE", "CRI", "FJI", "KOR", "MYS", "PAN",
                        "SYR" )


df_penn <- df_penn[df_penn$penn_country_code %in% penn_country_codes, ]
length(unique(df_penn$penn_country_code))


#convert the country codes
country_code_map <- c("AF" = "AFG", "AL" = "ALB", "AO" = "AGO", "AM" = "ARM", "AZ" = "AZE", "BD" = "BGD", 
                      "BJ" = "BEN", "BO" = "BOL", "BT" = "BTN", "BR" = "BRA", "BF" = "BFA", "BU" = "BDI", 
                      "KH" = "KHM", "CM" = "CMR", "CV" = "CPV", "CF" = "CAF", "TD" = "TCD", "CO" = "COL", 
                      "KM" = "COM", "CG" = "COG", "CD" = "COD", "CI" = "CIV", "DR" = "DMA", "EC" = "ECU", 
                      "EG" = "EGY", "ES" = "SLV", "EK" = "GNQ", "ER" = "ERI", "ET" = "ETH", "GA" = "GAB", 
                      "GM" = "GMB", "GH" = "GHA", "GU" = "GTM", "GN" = "GIN", "GY" = "GUY", "HT" = "HTI", 
                      "HN" = "HND", "IA" = "IND", "ID" = "IDN", "JO" = "JOR", "KK" = "KAZ", "KE" = "KEN", 
                      "KY" = "KGZ", "LA" = "LAO", "LS" = "LSO", "LB" = "LBR", "MD" = "MDG", "MW" = "MWI", 
                      "MV" = "MDV", "ML" = "MLI", "MR" = "MRT", "MX" = "MEX", "MB" = "MDA", "MA" = "MAR", 
                      "MZ" = "MOZ", "MM" = "MMR", "NM" = "NAM", "NP" = "NPL", "NC" = "NIC", "NI" = "NER", 
                      "NG" = "NGA", "PK" = "PAK", "PG" = "PNG", "PY" = "PRY", "PE" = "PER", "PH" = "PHL", 
                      "RW" = "RWA", "WS" = "WSM", "ST" = "STP", "SN" = "SEN", "SL" = "SLE", "ZA" = "ZAF", 
                      "LK" = "LKA", "SD" = "SDN", "SZ" = "SWZ", "TJ" = "TJK", "TZ" = "TZA", "TH" = "THA", 
                      "TL" = "TLS", "TG" = "TGO", "TT" = "TTO", "TN" = "TUN", "TR" = "TUR", "TM" = "TKM", 
                      "UG" = "UGA", "UA" = "UKR", "UZ" = "UZB", "VN" = "VNM", "YE" = "YEM", "ZM" = "ZMB", 
                      "ZW" = "ZWE", "CR" = "CRI", "FJ" = "FJI", "KR" = "KOR", "MY" = "MYS", "PA" = "PAN", 
                      "SY" = "SYR")



# Create a new map that maps from Penn codes to your codes
penn_to_my_codes <- setNames(names(country_code_map), country_code_map)

# Use the new map to convert the country codes in the subsetted Penn data frame
df_penn$country_code <- penn_to_my_codes[df_penn$penn_country_code]
length(unique(df_penn$country_code))


#remove other columns 
df_penn<-df_penn[ ,c("country_code", "year", "gdp_pc", "pop")]
colnames(df_penn)
summary(df_penn$gdp_pc)



#join the data 
df_1 <- merge(df, df_penn, by = c("country_code", "year"), all.x = TRUE)
colnames(df_1)

sum(is.na(df_1$gdp_pc))
df_1[is.na(df_1$gdp_pc),c("country_code") ]

df<-df_1
colnames(df)



## calculate survival rate 
df$pie<-df$surv/df$evborn

summary(df$pie)



#create original row id
df$ADMIN_ID <- seq.int(nrow(df))

#save as.rda
SAVE(dfx=df)



