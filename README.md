# GPDatasets

The G2P-Datasets web app is a platform for accessing the >100 public genome-to-phenome datasets for plants and animals in the GPDatasets repo at https://github.com/QuantGen/GPDatasets.

The app can be accessed at:
https://mtwatson.shinyapps.io/G2P-datasets/

# Accessing datasets and analyses
To browse datasets, go to the "Datasets" module of the web app (the default module) and search the dataset's metadata (species, type of study, etc.) in the search box. Additional metadata fields (n Genotypes, n Markers, etc.) can be used as filters individually in the search table. Click on a dataset in the table to view a summary of the dataset. Below the dataset summary, the user can also access code to load the dataset from an external database (GPDatasets links to datasets in situ and does not store datasets itself), format the data to a standard format for analysis, and perform genomic prediction on the data using a range of provided models.

# Contributing a dataset
To contribute a dataset to the repository, first make sure it's not already in the repository (see Accessing datasets and analyses). If it isn't already present, go to the "Add dataset" module of the web app and fill in all the required fields about the dataset's metadata and code to load and format the data. The app will then package the provided metadata and code into a standard format which can be pushed to the repo as-is. Download the packaged dataset .zip file, unzip it, and push the resulting folder formatted metadata to https://github.com/QuantGen/GPDatasets using the provided instructions.
