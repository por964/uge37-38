library("ggpubr")
library(psych)

load("fti_forbrug2.Rdata")

df <- fti_forbrug
str(df)

#"pearson", "kendall", "spearman"
my_cor <- cor.test(df$vkst_pct, df$fti, method = 'spearman')
my_cor

cor_res <- data.frame(cor(df[, c('fti', 'fam_year_ago', 'fam_next_year', 'dk_year_ago',
                      'dk_next_year', 'goods', 'forbr', 'vkst_pct')]))

# lm_forbr_fti <- data.frame(lm(df$vkst_pct ~ c(df$fti, df$fam_year_ago,
#                                               df$fam_next_year,df$dk_year_ago,
#                                               df$dk_next_year, df$goods,df$forbr)))

# vars <- c('fti', 'fam_year_ago', 'fam_next_year', 'dk_year_ago',
#           'dk_next_year', 'goods')

vars <- c('fti', 'fam_year_ago', 'fam_next_year', 'dk_year_ago','dk_next_year',
          'goods')

lm_results <- lapply(vars, function(col){
  lm_formula <- as.formula(paste0("vkst_pct ~ ", col))
  lm(lm_formula, data = df)
})

lm_results <- setNames(lm_results, vars)
lapply(lm_results, function(x) summary(x)$r.squared)

pairs.panels(df)
