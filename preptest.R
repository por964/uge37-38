library("readxl")
library("janitor")
library(tidyverse)

forbr <- read_excel("forbrug.xlsx", col_names = FALSE, skip = 2)

forbr <- t(forbr)

forbr <- forbr[-c(1,2), ]

forbr <- as.data.frame(forbr)
forbr <- row_to_names(forbr, row_number = 1)

str(forbr)

names(forbr)[2] <- 'forbrug'
names(forbr)[1] <- 'kvartal'
forbr$forbrug <- as.integer(forbr$forbrug)

#forbr$tid <- gsub("K","Q",forbr$tid)
# forbr$tid <- gsub("^(.{5})(.*)$",
#                        "\\10\\2",
#                        forbr$tid)
# forbr$tid <- paste0(forbr$tid, "-01")

numrows<-94  #number of elements desired

#create the sequence of Date objects
quarters <-seq(as.Date("1999-01-01"), by="quarter",
               length.out = numrows)

forbr$kvartal <- quarters

vkst_pct <- (exp(diff(log(forbr$forbrug), lag=4))-1)*100

forbr <- forbr[-c(1:4), ]

forbr$vkst_pct <- vkst_pct

#forbrugertillid
fti <- read.csv('fti_quarterly.csv')

fti = fti[-1,]

numrows2<-90

quarters2 <-seq(as.Date("2000-01-01"), by="quarter",
               length.out = numrows2)

names(fti)[names(fti) == 'date'] <- "kvartal"

fti$kvartal <- quarters2

str(forbr)
str(fti)

my_data <- merge(fti, forbr, by="kvartal")





