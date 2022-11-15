############################
# packages and libraries ####

#install.packages("SciViews")
library("SciViews")

#install.packages("AER") #run only once
library(AER)

#install.packages("dplyr")
library(dplyr)  # -------------------- clashes with plyr, thus assign  explitly in code, plyr:: ... 


#install.packages("haven")
library(haven)

#install.packages("ggplot2")
library(ggplot2)

#install.packages("stargazer")
library(stargazer)

############################
# myfunctions ####
source(paste0(ADO,"CLEARCOND.R"), echo=TRUE, max=1000)

source(paste0(ADO,"DEMOFUNCTION.R"), echo=TRUE, max=1000)

source(paste0(ADO,"SAVE.R"), echo=TRUE, max=1000)

source(paste0(ADO,"LOAD.R"), echo=TRUE, max=1000)

#add your user-written functions here ...