assembleMetadata <- function(metadata){
  
  metadata %<>%
    rowwise() %>%
    mutate(Dataset = strsplit(Folder, "_")[[1]][2]) %>%
    select(`Short Title` = Dataset, `n Genotypes` = N_Geno, `n Markers` = N_markers, `Has Phenotype?` = Phenotype, Links, Common_Name, Scientific_Name, Title, Abstract) %>%
    mutate(
      `n Genotypes` = as.integer(`n Genotypes`),
      `n Markers` = as.integer(`n Markers`)
    ) %>%
    ungroup()
  
  return(metadata)
  
}
