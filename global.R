require(shiny)
require(httr)
require(RCurl)
require(jsonlite)
require(bslib)
require(data.table)
require(DT)
require(rclipboard)
require(tidyverse); require(magrittr)
library(stringr) 
library(shinyjs)
library(gert)
source("utils.R")

# clone GitHub repo, excluding .rdata files (since they're too big)
original_dir <- getwd()
repo_url <- "https://github.com/QuantGen/G2P-Datasets.git"  # Replace with actual repo
datasetDir <- "GPDatasets-main"                            # Local folder to clone into
if (dir.exists(datasetDir)) {
  unlink(datasetDir, recursive = TRUE, force = TRUE)
}
# --- Step 1: Sparse clone with no checkout ---
system(sprintf("git clone --filter=blob:none --no-checkout %s %s", repo_url, datasetDir))
setwd(datasetDir)
system("git sparse-checkout init --cone")
sparse_file <- ".git/info/sparse-checkout"
include_all <- "*"
exclude_patterns <- c("!**/*.rdata", "!**/*.RData")
cat(paste(c(include_all, exclude_patterns), collapse = "\n"),
    file = sparse_file, append = FALSE, sep = "\n")
system("git checkout")
setwd(original_dir)

completedDatasets <- datasetDir %>%
  list.files(full.names = TRUE, recursive = TRUE) %>%
  {.[map_lgl(., function(x){grepl("curate_data_code.R", x)})]} %>%
  {.[file.info(.)$size > 1]}

metadata <<- datasetDir %>%
  list.files(full.names = TRUE, recursive = TRUE) %>%
  {.[map_lgl(., function(x){grepl("meta_data.json", x)})]} %>%
  map(., function(x){jsonlite::fromJSON(x)}) %>%
  map(., as.data.frame) %>%
  map(., function(x){x %>% mutate(across(everything(), as.character))}) %>%
  bind_rows() %>%
  rowwise() %>%
  mutate(
    `In Kaggle?` = any(grepl(Folder, completedDatasets)),
    # Kaggle = ifelse(`In Kaggle?`, createLink(paste0("https://www.kaggle.com/datasets/ag2p-disc/", gsub("_", "-", tolower(Folder)))), "")
  ) %>%
  mutate(
    Links = paste(
      sep = "\n",
      ifelse(
        any(grepl(Folder, completedDatasets)),
        createLink("Download", paste0("https://github.com/QuantGen/G2P-Datasets/raw/refs/heads/main/Datasets/", Folder, "/curated_geno_pheno_map.rdata")),
        ""
      ),
      createLink("DOI", DOI),
      ifelse(
        any(grepl(Folder, completedDatasets)),
        createLink("Kaggle", paste0("https://www.kaggle.com/datasets/ag2p-disc/", gsub("_", "-", tolower(Folder)))),
        ""
      )
    )
  ) %>%
  ungroup()

# save(metadata, file = "environment.RData")
# load("environment.RData")

sapply(list.files(path = "modules", recursive = TRUE, pattern = "^.*\\.R$", full.names = TRUE), source)
