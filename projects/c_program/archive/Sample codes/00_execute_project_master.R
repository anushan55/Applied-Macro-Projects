#aging and education investments on the macroeconomic performance of developing and developed countries 

#df dataframe
#l list
#var variable


################################################################################################################+
# INTRO ####

#clear console
cat("\014")

#clear all globals in memory
rm(list = ls()) #needs to go before user-written functions (not libraries) are loaded
sink()

######################+
# non-automatable globals #####

#for master scriptname and extension #####
library(rstudioapi)
MAINNAME <- rstudioapi::getActiveDocumentContext()$path #returns path+name
MAINNAME <- sub(".*/|^[^/]*$", "", MAINNAME)
MAINNAME <- substr(MAINNAME,1,nchar(MAINNAME)-2) #cut off .R


HOME <- "E:/Documents/Applied Macro/Projects/projects/" #here: path to 'projects' dir 
DO <- paste0(HOME,"/project_anushan/c_program/") #here: path to folder with R.code

######################+
# launch set-up scripts #####
input <- 'project_intro_aux.R'
source(paste0(DO,input,sep=""), echo=TRUE, max=1000)
#DEBUG <- T

################################################################################################################+
# MAIN PART ####

#############################################+
# read-in + basic editing of raw data: create base df ####
input <- 'project_databasics.R'
source(paste0(DO,input,sep=""), echo=TRUE, max=1000)


#############################################+
# # variable grouping, selection, creation ####
input <- 'project_varcreation_outcomes.R'
source(paste0(DO,input,sep=""), echo=TRUE, max=1000)

input <- 'project_varcreation_treatments.R'
source(paste0(DO,input,sep=""), echo=TRUE, max=1000)

input <- 'project_varcreation_merge.R'
source(paste0(DO,input,sep=""), echo=TRUE, max=1000)

#############################################+
# main & subsample creation ####
input <- 'project_samplecreation_main.R'
source(paste0(DO,input,sep=""), echo=TRUE, max=1000)

#############################################+
#var distribution checks (inherent and coding quality) ####
input<- 'project_analysis_vardistribution.R'
source(paste0(DO,input,sep=""), echo = TRUE, max=1000)

#############################################+
#main regressions ####
input <- 'project_analysis_regression.R'
source(paste0(DO,input,sep=""), echo=TRUE, max=1000)

#############################################+
#figures ####
input <- 'project_analysis_figures.R'
source(paste0(DO,input,sep=""), echo=TRUE, max=1000)


#predictions based on the regressed model
input <- 'project_analysis_predictions.R'
source(paste0(DO,input,sep=""), echo=TRUE, max=1000)

#figures for the predictions based on the regressed model
input <- 'project_analysis_predictions_figures.R'
source(paste0(DO,input,sep=""), echo=TRUE, max=1000)

#predictions based on the regressed model with constant education 
input <- 'project_analysis_predictions_constantedu.R'
source(paste0(DO,input,sep=""), echo=TRUE, max=1000)

#figures for the predictions with constant education
input <- 'project_analysis_predictions_constantedu_figures.R'
source(paste0(DO,input,sep=""), echo=TRUE, max=1000)
