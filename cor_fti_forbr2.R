library(dplyr)
library(explore)
library(datasets)
library("ggpubr")

load("fti_forbrug2.Rdata")

df2 <- fti_forbrug

cor.forbr.fti <- cor(df2$vkst_pct, df2$fti)

ggscatter(df2, x = "vkst_pct", y = "fti", 
          add = "reg.line", conf.int = TRUE, 
          cor.coef = TRUE, cor.method = "pearson",
          xlab = "Forbrug y-on-y vækst", ylab = "FTI")

cor.forbr.fti

vars2 <- c('fti', 'fam_year_ago', 'fam_next_year', 'dk_year_ago','dk_next_year',
          'goods')

# cor_results <- lapply(vars2, function(col){
#   cor_formula <- as.formula(paste0("vkst_pct ~ ", col))
#   cor(cor_formula, data = fti_forbrug)
# })
# 
# cor_results <- setNames(cor_results, vars2)
# lapply(cor_results, function(x) summary(x)$r)

my_cor <- data.frame(cor(df2[2:9]))
my_cor
lm.forbr.fti <- lm(vkst_pct ~ fti, data = df2)

summary(lm.forbr.fti)
