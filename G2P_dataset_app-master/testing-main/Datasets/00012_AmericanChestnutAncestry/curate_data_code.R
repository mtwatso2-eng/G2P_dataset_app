# Phenotype comes from another file. Get BLUE values
ipheno <- read.csv('C:/Users/fmagu/OneDrive/projects/GPDatasets/datasets/AmericanChestnutAncestry/B3F3_progeny_tests_2011-2016_edited.csv')
igeno <- geno_pheno[[4]]$geno

library(lme4)
library(lsmeans)
imod <- lmer(ep155_severity ~ B3F2mother + (1|Farm) + (1|Farm:Big_Block) + (1|Farm:Big_Block:Little_Block), data = ipheno)
iblue <- as.data.frame(lsmeans::lsmeans(imod, 'B3F2mother'))
ipheno <- data.frame(id = as.character(iblue$B3F2mother), pheno = iblue$lsmean)

rgeno <- gsub('BAMs/', '', rownames(igeno), fixed = T)
rgeno <- gsub('.bam', '', rgeno, fixed = T)
rownames(igeno) <- rgeno

igeno1 <- igeno[rownames(igeno) %in% ipheno$id,]
ipheno <- ipheno[ipheno$id %in% rownames(igeno),]

igeno1 <- recode_alleles(igeno1, a0 = '0/0', a1 = c('1/0', '0/1'), a2 = '1/1')

igeno <- igeno1[match(ipheno$id, rownames(igeno1)),]

save_geno_pheno(ipheno, igeno, names(geno_pheno)[4])