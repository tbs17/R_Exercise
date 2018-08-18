S=100#initial investment
i1=0.2#annual simple interest
i2=0.015#annual compound interest
n=2#years
simple=S*(1+i1*n)
compound=S*(1+i2)^n

ifelse(simple>compound,1,0)
ifelse(simple==120,1,0)
ifelse(compound==120,1,0)

# answer
simple>compound
simple>=120|compound>=120
simple>=120&compound>=120


S=c(100,96)
simple=S*(1+i1*n)
ifelse(simple<=compound,1,0)

# answer

simple<=compound

identical(simple,compound)
identical(simple,120)

compound %/% 20
# return the integer part of the division
compound %% 20
#return the remainder of the division

rational=1/3
decimal=0.33
rational!=decimal
rational==decimal
isTRUE(rational==decimal)
identical(rational,decimal)

# answer
1/3==0.333333333333

install.packages("ggvis")
library(ggvis)
?ggvis
?rCharts
library(rCharts)

install.packages("FastR")
# performance improving packages: renjin, pqR,FastR all available in version 3.2.4

install.packages("tidytext")
library(tidytext)
?tidytext
version
