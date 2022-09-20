library(dplyr)
library(explore)
library(datasets)
library("ggpubr")
library(relaimpo)

load("fti_forbrug2000_2022.Rdata")

df3 <- fti_forbrug

colnames(df3)

fit <- lm(vkst_pct ~ fam_year_ago + fam_next_year + dk_year_ago +
            dk_next_year + goods, data = df3)

predict(fit)

summary(fit)

coefficients(fit)

confint(fit, level=0.95)

fitted(fit)

anova(fit)

vcov(fit)
