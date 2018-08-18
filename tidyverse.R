# tidyverse is a powerful collection of R packages that are actually data tools for transforming and visualizing data
# the core packages are: ggplot2, dplyr, tydyr, readr(fast and friendly way to read rectangular data), purr (provides tools to work with functions and vectors), tible( a re-imaging of the data frame), stringr, forcats(provide tools that solve problems with factors)

install.packages('tidyverse')

library(tidyverse)
# there are many dependency packages won't get loaded as you load library(tidyverse), you will have to load them independently. 
# ===useful functions===

tidyverse_conflicts()
# x dplyr::filter() masks stats::filter()
# x dplyr::lag()    masks stats::lag()

tidyverse_deps()
# # A tibble: 25 x 4
# package cran  local behind
# <chr>   <chr> <chr> <lgl> 
#   1 broom   0.5.0 0.5.0 FALSE 
# 2 cli     1.0.0 1.0.0 FALSE 
# 3 crayon  1.3.4 1.3.4 FALSE 
# 4 dbplyr  1.2.2 1.2.2 FALSE 
# 5 dplyr   0.7.6 0.7.6 FALSE 
# 6 forcats 0.3.0 0.3.0 FALSE 
# 7 ggplot2 3.0.0 3.0.0 FALSE 
# 8 haven   1.1.2 1.1.2 FALSE 
# 9 hms     0.4.2 0.4.2 FALSE 
# 10 httr    1.3.1 1.3.1 FALSE 

tidyverse_logo()

tidyverse_update()

# ===load in the data====
library(datasets)

install.packages('gapminder')
library(gapminder)
attach(iris)#attach iris data into R search path

# =====dplyr====
# filter allows you to select a subset of rows in a dataframe


# below select iris data of species virginica

iris %>%
  filter(Species=='virginica')

iris %>%
   filter(Species=='virginica', Sepal.Length>6)

iris %>%
   arrange(Sepal.Length)

iris %>%
  arrange(desc(Sepal.Length))

# combine multiple dplyr verbs in a row with the pipe operator %>%
iris %>%
    filter(Species=='virginica') %>%
    arrange(desc(Sepal.Length))

# ---mutate functions---
iris %>%
   mutate( Sepal.Length=Sepal.Length*10) #change sepal.length to be in millimeters

iris %>%
    mutate(SLMm=Sepal.Length*10) #CREATE a new column name
#  combine the verb, filter, arrange and mutate
iris %>%
  filter(Species=='virginica') %>%
  mutate(SLMm=Sepal.Length*10)  %>%
  arrange(desc(SLMm))

# ---summarize function-----


iris %>%
   summarize(medianSL=median(Sepal.Length)) #summarize to find the median.

iris %>%
  filter(Species=='virginica') %>%
  summarize(medianSL=median(Sepal.Length))

# you can also summarize multiple variables at once
iris %>%
  filter(Species=='virginica') %>%
  summarize(medianSL=median(Sepal.Length),maxSL=max(Sepal.Length))

#   medianSL maxSL
# 1      6.5   7.9

# ---groupby function---

# groupby allows you to summarize within groups instead of summarizing the entire dataset

iris %>%
   group_by(Species) %>%
   summarize(medianSL=median(Sepal.Length),maxSL=max(Sepal.Length))

#  Species    medianSL maxSL
# <fct>         <dbl> <dbl>
#   1 setosa          5     5.8
# 2 versicolor      5.9   7  
# # 3 virginica       6.5   7.9

iris %>%
  filter(Sepal.Length>6) %>%
  group_by(Species) %>%
  summarize(medianSL=median(Sepal.Length),maxSL=max(Sepal.Length))

# # A tibble: 2 x 3
# Species    medianSL maxSL
# # <fct>         <dbl> <dbl>
  # 1 versicolor      6.4   7  
# 2 virginica       6.7   7.9

# ------ggplot2----
# ggplot2 allows you to compare two variables within your data. 

iris_small=iris %>%
  filter(Sepal.Length>5)

ggplot(iris_small,aes(x=Petal.Length,y=Petal.Width))+geom_point()


# ::additional aesthetics::

#  different colors by species

ggplot(iris_small,aes(x=Petal.Length,y=Petal.Width,color=Species))+geom_point()

# size by length, the longer the length, the bigger the size

ggplot(iris_small,aes(x=Petal.Length,y=Petal.Width,color=Species,size=Sepal.Length))+geom_point()

# ::faceting::

# creating graphs by each species
ggplot(iris_small,aes(x=Petal.Length,y=Petal.Width))+geom_point()+facet_wrap(~Species)

# ---line plots using geom_line()---
by_year=gapminder %>%
  group_by(year) %>%
  summarize(medianGdpPerCap=median(gdpPercap))
by_year

#     year medianGdpPerCap
# <int>           <dbl>
#   1  1952           1969.
# 2  1957           2173.
# 3  1962           2335.
# 4  1967           2678.
# 5  1972           3339.
# 6  1977           3799.
# 7  1982           4216.
# 8  1987           4280.
# 9  1992           4386.
# 10  1997           4782.
# 11  2002           5320.
# 12  2007           6124.

ggplot(by_year, aes(x=year,y=medianGdpPerCap))+geom_line()+expand_limits(y=0)

# ---bar plots using geom_col---
by_species=iris %>%
  filter(Sepal.Length>6) %>%
  group_by(Species) %>%
  summarize(medianPL=median(Petal.Length))

ggplot(by_species,aes(x=Species,y=medianPL))+geom_col()

# ----histogram---
ggplot(iris_small,aes(x=Petal.Length))+geom_histogram()

# ---boxplot----
ggplot(iris_small,aes(x=Species,y=Sepal.Width))+geom_boxplot()
