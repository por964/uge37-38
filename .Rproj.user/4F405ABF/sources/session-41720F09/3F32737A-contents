library(eurostat)
library(httr)
library(dplyr)
library(magrittr)
library(ggplot2)
library(reshape2)

df <- get_eurostat('jvs_q_nace2', time_format = "date")

sapply(df, n_distinct)

df <- df %>%
  filter(s_adj == 'SA')

df <- df %>%
  filter(sizeclas == 'TOTAL')

df <- df %>%
  filter(indic_em == 'JOBOCC')

df <- df[df$geo %in% c('DK', 'HU', 'ES'),]

df <- df %>%
  filter(nace_r2 == 'I')


theme_set(theme_bw())

ggplot(data = df, aes(x = time, y = values, color = geo)) +
  geom_line() +
  labs(title = "Yearly housing prices, index 100 = 2015",
       x = "Year", y = "Index")
