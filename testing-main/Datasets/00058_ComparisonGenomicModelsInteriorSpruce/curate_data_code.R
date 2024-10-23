# match geno with pheno

ipheno <- geno_pheno[[7]]$pheno
igeno <- geno_pheno[[7]]$geno

ipheno <- ipheno[ipheno$ID %in% igeno[,1],]
ipheno <- data.frame(id = ipheno$ID, pheno = ipheno$HT40)

igeno <- igeno[,-1]
class(igeno) <- 'numeric'

save_geno_pheno(ipheno, igeno, names(geno_pheno)[7])