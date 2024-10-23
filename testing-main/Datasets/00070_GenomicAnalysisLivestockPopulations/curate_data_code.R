ipheno <- geno_pheno[[16]]$pheno
igeno <- geno_pheno[[16]]$geno

igeno2 <- igeno[,-1]
rownames(igeno2) <- igeno[,1]
ipheno <- data.frame(id = ipheno$ID, pheno = as.numeric(ipheno$t1))
igeno <- igeno2

save_geno_pheno(ipheno, igeno, names(geno_pheno)[16])