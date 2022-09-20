library(eurostat)
library(httr)
library(dplyr)
library(magrittr)
library(ggplot2)
library(reshape2)

df <- get_eurostat('prc_hpi_a', time_format = "num")

sapply(df, n_distinct)

#existing dwellings, new dwellings & total
#Index 100 = 2010 eller 2015
df <- df[df$geo %in% c('DK', 'HU', 'ES'),]

names(df)[3] <- 'country'

str(df)

df <- df %>%
  filter(purchase == 'TOTAL' & unit == 'I15_A_AVG')

theme_set(theme_bw())

ggplot(data = df, aes(x = time, y = values, color = country)) +
  geom_line() +
  labs(title = "Yearly housing prices, index 100 = 2015",
                  x = "Year", y = "Index")
str(df)



#saveRDS(df, file = "eustat_test.Rds")

#data.copy <- readRDS(file = "eustat_test.Rds")
