ipheno <- geno_pheno[[23]]$pheno
igeno <- geno_pheno[[23]]$geno

igeno2 <- t(igeno[, colnames(igeno) %in% ipheno$GID])
alleles <- do.call(rbind, strsplit(igeno[,3], ':|>'))[,-1]
for (i in 1:nrow(igeno)) {
  a0 <- intersect(unique(igeno2[,i]), paste(rep(alleles[i,1], 2), collapse = ''))
  a1 <- intersect(unique(igeno2[,i]), paste(alleles[i,], collapse = ''))
  a2 <- intersect(unique(igeno2[,i]), paste(rep(alleles[i,2], 2), collapse = ''))
  igeno2[,i] <- recode_alleles(igeno2[,i, drop = F], a0, a1, a2)
}
class(igeno2) <- 'numeric'
igeno <- igeno2

ipheno <- data.frame(id = ipheno$GID, pheno = ipheno$FL)

save_geno_pheno(ipheno, igeno, names(geno_pheno)[23])