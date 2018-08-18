# i didn't load stringr because i already loaded in tidyverse which automatically load in all the important dependency packages

fruit=c('apple','banana','pear')

# ====detect matches===
str_detect(fruit,'a') #[1] TRUE TRUE TRUE
str_which(fruit,'a') #find the indexes of strings taht contain a pattern match
# [1] 1 2 3
str_count(fruit,'a') #count the number of matches in the string
# [1] 1 3 1
str_locate(fruit,'a') #locate the positions of pattern matches in the string
# becasue the pattern only contains one letter, that's why the start and end are the same
# #      start end
# [1,]     1   1
# [2,]     2   2
# [3,]     3   3

# ====subset strings===
str_sub(fruit,1,3) #subset a substring starting from position1 to position3
# [1] "app" "ban" "pea"

str_subset(fruit,'b')#returns only the strings that contain the pattern: conditionally extracting
# [1] "banana"

str_extract(fruit,'[aeiou]')#return the first pattern match found in each string
#[1] "a" "a" "e"


# ----------------------

sentences='A STRING'
str_match(sentences,'(a|the)([^ ]+)') #return the first pattern match found in each string, as a matrix with a column for each () groupin pattern
#      [,1] [,2] [,3]
# [1,] NA   NA   NA 


# ====manage length====
str_length(fruit)
# [1] 5 6 4
str_pad(fruit,17)

# [1] "            apple" "           banana" "             pear"

str_trunc(fruit,3) #truncate the width of strings, replacing content with ellipsis
# [1] "..." "..." "..."

str_trim(fruit) #trim whitepace from the start and/or end of a string

# [1] "apple"  "banana" "pear" 


# ===mutate string===
str_sub(fruit,1,3)='str' #substitude string from position1 to position3 on each string
fruit #[1] "strle"  "strana" "strr"  
fruit=c('apple','banana','pear')
str_replace(fruit,'a','-') #replace the first match in each string
# [1] "-pple"  "b-nana" "pe-r" 

str_replace_all(fruit,'a','-')
# > str_replace_all(fruit,'a','-')
# [1] "-pple"  "b-n-n-" "pe-r" 
str_to_lower(sentences) #[1] "a string"
str_to_upper(sentences) #[1] "A STRING"
str_to_title(sentences)#string to title is convert the string to title case
#[1] "A String"

# ====JOIN AND SPLITS====
str_c(letters,LETTERS)#join multiple strings into a single string

#  [1] "aA" "bB" "cC" "dD" "eE" "fF" "gG" "hH" "iI" "jJ" "kK" "lL" "mM" "nN" "oO" "pP" "qQ" "rR" "sS" "tT" "uU" "vV"
# [23] "wW" "xX" "yY" "zZ"

str_c(letters,collapse = NULL) #collapse, it's like unpacked
str_dup(fruit,times = 2)#duplicate the string by 2 times

# [1] "appleapple"   "bananabanana" "pearpear"   

str_split_fixed(fruit,'',n=2)
#      [,1] [,2]   

str_glue('Pi is {pi}')

# Pi is 3.14159265358979

string_glue_data(mtcars,'{rownames(mtcars')

# ===Order Strings====
str_order(x)#returns the vector of indexes hat sorts a character
st_sort(x)

# =====HELPERS=====
str_conv(fruit,'iso-8859-1') #overriding the encoding of  a string. 
# [1] "apple"  "banana" "pear"

# ===JOIN AND SPLTI===========
install.packages('htmlwidgets')
str_view(fruit,'[aeiou]') #string view will output a graph that containst he rults i used 
str_view_all(fruit,'[aeiou]')

str_wrap(sentences,20)
# [1] "A STRING"

