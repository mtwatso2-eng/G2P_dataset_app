# Categorical Phenotype

ipheno <- geno_pheno[[21]]$pheno
igeno <- geno_pheno[[21]]$geno

rownames(igeno) <- sapply(strsplit(rownames(igeno), '_'), function(x) x[2])

ipheno <- data.frame(id = as.character(ipheno$`Individual ID`), pheno = ipheno$Phenotype)

save_geno_pheno(ipheno, igeno, names(geno_pheno)[21])