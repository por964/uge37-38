library("ggpubr")
library(ggplot2)
library(corrplot)
library(RColorBrewer)

load("fti_forbrug2.Rdata")

str(fti_forbrug)

#Q1 2000 - Q2 2021
fti_forbrug <- fti_forbrug[-c(87:90), ]

cor.fti.forbrug <- cor(fti_forbrug$forbr, fti_forbrug$fti)

summary(lm(formula = fti_forbrug$forbr ~ fti_forbrug$fti))

lmm.forbrug.ftillid.ftillid <- lm(fti_forbrug$forbr ~ fti_forbrug$fam_year_ago
                                  + fti_forbrug$fam_next_year + 
                                    fti_forbrug$dk_year_ago + 
                                    fti_forbrug$dk_next_year +
                                    fti_forbrug$goods, data = fti_forbrug)

summary(lmm.forbrug.ftillid.ftillid)


coef <- summary(lmm.forbrug.ftillid.ftillid)$coef

summary(fti_forbrug$pct_forbrug - lmm.forbrug.ftillid.ftillid$fitted.values)





#correlation plot
res <- cor(fti_forbrug)
round(res, 2)
res2 <- rcorr(as.matrix(fti_forbrug))


col <- colorRampPalette(c("#BB4444", "#EE9988", "#FFFFFF", "#77AADD", "#4477AA"))
corrplot(res, method="color", col=col(200),  
         type="upper", order="hclust", 
         addCoef.col = "black", # Add coefficient of correlation
         tl.col="black", tl.srt=45, #Text label color and rotation
         # Combine with significance
         p.mat = res2$P, sig.level = 0.01, insig = "blank", 
         # hide correlation coefficient on the principal diagonal
         diag=TRUE)

vars2 <- c('fti', 'fam_year_ago', 'fam_next_year', 'dk_year_ago','dk_next_year',
           'goods')

cor_results <- lapply(vars2, function(col){
  cor_formula <- as.formula(paste0("vkst_pct ~ ", col))
  cor(cor_formula, data = fti_forbrug)
})

cor_results <- setNames(cor_results, vars2)
lapply(cor_results, function(x) summary(x)$r)