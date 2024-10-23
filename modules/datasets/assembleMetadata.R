assembleMetadata <- function(metadata){
  
  addSoftHyphens <- function(val) {
    gsub("([a-zA-Z0-9])", "\\1&shy;", val)
  }

  createLink <- function(val) {
    sprintf(paste0('<a href="', URLdecode(val),'" target="_blank">', val,'</a>'))
  }
  
  metadata %<>%
    select(Folder, Title, `n Genotypes` = N_Geno, `n Markers` = N_markers, Tags) %>%
    rowwise() %>%
    mutate(
      Folder = addSoftHyphens(Folder),
      `n Genotypes` = as.integer(`n Genotypes`),
      `n Markers` = as.integer(`n Markers`),
      #DOI = createLink(DOI)
    ) %>%
    ungroup()
  
  return(metadata)
  
}