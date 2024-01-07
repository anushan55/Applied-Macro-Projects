install.packages("survey")
library(survey)

#create a survey design object that includes your sampling weights:
df_design <- svydesign(ids = ~1, data = df, weights = ~weight)


#Complex Survey Designs: If your survey data has a more complex design (e.g., stratification or clustering), you'll need to specify these in your survey design object:
dhs_design <- svydesign(ids = ~ClusterVariable, 
                        strata = ~StrataVariable, 
                        data = YourDataFrame, 
                        weights = ~YourWeightVariable)


#You can then use the svytotal, svymean, svyvar, etc. functions to produce weighted summary statistics


#Weighted Regression Analysis:
weighted_lm <- lm(YourOutcome ~ YourPredictors, data = YourDataFrame, weights = YourWeightVariable)


#be aware that using lm() with the weights argument assumes that the weights are known and fixed, which isn't the case with survey data. 
#So, it's typically better to use the survey package's svyglm() function for regression analysis:
weighted_glm <- svyglm(YourOutcome ~ YourPredictors, design = dhs_design)


