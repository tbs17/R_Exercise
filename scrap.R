# ====scrap/practice script====
df <- data.frame(letters = LETTERS[1:5], numbers = 1:5, stringsAsFactors=FALSE)
df
new=t(df)
with(new,paste())
paste(df$letters[1], df$numbers, sep="")

paste(df$letters, df$numbers, sep="")


install.packages("tidyverse")
library(tidyverse)
new.df<-df%>%
  unite(together, letters, sep="")
new.df

df[, 1] <- as.character(df[, 1])
paste(df[1,], collapse = "")
paste(1:12,sep="|")
nth <- paste0(1:12, c("st", "nd", "rd", rep("th", 9)))
nth
nth <- paste0(1:12,rep("|",12))
nth



starting_df <- data.frame(row.names= c(LETTERS[1:4]),
                          a = c(1:4),
                          b = seq(0.02,0.08,by=0.02),
                          c = c("Aaaa","Bbbb","Cccc","Dddd")
)
starting_df
new=t(starting_df)
new


#===below is the code to combine row items together into one string using paste(collapse)

partner=fread("partner1.csv",header = T,stringsAsFactors = F)
library(data.table)
library(dplyr)
str(partner)
setnames(partner,"Date Posted","Date_Posted")
# partner0=filter(partner,Date_Posted>"1/1/2017" & Date_Posted<"5/22/2017")
new=separate(partner, Link,into=c("a","blank","domain","lan","cat","cat1","title","code"), sep="/",extra = "drop")
string=paste(new$title, collapse = '|')
string
write.csv(string,"string.csv",row.names = F)


# ==web scraping google play store data===

library(rvest)
library(stringr)
library(tidyr)
url="https://play.google.com/apps/publish/?dev_acc=01054780235736981619#AcquisitionPerformancePlace:p=com.accuweather.android&apb=TRACKED_CHANNELS&apcs=2017-05-01&apce=2017-05-31&ts=FIFTEEN_DAYS&apsi=mobileADC+/+Samsung_Y1"
