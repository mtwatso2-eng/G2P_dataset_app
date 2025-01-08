ipheno <- geno_pheno[[14]]$pheno
igeno <- geno_pheno[[14]]$geno

igeno2 <- igeno[match(ipheno$HybID, igeno[,1]), -(1:2)]

igeno3 <- list()
for (i in which(1:ncol(igeno2) %% 2 == 1)) 
  igeno3[[length(igeno3) + 1]] <- paste0(igeno2[,i], igeno2[,i+1])
igeno3 <- do.call(cbind, igeno3)

for (i in 1:ncol(igeno3)) {
  icol <- igeno3[,i]
  iunique <- unique(icol)
  alleles <- unique(unlist(strsplit(iunique, '')))
  alleles <- alleles[!alleles %in% c('0', '-', '9')]
  if (length(alleles) > 1) {
    a0 <- paste(rep(alleles[1], 2), collapse = '')
    a1 <- paste(alleles, collapse = '')
    a2 <- paste(rep(alleles[2], 2), collapse = '')
    igeno3[,i] <- recode_alleles(igeno3[,i, drop = F], a0, a1, a2)
  } else {
    igeno3[,i] <- NA
  }
}
class(igeno3) <- 'numeric'

ipheno <- data.frame(id = ipheno$HybID, pheno = ipheno$`Plant height`)
rownames(igeno3) <- igeno[,1]
igeno <- igeno3
save_geno_pheno(ipheno, igeno, names(geno_pheno)[14])