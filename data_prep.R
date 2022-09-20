library("readxl")
library("xlsx")
library("janitor")
library(tidyverse)
library('DataCombine')
library("dplyr")
library(lubridate)
library(zoo)


forbrug <- read.xlsx('forbrug_1999_2022.xlsx', header=FALSE, 1)

forbrug[, 1:2] <- list(NULL)

colnames(forbrug) <- c('kvartal', 'forbr')

str(forbrug)

numrows<-94

quarters <-seq(as.Date("1999-01-01"), by="quarter",
               length.out = numrows)

forbrug$date <- quarters

forbrug <- change(forbrug, Var = 'forbr',
                 type = 'proportion',
                 NewVar = 'vkst_pct',
                 slideBy = -4)

forbrug <- forbrug[forbrug$date >= "2000-01-01" & forbrug$date < "2022-07-01", ]

str(forbrug)

forbrug$date <- as.yearqtr(forbrug$date, format = "%Y-%m-%d")

forbrug[, 1] <- list(NULL)

str(forbrug)

#forbrugertillid
fti <- read.csv(file = "C:/Dataanalyse/data/fti_as_csv.csv")

colnames(fti)[colnames(fti) == 'tid'] <- 'date'


fti$date <- as.Date(paste(fti$date,"-01",sep=""))


fti <- fti[fti$date >= "2000-01-01", ]
str(fti)

fti <- fti %>% 
  group_by(date = format(as.yearqtr(date, "%Y-%m-%d"), "%Y Q%q")) %>%
  summarise_all(mean)

str(fti)

fti$date <- as.yearqtr(fti$date)

fti <- fti[fti$date < "2022 Q3", ]

str(forbrug)
str(fti)

fti_forbrug <- merge(fti, forbrug, by="date")

fti_forbrug <- fti_forbrug %>% 
  rename(dk_year_ago = 5, dk_next_year = 6)

str(fti_forbrug)

#save(fti_forbrug,file="fti_forbrug2000_2022.Rdata")
