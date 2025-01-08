ipheno <- geno_pheno[[15]]$pheno
igeno <- geno_pheno[[15]]$geno

igeno2 <- t(igeno[,-(1:4)])
igeno2 <- igeno2[which(1:nrow(igeno2) %% 2 == 1),]
rownames(igeno2) <- ipheno$id
class(igeno2) <- 'numeric'
ipheno <- data.frame(id = ipheno$id, pheno = ipheno$Average)
igeno <- igeno2

save_geno_pheno(ipheno, igeno, names(geno_pheno)[15])