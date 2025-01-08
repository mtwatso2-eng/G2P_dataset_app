ipheno <- geno_pheno[[22]]$pheno
igeno <- geno_pheno[[22]]$geno

igeno2 <- igeno[,-1]
rownames(igeno2) <- igeno[,1]
class(igeno2) <- 'numeric'
igeno <- igeno2
ipheno <- data.frame(id = ipheno$Full_name, pheno = ipheno$PH)

save_geno_pheno(ipheno, igeno, names(geno_pheno)[22])