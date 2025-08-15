source("global.R")
source("RSFunctions.R")

ui <- navbarPage(id = "tabs", collapsible = TRUE, title = "G2P Datasets",
  modulePanel("Browse datasets", value = "datasets"),
  modulePanel("Add dataset", value = "addDataset"),
  modulePanel("About the project", value = "about"),
  reloadWarning,
  tags$head(tags$link(rel="shortcut icon", href="https://storage.googleapis.com/kaggle-organizations/4421/thumbnail.png?t=2025-01-17-04-03-19"))
)
  
server <- function(input, output, session) {
  
  sapply(list.files(path = "modules"), function(module){
    get(module)$server(input, output, session)
  })
  
}

shinyApp(ui = ui, server = server)