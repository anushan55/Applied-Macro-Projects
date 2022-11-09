*Load the data 
 use "C:\Users\ra75kuv\Documents\projects\project_m6practice\a_microdata\hjones.dta"
 
 * Description of the data 
desc
sum
hist hjschool
kdensity hjlogyl
 
 
* Regression of the variables 
regress  hjlogyl hjschool


cd 
pwd

count hjlogyl













