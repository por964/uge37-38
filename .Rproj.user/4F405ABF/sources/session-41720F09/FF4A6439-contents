library(httr)
library(jsonlite)
library(rjson)
library(stringi)

#TRIN 1. find url
urlquiz <- "https://api.smk.dk/api/v1/person/search?keys=*&offset=0&rows=2000"
#TRIN 2: GET url-response
quizres <- httr::GET(urlquiz)
#TRIN 3: Filtrer indhold for sig
quizraw <- httr::content(quizres, as="text")
#TRIN 4: Fra json til R-datastruktur
dfquiz <- jsonlite::fromJSON(quizraw)
#TRIN 5: Fra liste til dataframe
df <- dfquiz$items

colnames(df)

df <- df[, c("forename", "surname", "works", "gender")]

find_no_works <- function(vec) {
      retval <- sum(stri_count_regex(vec, '(?=KMS)'))
  return(retval)
}

find_two <- function(vec){
  tempval <- grep("KMS", vec)
  retval <- length(tempval)
  return (retval)
}

df$no_works <- unlist(lapply(df$works, FUN=find_no_works))











