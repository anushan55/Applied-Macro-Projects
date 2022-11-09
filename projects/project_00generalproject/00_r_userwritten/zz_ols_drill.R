# R exercises inspired by Heiss 2020, Ch. 3: ####

############################################+
# impact of education on wage ####
data(wage1, package='wooldridge')

# OLS regression:
WAGEregres <-

# obtain coefficients, predicted values and residuals
b.hat <- coef()
wage.hat <- fitted()
u.hat <- 

# Confirm property (1):
mean(u.hat)

# Confirm property (2):
cor(wage1$educ , )

# Confirm property (3):
mean(wage1$wage)
b.hat[1] + b.hat[2] * mean(wage1$educ)

# Estimate log-level model
lm( )


############################################+
# impact of shareA on voteA ####
data(vote1, package='wooldridge')

# OLS regression (parentheses for immediate output):
VOTEres <- 

# scatter plot with regression line:

# Summary of the regression results
summary()

# Calculate R^2 manually:
var( fitted(VOTEres) ) / var( vote1$voteA )


############################################+
# impact of roe on salary ####
data(ceosal1, package='wooldridge')
attach(ceosal1)

# ingredients to the OLS formulas 
cov()
var()
mean()
mean()

# manual calculation of OLS coefficients 
b1hat <- 
b0hat <- 

# alternatively, run OLS regression and check equality of estimates
CEOregres <-

# "detach" the data frame


# extract variables as vectors:
sal <- ceosal1$salary
roe <- ceosal1$roe

# regression with vectors:
CEOregres <- 

# obtain predicted values and residuals
sal.hat <- fitted()
u.hat <- resid()

# Wooldridge, Table 2.2: 
cbind(roe, sal, sal.hat, u.hat)[1:15,]

# Calculate R^2 in three different ways:
sal <- ceosal1$salary
var(sal.hat) / var(sal)
1 - var() / var(sal)
cor(sal, )^2


# Estimate log-log model
lm( , data=ceosal1 )

# Usual OLS regression:
(reg1 <- )

# Regression without intercept (through origin):
(reg2 <- )

# Regression without slope (on a constant):
(reg3 <- )

# average y:
mean(ceosal1$salary)

# Scatter Plot with all 3 regression lines
plot(ceosal1$roe, ceosal1$salary, ylim=c(0,4000))
abline(reg1, lwd=2, lty=1)
abline(reg2, lwd=2, lty=2)
abline(reg3, lwd=2, lty=3)
legend("topleft",c("full","through origin","const only"),lwd=2,lty=1:3)


############################################+
# Expected Values, Variances, and SE ####
data(meap93, package='wooldridge')

# Estimate the model and save the results as "results"
results <- lm(math10 ~ lnchprg, data=meap93)

# Number of obs.
( n <-  )
# SER:
(SER <- sd(resid()) * sqrt((n-1)/(n-2)) )
# SE of b0hat & b1hat, respectively:
SER / sd(meap93$) / sqrt(n-1) * sqrt(mean(meap93$lnchprg^2))
SER / sd(meap93$lnchprg) / sqrt(n-1)

# Automatic calculations:
summary(results)


############################################+
# Monte Carlo ####

# Set the random seed


# set sample size to 1000
n<-

# set true parameters: betas and sd of u
b0<-1; b1<-0.5; su<-2

# Draw a sample of size n:
x <- rnorm(n,4,1)
u <- rnorm(n,0,su)
y <- b0 + b1*x + u

# estimate parameters by OLS
olsres <- 

# features of the sample for the variance formula:
mean(x^2)
sum((x-mean(x))^2)

# Graph
plot(x, y, col="gray", xlim=c(0,8) )
abline(b0,b1,lwd=2)
abline(olsres,col="gray",lwd=2)
legend("topleft",c("pop. regr. fct.","OLS regr. fct."),
                               lwd=2,col=c("black","gray"))


# Set the random seed
set.seed(SEED)

# set sample size of 1000 and number of simulations to 10000
n<- ; r<-

# set true parameters: betas and sd of u
b0<-1; b1<-0.5; su<-2

# initialize b0hat and b1hat to store results later:
b0hat <- numeric(r)
b1hat <- numeric(r)

# Draw a sample of x, fixed over replications with mean=4 and sd=1
x <- 

# repeat r times:
for(j in 1:r) {
  # Draw a sample of y:
  u <- 
  y <- b0 + b1*x + u
  
  # estimate parameters by OLS and store them in the vectors
  bhat <- coefficients( lm(y~x) )
  b0hat[j] <- bhat["(Intercept)"]
  b1hat[j] <- bhat["x"]
}

# MC estimate of the expected values:
mean(b0hat)
mean(b1hat)

# MC estimate of the variances:
var(b0hat)
var(b1hat)

# Initialize empty plot
plot( , xlim=c(0,8), ylim=c(0,6), xlab="x", ylab="y")
# add OLS regression lines
for (j in 1:10) abline(b0hat[j],b1hat[j],col="gray")
# add population regression line
abline(b0,b1,lwd=2)
# add legend
legend("topleft",c("Population","OLS regressions"),
                           lwd=c(2,1),col=c("black","gray"))

#Violation of SLR 4
# MC estimate of the expected values:
mean(b0hat)
mean(b1hat)

# MC estimate of the variances:
var(b0hat)
var(b1hat)


############################################+
# Set the random seed
set.seed()

# set sample size and number of simulations
n<-1000; r<-10000

# set true parameters: betas and sd of u
b0<-1; b1<-0.5; su<-2

# initialize b0hat and b1hat to store results later:
b0hat <- numeric(r)
b1hat <- numeric(r)

# Draw a sample of x, fixed over replications:
x <- rnorm(n,4,1)

# repeat r times:
for(j in 1:r) {
  # Draw a sample of y:
  varu <- 4/exp(4.5) * exp(x)
  u <- rnorm(n, 0, sqrt(varu) )
  y <- 
  
  # estimate parameters by OLS and store them in the vectors
  bhat <- 
  b0hat[j] <- 
  b1hat[j] <- bhat["x"]
}

# MC estimate of the expected values:
mean(b0hat)
mean(b1hat)

# MC estimate of the variances:
var(b0hat)
var(b1hat)