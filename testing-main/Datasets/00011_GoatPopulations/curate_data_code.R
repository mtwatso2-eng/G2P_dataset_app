ipheno <- geno_pheno[[25]]$pheno
igeno <- geno_pheno[[25]]$geno

rownames(igeno) <- sapply(strsplit(rownames(igeno), '_'), function(x) paste0(x[2], '_', x[3]))
ipheno <- data.frame(id = ipheno$id, pheno = NA)

save_geno_pheno(ipheno, igeno, names(geno_pheno)[25])