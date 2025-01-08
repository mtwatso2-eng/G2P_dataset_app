ipheno <- geno_pheno[[18]]$pheno
igeno <- geno_pheno[[18]]$geno

igeno2 <- t(igeno[, colnames(igeno) %in% ipheno$taxa])
colnames(igeno2) <- igeno[,1]
alleles <- do.call(rbind, strsplit(igeno[,2], '/'))
for (i in 1:nrow(igeno)) {
  aNA <- intersect(unique(igeno2[,i]), 'NN')
  a0 <- intersect(unique(igeno2[,i]), paste(rep(alleles[i,1], 2), collapse = ''))
  a1 <- intersect(unique(igeno2[,i]), paste(alleles[i,], collapse = ''))
  a2 <- intersect(unique(igeno2[,i]), paste(rep(alleles[i,2], 2), collapse = ''))
  igeno2[,i] <- recode_alleles(igeno2[,i, drop = F], a0, a1, a2)
}
class(igeno2) <- 'numeric'
igeno <- igeno2
ipheno <- data.frame(id = ipheno$taxa, pheno = ipheno$EarHT)

save_geno_pheno(ipheno, igeno, names(geno_pheno)[18])