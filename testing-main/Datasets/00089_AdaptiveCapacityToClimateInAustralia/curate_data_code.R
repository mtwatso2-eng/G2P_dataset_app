# Creating geno IDs (pheno and geno matched)
ipheno <- geno_pheno[[2]]$pheno
igeno <- geno_pheno[[2]]$geno

rownames(igeno) <- paste0('ID', 1:nrow(igeno))
ipheno <- data.frame(id = rownames(igeno), pheno = ipheno[,1])

save_geno_pheno(ipheno, igeno, names(geno_pheno)[2])