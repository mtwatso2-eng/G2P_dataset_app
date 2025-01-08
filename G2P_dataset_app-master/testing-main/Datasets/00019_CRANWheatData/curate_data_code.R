# Just reformat

ipheno <- geno_pheno[[11]]$pheno
igeno <- geno_pheno[[11]]$geno

ipheno2 <- data.frame(id = rownames(ipheno), pheno = ipheno[,1])
rownames(igeno) <- rownames(ipheno)
ipheno <- ipheno2

save_geno_pheno(ipheno, igeno, names(geno_pheno)[11])