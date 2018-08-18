# ====Anchors====
# ^ :start of the string
# $ :end of the string
# \\b :empty string at either edge of a word
# \\B :NOT the edge of a word
# \\< : Beginning of a word
# \\>: End of a word

# ====Quantifiers===
# *: matches at least 0 times
# +:matches at least 1 times
# ?:matches at most 1 times, optional string
# {n}:matches exactly n times
# {n,}:matches at least n times
# {,n}:matches at most n times
# # {n,m}:matches between n and m times
# 
# # ====Character Classes and Groups=====
# 
# # . : any character except \n
# #  | : Or logic
# []: list permited characters. e.g.[abc]
# [a-z]: specify character ranges
# [^...]: list excluded characters
# (...): grouping, enables back referencing using \\N where N is an integer

# ====Special Metacharacters=====

# \n: new line
# \r: carriage return: move the cursor back n characters and replace with the new characters
# \t: tab
# \v: vertical tab
# \f; form feed

# printf("stackoverflow\rnine")
# ninekoverflow

# printf("stackoverflow\nnine") make a new line for the phrase 'nine'
# stackoverflow
# nine

# \f is form feed, its use has become obsolete but it is used for giving indentation like

# printf("stackoverflow\fnine\fgreat")
# stackoverflow
#              nine
# great

# ======Character Classes====
# [[:digit:]] or \\d     digits, e.g: [0-9]
# \\D                   Non-digits; [^0-9]
# [[:lower:]]           lower case letters; [a-z]
# [[:upper:]]           upper case letters;[A-Z]
# [[:alpha:]]           alphabetic characters; [A-z]
# [[:alnum:]]           alphanumeric characters; [A-z0-9]
# \\w                   word characters including the underscore;[A-z0-9_]
# \\W                   Non-word characters
# [[:xdigit:]] or \\x   hexadecimal digits that are 0 to 9 and A to F, a to f; [0-9A-Fa-f]
# [[:blank:]]           space and tab
# [[:space:]]           space, tab, vertical tab, newline,form feed, carriage return
# \\S                   Not space; [^[:space:]]
# [[:punc:]]            punctuation characters; !"#$%&'()*+,-./:;<=>?@[]^_`{|}~

# [[:graph:]]           graph characters; [[:alnum][:punc:]]
# [[:print:]]           printable characters; [[:alnum][:punc:]\\s]
# [[:cntl:]] or\\c      control characters;\n,\r etc. 

# ====Lookarounds and Conditionals======
# (?=)                  look ahead: (?=yx):position followed by yx
# (?<=)                 look behind: (?<=yx):position following yx
# (?!)                  negative look ahead: NOT followed by pattern
# (?<!)                 negative look behind: NOT following pattern
# ?(if) then            if then condition; use lookaheads, optional character in if-clause
# ?(if)then|else        if-then-else-condition

# ======greedy matching=====
# by default, the asterisk * is greedy, it always matches the longest possible string. it can be used in lazy mode by adding ?: *?
# greedy mode can be turned off using (?U).This switches the syntax, so that (?U) a*? is greedy

# =======functions for pattern matching: detect, locate, extract, replace pattern=======
# ====DETECT patterns====
string=c('Hiphopopotamus','Rhymenoceros', 'time for bottomless lyrics')
pattern='t.m' 
grep(pattern, string) #[1] 1 3
grep(pattern, string, value = TRUE) #[1] "Hiphopopotamus"             "time for bottomless lyrics"
grepl(pattern,string) #grepl is find the logic, so it returns boolean:[1]  TRUE FALSE  TRUE
stringr::str_detect(string,pattern) #works same as above but using stringr package:[1]  TRUE FALSE  TRUE

# =====split a string using a pattern======
strsplit(string, pattern) 
# [[1]]
# [1] "Hiphopopo" "us"       
# 
# [[2]]
# [1] "Rhymenoceros"
# 
# [[3]]
# [1] ""            "e for bot"   "less lyrics"

stringr::str_split(string, pattern) # same as above

# ====locate patterns=====

regexpr(pattern, string)  #find the starting postion and length of first match
# [1] 10 -1  1
# attr(,"match.length")
# [1]  3 -1  3
# attr(,"index.type")
# [1] "chars"
# attr(,"useBytes")
# [1] TRUE
gregexpr(pattern, string) #find the starting postion and length of all matches
# # [[1]]
# [1] 10
# attr(,"match.length")
# [1] 3
# attr(,"index.type")
# [1] "chars"
# attr(,"useBytes")
# [1] TRUE
# 
# [[2]]
# [1] -1
# attr(,"match.length")
# [1] -1
# attr(,"index.type")
# [1] "chars"
# attr(,"useBytes")
# [1] TRUE
# 
# [[3]]
# [1]  1 13
# attr(,"match.length")
# [1] 3 3
# attr(,"index.type")
# [1] "chars"
# attr(,"useBytes")
# [1] TRUE

stringr::str_locate(string, pattern)
#      start end
# [1,]    10  12
# [2,]    NA  NA
# [3,]     1   3
stringr::str_locate_all(string, pattern)
#      start end
# [1,]    10  12
# 
# [[2]]
#        start end
# 
# [[3]]
#        start end
# [1,]     1   3
# [2,]    13  15

# ====extract patterns=====
regmatches(string, regexpr(pattern,string)) #extract the first match of each string element
# [1] "tam" "tim"
regmatches(string, gregexpr(pattern,string))#extract all the matches of each string element
# [[1]]
# [1] "tam"
# 
# [[2]]
# character(0)
# 
# [[3]]
# [1] "tim" "tom"

stringr::str_extract(string, pattern) #extract the first match of each string element
# [1] "tam" NA    "tim"

stringr::str_extract_all(string, pattern)#extract all the matches of each string element
# # [[1]]
# [1] "tam"
# 
# [[2]]
# character(0)
# 
# [[3]]
# [1] "tim" "tom"

stringr::str_match(string,pattern) #extract first match+individual character groups
# #      [,1] 
# [1,] "tam"
# [2,] NA   
# [3,] "tim"

stringr::str_match_all(string, pattern) #extract all match+individual character groups
# # [[1]]
# [,1] 
# [1,] "tam"
# 
# [[2]]
# [,1]
# 
# [[3]]
# [,1] 
# [1,] "tim"
# [2,] "tom"


# ===replace patterns===
replacement='pt'
sub(pattern, replacement,string)#replace the first match
# [1] "Hiphopopoptus"             "Rhymenoceros"              "pte for bottomless lyrics"
gsub(pattern, replacement,string) #replace all the matches
# [1] "Hiphopopoptus"            "Rhymenoceros"             "pte for botptless lyrics"

stringr::str_replace(string, pattern,replacement) #replace the first match
# [1] "Hiphopopoptus"             "Rhymenoceros"              "pte for bottomless lyrics"

stringr::str_replace_all(string, pattern, replacement)
# [1] "Hiphopopoptus"            "Rhymenoceros"             "pte for botptless lyrics"