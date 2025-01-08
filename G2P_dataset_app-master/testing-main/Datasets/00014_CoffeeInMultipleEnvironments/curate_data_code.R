ipheno <- geno_pheno[[6]]$pheno
igeno <- geno_pheno[[6]]$geno

ipheno <- data.frame(id = ipheno$X, pheno = ipheno$production)
rownames(igeno) <- igeno[,1]
igeno <- igeno[,-1]
class(igeno) <- 'numeric'

save_geno_pheno(ipheno, igeno, names(geno_pheno)[6])