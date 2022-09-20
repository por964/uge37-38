library("janitor")
library(tidyverse)
library('DataCombine')
library("dplyr")
library(lubridate)
library(zoo)


df <- read.csv(file = "C:/Dataanalyse/data/fti_as_csv.csv")

colnames(df)[colnames(df) == 'tid'] <- 'date'

#change "tidspkt" column to type Date
df$date <- as.Date(paste(df$date,"-01",sep=""))

#colnames(df)[colnames(df) == 'tid'] <- 'date'

#select 2015-2022 subset
df <- df[df$date >= "1996-01-01", ]
str(df)

df$quarter <- floor_date(df$date, "quarter")

df <- df %>% 
        group_by(date = format(as.yearqtr(date, "%Y-%m-%d"), "%YQ%q")) %>%
        summarise_all(mean)

str(df)
