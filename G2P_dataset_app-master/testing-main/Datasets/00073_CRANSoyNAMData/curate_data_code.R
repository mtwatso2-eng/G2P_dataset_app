# Get BLUEs

ipheno <- geno_pheno[[10]]$pheno
igeno <- geno_pheno[[10]]$geno

library(lme4)
library(lsmeans)
imod <- lmer(yield ~ strain + (1|environ), data = ipheno)
iblue <- as.data.frame(lsmeans::lsmeans(imod, 'strain'))
ipheno <- data.frame(id = as.character(iblue$strain), pheno = iblue$lsmean)

save_geno_pheno(ipheno, igeno, names(geno_pheno)[10])