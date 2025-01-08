# Add download instructions in CottonFibreQualityBayesianRegression. Files located in Data folder, need to unzip
# Get BLUEs

ipheno <- geno_pheno[[9]]$pheno
igeno <- geno_pheno[[9]]$geno

library(lme4)
library(lsmeans)
imod <- lmer(LY ~ ID + (1|Year), data = ipheno)
iblue <- as.data.frame(lsmeans::lsmeans(imod, 'ID'))
ipheno <- data.frame(id = as.character(iblue$ID), pheno = iblue$lsmean)

rownames(igeno) <- igeno[,1]
igeno <- igeno[,-1]
class(igeno) <- 'numeric'

save_geno_pheno(ipheno, igeno, names(geno_pheno)[9])