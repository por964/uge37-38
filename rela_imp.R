library(dplyr)
library(explore)
library(datasets)
library("ggpubr")
require(relaimpo)

#install.packages("relaimpo")

df <- read.csv(file = "fti_forbrug2000_2022.csv")

colnames(df)

fit <- lm(vkst_pct ~ fam_year_ago + fam_next_year + dk_year_ago +
            dk_next_year + goods, data = df)

summary(fit)

coefficients(fit)

mm <- calc.relimp(fit, type = 'lmg')
mm

calc.relimp(fit, type = c("lmg"), rela = TRUE)
