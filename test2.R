library("readxl")
library("janitor")
library(tidyverse)
library('DataCombine')
library(lubridate)

forbr <- read_excel("forbrug.xlsx", col_names = FALSE, skip = 2)

forbr <- t(forbr)

forbr <- forbr[-c(1,2), ]

forbr <- as.data.frame(forbr)
forbr <- row_to_names(forbr, row_number = 1)

str(forbr)

names(forbr)[2] <- 'forbrug'
names(forbr)[1] <- 'kvartal'
forbr$forbrug <- as.integer(forbr$forbrug)

numrows<-94  #number of elements desired

#create the sequence of Date objects
quarters <-seq(as.Date("1999-01-01"), by="quarter",
               length.out = numrows)

forbr$kvartal <- quarters

vkst_pct <- (exp(diff(log(forbr$forbrug), lag=4))-1)*100


forbr2 <- change(forbr, Var = 'forbrug',
                  type = 'percent',
                  NewVar = 'PercentChange',
                  slideBy = -4)

forbr2 <- forbr2[-c(1:4), ]

forbr2$vkst_pct <- vkst_pct


