assembleMetadata <- function(metadata){

  createLink <- function(val) {
    sprintf(paste0('<a href="', URLdecode(val),'" target="_blank">', val,'</a>'))
  }
  
  metadata %<>%
    select(Title, `n Genotypes` = N_Geno, `n Markers` = N_markers, Phenotype, Tags) %>%
    rowwise() %>%
    mutate(
      `n Genotypes` = as.integer(`n Genotypes`),
      `n Markers` = as.integer(`n Markers`),
      #DOI = createLink(DOI)
    ) %>%
    ungroup()
  
  return(metadata)
  
}