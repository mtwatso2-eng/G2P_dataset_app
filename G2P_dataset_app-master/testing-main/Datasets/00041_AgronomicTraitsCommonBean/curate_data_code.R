# Get BLUE values. Reformat geno
ipheno <- geno_pheno[[3]]$pheno
igeno <- geno_pheno[[3]]$geno

library(lme4)
library(lsmeans)
ipheno1 <- ipheno[ipheno$Management %in% 'Drought',]

imod <- lmer(Yd ~ Line + (1|Trial) + (1|Trial:Block), data = ipheno1)
iblue <- as.data.frame(lsmeans::lsmeans(imod, 'Line'))

ipheno <- data.frame(id = as.character(iblue$Line), pheno = iblue$lsmean)
ipheno <- ipheno[ipheno$id %in% colnames(igeno),]

igeno1 <- igeno[, match(ipheno$id, colnames(igeno))]

igeno1 <- recode_alleles(igeno1, a0 = '0|0', a1 = c('1|0', '0|1'), a2 = '1|1')
igeno <- t(igeno1)

save_geno_pheno(ipheno, igeno, names(geno_pheno)[3])