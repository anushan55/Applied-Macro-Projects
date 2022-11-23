#aging and labour migration and, education investments on the macroeconomic performance

#df dataframe
#l list
#var variable

# BASIC STRUCTURE:

#1) DATA PREP
# create base df
#input: 
#output: 

# create separate dfs for each var type
#input: base df
#output: 

# create analysis df and subsamples
#input: combine var type dfs
#output: xx.rda and subsamples

#2) ANALYSIS
#for each sample: sumstats, regs, figures


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

# input <- 'm6practice_varcreation_controls_ex1.R'
# source(paste0(DO,input,sep=""), echo=TRUE, max=1000)

#...

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
# regressions ####
input <- 'project_analysis_regression.R'
source(paste0(DO,input,sep=""), echo=TRUE, max=1000)

#############################################+
# figures ####
#input <- 'm6practice_analysis_figures_ex5.R'
#source(paste0(DO,input,sep=""), echo=TRUE, max=1000)
