*stata excercise

*Part 1: Prep
*set up do-file
clear all 
set more off
cd "H:\"
cap log close
log using "exercise.txt", replace text 

*use command to open datasets 
use "H:\data-exercise-height.dta ", clear

*Part 2: Describe data
describe 
list
browse

help describe

summarize
tabulate part

scatter earnings height


*Part 3 data manipulation

generate heightm=height/100

generate male=gender
replace male=1-male

save "H:\data-exercise-height.dta ", replace

drop male heightm

list in 10

sort height

bysort gender:sum earnings

*Part 4 regression

reg earnings gender

reg earning height

predict yhat, xb

graph twoway (scatter earnings height) (line yhat height)

scatter earnings gender


*practice

summarize earnings

tab gender part 


list height in 1/5


generate above=1 if earnings > 1643.589
replace above=0 if earnings <=  1643.589
 *or 
generate 
replace above=(earnings> 1643.589)


reg earnings height gender part edu

generate one=1
replace three=2 if height>=179

list one three











