# Categorical Phenotype

ipheno <- geno_pheno[[1]]$pheno
igeno <- geno_pheno[[1]]$geno

c1 <- sapply(strsplit(rownames(igeno), '_'), function(x) x[1])
c2 <- sapply(strsplit(rownames(igeno), '_'), function(x) x[2])

m1 <- match(ipheno$id, c1)
m2 <- match(ipheno$id, c2)

m1[is.na(m1)] <- m2[is.na(m1)]

ipheno <- ipheno[m1, c('id', 'pheno')]
rownames(igeno) <- ipheno$id

save_geno_pheno(ipheno, igeno, names(geno_pheno)[1])