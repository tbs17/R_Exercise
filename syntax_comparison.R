setwd("C:/Users/tracy.shen/Dropbox (Personal)/Data Tools learning/R exercises")
library(datasets)
data("mtcars")
# you can also just use attach(mtcars) to replace the above two lines

head(mtcars,10)
# ===Dollar sign Syntax: base R style====

# --summary statistics----
mean(mtcars$mpg)
# [1] 20.09062

table(mtcars$cyl)
#  4  6  8 
# 11  7 14

# :::two categorical variables:
table(mtcars$cyl,mtcars$am)
#    0  1
# 4  3  8
# 6  4  3
# 8 12  2

# ::one continuous, one categorical::::
mean(mtcars$mpg[mtcars$cyl==4]) #conditional
#[1] 26.66364


# ---plotting:use base plot-----
hist(mtcars$disp)
barplot(mtcars$disp)
barplot(table(mtcars$cyl))
plot(mtcars$disp,mtcars$mpg)
# warnings()
mosaicplot(table(mtcars$am,mtcars$cyl)) #mosaic on two categorical variables

# ::one continous and one categorical:::
boxplot(mtcars$disp[mtcars$cyl==4])
hist(mtcars$disp[mtcars$cyl==4])


# ---wrangling---
# subsetting:
mtcars[mtcars$mpg>30,]

# making a new variable:
mtcars$efficient[mtcars$mpg>30]=TRUE
mtcars$efficient[mtcars$mpg<30]=FALSE
head(mtcars,10)



# ===========Formula Syntax: used in models, using lattice plotting=====

library(mosaic)

mean(~mpg,data=mtcars) #[1] 20.09062
tally(~cyl,data = mtcars)

#  4  6  8 
# 11  7 14 

tally(cyl~am,data = mtcars)
# #    am
# cyl  0  1
# 4  3  8
# 6  4  3
# 8 12  2

mean(mpg~cyl,data=mtcars)
#        4        6        8 
# 26.66364 19.74286 15.10000

# ----lattice plotting---
library(lattice)
histogram(~disp,data=mtcars)
bwplot(~disp,data = mtcars)
bargraph(~cyl,data = mtcars)
xyplot(mpg~disp,data = mtcars)
# two categorical variables

bargraph(~am,data=mtcars,groups = cyl)
histogram(~disp|cyl,data = mtcars)
bwplot(cyl~disp,data = mtcars)


# =====tidyverse syntax====
mtcars%>% summarize(mean(mpg))
#   mean(mpg)
# 1  20.09062
# one categorical variable:
mtcars%>%group_by(cyl)%>%summarize(n())

# two categorical variablse
mtcars%>%group_by(cyl,am)%>%summarize(n())
# # A tibble: 6 x 3
# # Groups:   cyl [?]
# cyl    am `n()`
# <dbl> <dbl> <int>
#   1     4     0     3
# 2     4     1     8
# 3     6     0     4
# 4     6     1     3
# 5     8     0    12
# 6     8     1     2

# one continuous, one categorical
mtcars%>%group_by(cyl)%>%summarize(mean(mpg))
# # # A tibble: 3 x 2
# cyl `mean(mpg)`
#      <dbl>       <dbl>
# 1     4        26.7
# 2     6        19.7
# 3     8        15.1

# ---ggplot plotting----
# one continous variable
qplot(x=mpg,data = mtcars,geom='histogram')
qplot(y=disp,x=1,data = mtcars,geom='boxplot')

# one categorical variable
qplot(x=cyl,data = mtcars,geom='bar')

# two coninuous variables
qplot(x=disp,y=mpg,data = mtcars,geom = 'point')
# two categorical vairables
qplot(x=factor(cyl),data=mtcars,geom='bar')+facet_grid(.~am)
qplot(x=disp,data = mtcars,geom = 'histogram')+facet_grid(.~cyl)
qplot(y=disp,x=factor(cyl),data = mtcars,geom = 'boxplot')

# ---wrangling---
mtcars%>% filter(mpg>30)
# making a new variable
mtcars=mtcars%>%mutate(efficient=if_else(mpg>30,TRUE,FALSE))

