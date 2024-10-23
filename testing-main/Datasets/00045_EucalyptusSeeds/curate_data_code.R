ipheno <- geno_pheno[[13]]$pheno
igeno <- geno_pheno[[13]]$geno

igeno2 <- igeno[match(ipheno$TreeID, igeno[,1]), -1]
igeno2 <- recode_alleles(igeno2, a0 = 'AA', a1 = c('AB', 'BA'), a2 = 'BB')
ipheno <- data.frame(id = ipheno$TreeID, pheno = ipheno$Diameter.at.breast.height..mm.)

save_geno_pheno(ipheno, igeno, names(geno_pheno)[13])