# PROJECT'S FULL NAME

# TARGET (of this R.script): ordered execution of R.script(s) within public file routine
#NO detailed descriptions of data, method, etc. HERE -> done in R.scripts called upon

# CONVENTIONS of file naming, abbreviations:

#R.scripts: 	in general 		-> named like the dataset they produce, i.e., _varcreation_x.R
#PROGRAMS: 	-> CAPITAL LETTERS, automatically called upon by R.script executed

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


######################+
# launch set-up scripts #####
input <- 'c_program/00_execute_m6practice_intro_aux.R'
source(paste0(DO,input,sep=""), echo=TRUE, max=1000)
#DEBUG <- T

################################################################################################################+
# MAIN PART ####

#############################################+
# read-in + basic editing of raw data: create base df ####
input <- '/c_program/m6practice_databasics_ex1.R'
source(paste0(DO,input,sep=""), echo=TRUE, max=1000)


#############################################+
# # variable grouping, selection, creation ####
input <- "m6practice_varcreation_outcomes_ex1.R"
source(paste0(DO,input,sep=""), echo=TRUE, max=1000)

input <- 'm6practice_varcreation_treatments_ex1.R'
source(paste0(DO,input,sep=""), echo=TRUE, max=1000)

# input <- 'm6practice_varcreation_controls_ex1.R'
# source(paste0(DO,input,sep=""), echo=TRUE, max=1000)

#...

input <- 'm6practice_varcreation_merge_ex1.R'
source(paste0(DO,input,sep=""), echo=TRUE, max=1000)

#############################################+
# main & subsample creation ####
input <- 'm6practice_samplecreation_main_ex1.R'
source(paste0(DO,input,sep=""), echo=TRUE, max=1000)


# use the ldply to create sub samples and remove the other variables. 



#############################################+
# var distribution checks (inherent and coding quality) ####
input<- 'm6practice_analysis_vardistribution_ex1.R'
source(paste0(DO,input,sep=""), echo = TRUE, max=1000)

#############################################+
# regressions ####
input < 'm6practice_analysis_regression_ex1.R'
source(paste0(DO,input,sep=""), echo=FALSE, max=1000)

#############################################+
# figures ####
input <- "/c_program/m6practice_analysis_figures_ex1.R"
source(paste0(DO,input,sep=""), echo=FALSE, max=1000)


