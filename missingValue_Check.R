install.packages("mice")
library(mice)

tempData=mice(dataset,m=1,maxit=50,meth="pmm",seed=100)
# axit=maximum iterations, number of imputation
compltedData=complete(tempData,1)
output=dataset
output$completedValues=completedData$'SMI missing values'


# ====Azure Machine Learning Issue Fix===
library(dplyr)
library(datasets)
lmfit=lm(mpg~wt,mtcars)
summary(lmfit)
library(broom)
vardat=tidy(lmfit)
selected=filter(vardat,p.value<0.05) %>% select(term)



