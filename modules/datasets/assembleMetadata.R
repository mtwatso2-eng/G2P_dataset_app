assembleMetadata <- function(metadata){

  createLink <- function(val) {
    sprintf(paste0('<a href="', URLdecode(val),'" target="_blank">', val,'</a>'))
  }
  
  metadata %<>%
    select(Title, `N Geno` = N_Geno, `N Markers` = N_markers, `Has Phenotype?` = Phenotype, Tags) %>%
    rowwise() %>%
    mutate(
      `N Geno` = as.integer(`N Geno`),
      `N Markers` = as.integer(`N Markers`),
      #DOI = createLink(DOI)
    ) %>%
    ungroup()
  
  return(metadata)
  
}