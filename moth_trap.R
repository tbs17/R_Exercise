setwd("C:/Users/tracy.shen/Dropbox (Personal)/Data Tools learning/R exercises")
moth=fread("moth-trap-experiment.csv",na.strings = "NA",stringsAsFactors = F)


# excercise link: https://www.r-bloggers.com/two-way-anova-in-r-exercises/
# solution link: http://r-exercises.com/2016/10/17/two-way-anova-in-r-solutions/
# q1:
str(moth)
# q2
table(moth$location)
table(moth$`type of lure`)
# q3
setnames(moth,c("number of moths","type of lure"),c("moth_number","lure_type"))
install.packages("psych")
library(psych)
library(ggplot2)
describeBy(moth$moth_number,moth$location)
describeBy(moth$moth_number,moth$lure_type)
# q4:
# solution1:
boxplot(moth_number~location,moth)
boxplot(moth_number~lure_type,moth)

# solution2:
ggplot(moth,aes(x=location,y=moth_number,fill=lure_type))+geom_boxplot()


# q5:check normality
shapiro.test(moth$moth_number)
# find w is not equal to 1, not normaly distributed. only when w=1, normally distributed. 

qqnorm(moth$moth_number);
qqline(moth$moth_number,col=2)
# the graph shows that it's not normal

# q6: check for equal variance
var.test(lm(moth$moth_number~moth$location),lm(moth$moth_number~moth$lure_type))
table(moth$location,moth$lure_type)

library(car)
leveneTest(moth$moth_number~moth$location*moth$lure_type)
# Levene's Test for Homogeneity of Variance (center = median)
# Df F value Pr(>F) group 
# 48   0.6377 0.7875 11
# 
# according to p value(0.8211) can't reject the Null, so there's equal variance.

# find it's not normal distribution as the ratio of variance is not equal to 1

# q7: transform the DV
moth$moth_number=log(moth$moth_number)
shapiro.test(moth$moth_number)
# w is very close to 1, but still one 1, so still not normally distributed

# q8
install.packages("pwr")
library(pwr)
# given that we have 2 factors with 3 and 4 levels each and 5 observations for each level, therefore, df=4*3*(5-1)=48
# we choose a medium effect size is 0.25
pwr.f2.test(u=2,v=48,f2=(0.25*0.25))
#  Multiple regression power calculation 

# u = 2
# v = 48
# f2 = 0.0625
# sig.level = 0.05
# power = 0.3210203

# q9: perform anova

moth_anova=aov(moth$moth_number~moth$location*moth$lure_type)
Anova(moth_anova,type="III")

# below indicates that:
#location has an effect on number of moths
#type of lure does not have an effect on number of moths
#the combined effect of location and type of lure does not have an effect on number of moths
# 

# Anova Table (Type III tests)

# Response: moth$moth_number
# Sum Sq Df F value    Pr(>F)    
# (Intercept)                  1843.20  1 29.1646 2.036e-06 ***
#   moth$location                 899.40  3  4.7437  0.005615 ** 
#   moth$lure_type                 40.13  2  0.3175  0.729476    
# moth$location:moth$lure_type  114.97  6  0.3032  0.932229    
# Residuals                    3033.60 48                      
# ---
#   Signif. codes:  0 ?**?0.001 ?*?0.01 ??0.05 ??0.1 ??1


# q10:check for homogenity of residuals
plot(moth_anova,1)
# the number behind it indicates i just need one chart. 
#homogeneity assumption is not violated but points 47 and 32, 48 are marked as outliers.
#Remember our data still had some non normality