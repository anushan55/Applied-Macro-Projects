*Part 1: Prep
*set up do-file
clear all 
set more off
cd "E:\Documents\Applied Macro\Projects\projects\project_00generalproject\00_stata_utilities\M6"
cap log close
log using "ps_atkin.txt", replace text 


*use command to open datasets 
use "E:\Documents\Applied Macro\Projects\projects\project_00generalproject\00_stata_utilities\M6\atkin_data.dta ", clear


summarize id

codebook id


codebook id , if treatment==1

list id if treatment==1

tab id if treatment==1


70*360



