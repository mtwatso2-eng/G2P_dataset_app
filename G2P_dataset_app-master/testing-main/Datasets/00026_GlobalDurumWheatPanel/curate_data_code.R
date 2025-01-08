# Categorical Phenotype

ipheno <- geno_pheno[[24]]$pheno
igeno <- geno_pheno[[24]]$geno

igeno2 <- t(igeno[,colnames(igeno) %in% ipheno[,2]])
igeno2 <- recode_alleles(igeno2, a0 = 'AA', a1 = c('AB', 'BA'), a2 = 'BB')

igeno <- igeno2
ipheno <- data.frame(id = ipheno$FINAL_AccessionCode, pheno = ipheno$MacroAreaCLASSIFICATION)

save_geno_pheno(ipheno, igeno, names(geno_pheno)[24])