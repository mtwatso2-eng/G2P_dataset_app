ipheno <- geno_pheno[[12]]$pheno
igeno <- geno_pheno[[12]]$geno

igeno <- igeno[rownames(igeno) %in% ipheno$ID,]

ipheno <- data.frame(id = ipheno$ID[ipheno$ID %in% rownames(igeno)], 
                     pheno = ipheno$Flight_endurance[ipheno$ID %in% rownames(igeno)])


save_geno_pheno(ipheno, igeno, names(geno_pheno)[12])