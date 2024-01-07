#Fertility and Education Patterns Across Different Phases of Development

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

###############################
# non-automatable globals #####

#for master scriptname and extension #####
library(rstudioapi)
MAINNAME <- rstudioapi::getActiveDocumentContext()$path #returns path+name
MAINNAME <- sub(".*/|^[^/]*$", "", MAINNAME)
MAINNAME <- substr(MAINNAME,1,nchar(MAINNAME)-2) #cut off .R


HOME <- "C:/Users/anush/OneDrive/Documents/LMU Masters/Thesis/Long run growth and demographics/projects" #here: path to 'projects' dir 
DO <- paste0(HOME,"/project_mthesis/c_program/") #here: path to folder with R.code

######################+
# launch set-up scripts #####
input <- 'project_intro_aux.R'
source(paste0(DO,input,sep=""), echo=TRUE, max=1000)
#DEBUG <- T

################################################################################################################+
# MAIN PART ####

#############################################+
# read-in + basic editing of raw data: create base df 
input <- 'project_databasics.R'
source(paste0(DO,input,sep=""), echo=TRUE, max=1000)


#############################################+
# # variable grouping, selection, creation ####
input <- 'project_varcreation_outcomes.R'
source(paste0(DO,input,sep=""), echo=TRUE, max=1000)

input <- 'project_varcreation_treatments.R'
source(paste0(DO,input,sep=""), echo=TRUE, max=1000)

input <- 'project_varcreation_controls.R'
source(paste0(DO,input,sep=""), echo=TRUE, max=1000)

input <- 'project_varcreation_merge.R'
source(paste0(DO,input,sep=""), echo=TRUE, max=1000)


#############################################+
# main & subsample creation ####
input <- 'project_samplecreation_main.R'
source(paste0(DO,input,sep=""), echo=TRUE, max=1000)

input <- 'project_samplecreation_controls.R'
source(paste0(DO,input,sep=""), echo=TRUE, max=1000)

input <- 'project_samplecreation_main_phase6.R'
source(paste0(DO,input,sep=""), echo=TRUE, max=1000)

input <- 'project_samplecreation_controls_phase6.R'
source(paste0(DO,input,sep=""), echo=TRUE, max=1000)

input <- 'project_samplecreation_main_noindia.R'
source(paste0(DO,input,sep=""), echo=TRUE, max=1000)

input <- 'project_samplecreation_main_indo.R'
source(paste0(DO,input,sep=""), echo=TRUE, max=1000)


###########################################################
#var distribution checks (inherent and coding quality) ####
input<- 'project_analysis_vardistribution_main.R'
source(paste0(DO,input,sep=""), echo = TRUE, max=1000)

input<- 'project_analysis_vardistribution_controls.R'
source(paste0(DO,input,sep=""), echo = TRUE, max=1000)


##########################################################
input<- 'project_analysis_regression.R'
source(paste0(DO,input,sep=""), echo = TRUE, max=1000)









