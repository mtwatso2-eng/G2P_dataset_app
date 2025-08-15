assembleMetadata <- function(metadata){
  
  metadata %<>%
    rowwise() %>%
    mutate(Dataset = strsplit(Folder, "_")[[1]][2]) %>%
    select(Dataset, `N Geno` = N_Geno, `N Markers` = N_markers, `Has Phenotype?` = Phenotype, Links) %>%
    mutate(
      `N Geno` = as.integer(`N Geno`),
      `N Markers` = as.integer(`N Markers`)
    ) %>%
    ungroup()
  
  return(metadata)
  
}