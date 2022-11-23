install.packages("lfe")
library("lfe")

install.packages("estimatr")
library("estimatr")

#generate variables 
z1<-rnorm(4000)
z2<-rnorm(4000)
u<-rnorm(4000)

x1<-z1+z2+0.2*(u+rnorm(length(z1)))
x2<-z1+0.94*z2-0.3*(u+rnorm(length(z1)))

y=x1+x2+u

#iv estimation
iv_felm<-felm(y~x1+x2|
                z1+z2)
coef(felm.hat)



iv<- iv_robust(y~x1+x2|z1+z2, diagnostics = TRUE)
summary(iv)

#2sls estimation
reg_fs_x1<-lm(x1~z1+z2)
reg_fs_x2<-lm(x2~z1+z2)

summary(reg_fs_x2)

x1_hat<-predict(reg_fs_x1)
x2_hat<-predict(reg_fs_x2)

reg_ols<- lm(y~x1+x2)
reg_ss<- lm(y~x1_hat+x2_hat)

#tests
iv$diagnostic_first_stage_fstatistic




