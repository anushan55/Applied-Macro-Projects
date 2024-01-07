##The key assumptions in an OLS regression include linearity, independence, homoscedasticity (constant variance), and normality. 
##Here's how you might check these:

###Residuals vs Fitted values plot (for linearity and homoscedasticity): 
plot(model$fitted.values, resid(model),
     xlab = "Fitted values",
     ylab = "Residuals",
     main = "Residuals vs Fitted Values")
abline(h = 0, lty = 2)


## Normal Q-Q plot (for normality): This plot shows if residuals are normally distributed.
qqnorm(resid(model), main = "Normal Q-Q plot")
qqline(resid(model))


#Durbin-Watson Test (for independence of errors): This test checks the autocorrelation of residuals. 
library(lmtest)
dwtest(model)

#The Durbin-Watson statistic ranges from 0 to 4. 
#A value of 2 means that there is no autocorrelation in the sample. 
#Values < 2 suggest positive autocorrelation,and values > 2 suggest negative autocorrelation.



##Variance Inflation Factor (VIF) (for multicollinearity)
library(car)
vif(model)

#Values of VIF that exceed 5 or 10 are often regarded as indicating multicollinearity, 
#but in weaker models, values above 2.5 may be a cause for concern.