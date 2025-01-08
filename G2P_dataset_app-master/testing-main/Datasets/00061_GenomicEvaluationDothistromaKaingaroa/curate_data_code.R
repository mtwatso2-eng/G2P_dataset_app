ipheno <- geno_pheno[[17]]$pheno
igeno <- geno_pheno[[17]]$geno

igeno2 <- igeno[,-1]
rownames(igeno2) <- igeno[, 'ID']
colnames(ipheno) <- c('id', 'pheno')
igeno <- igeno2

save_geno_pheno(ipheno, igeno, names(geno_pheno)[17])