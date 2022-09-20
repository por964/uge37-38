library(httr)
library(jsonlite)
library(dplyr)

curl <- 'https://api.smk.dk/api/v1/person/search?keys=*&offset=0&rows=999'

smk <- httr::GET(curl)
smk_content <- httr::content(smk, as = 'text')
artists <- jsonlite::fromJSON(smk_content)
df <- artists$items

df <- df[, c('name', 'works')]

str(df)

df$no_works <- lengths(df$works)

df <- df[order(df$no_works),]

easy <- df[c(1:333),]
medium <- df[c(334:666),]
hard <- df[c(667:999),]

View(dfquiz)

str(dfquiz)
