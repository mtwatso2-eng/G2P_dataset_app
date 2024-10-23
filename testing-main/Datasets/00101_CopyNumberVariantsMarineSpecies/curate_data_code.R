#  The phenotype is gen expression

ipheno <- geno_pheno[[8]]$pheno
igeno <- geno_pheno[[8]]$geno

ipheno <- data.frame(id = ipheno[,1], pheno = ipheno[,943])
ipheno$id <- gsub('.', '-', ipheno$id, fixed = T)

igeno <- t(igeno[,-1])
igeno2 <- apply(igeno, 2, function(x) sapply(strsplit(x, ':'), function(w) w[1]))
igeno <- recode_alleles(igeno2, a0 = '0/0', a1 = c('1/0', '0/1'), a2 = '1/1')
igeno <- igeno[rownames(igeno) %in% ipheno$id,]
ipheno <- ipheno[ipheno$id %in% rownames(igeno),]

save_geno_pheno(ipheno, igeno, names(geno_pheno)[8])