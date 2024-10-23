# Read data code is affecting the colnames of geno, use , check.names = F
ipheno <- geno_pheno[[5]]$pheno
igeno <- geno_pheno[[5]]$geno

library(lme4)
library(lsmeans)
imod <- lmer(TestWt ~ Selection + (1|Location) + (1|Year), data = ipheno)
iblue <- as.data.frame(lsmeans::lsmeans(imod, 'Selection'))
ipheno <- data.frame(id = as.character(iblue$Selection), pheno = iblue$lsmean)

igeno1 <- igeno[, colnames(igeno) %in% ipheno$id]
ipheno <- ipheno[ipheno$id %in% colnames(igeno1),]

# Transpose igeno
igeno1 <- t(igeno1)
igeno <- recode_alleles(igeno1, a0 = ' 1', a1 = ' 0', a2 = '-1')

save_geno_pheno(ipheno, igeno, names(geno_pheno)[5])