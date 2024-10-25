
datasets <- list(
  "ui" = page_fillable(
    layout_columns(
      width = c(6,6),
      style = "height:100vh;",
      
      card(
        fluidRow(
          tags$style(HTML("
          .dataTables_wrapper .dataTables_filter {
            float: left;
            text-align: left; }
        ")),
          
          column(12, DTOutput("metadataTable")) 
        ),
        style = "height=100%;"
      ),
      
      card(
           htmlOutput("datasetSummary")
           
           #uiOutput("copyButtonLoader"),
           #verbatimTextOutput("loaderCode"),
           #verbatimTextOutput("curationCode")
    ))
  ),
  
  "server" = function(input, output, session){
    
    output$metadataTable <- renderDT(datatable(
      assembleMetadata(metadata),
      selection = "single",
      filter = "top",
      rownames = F,
      options = list(
        pageLength = -1,
        deferRender = T,
        scrollY = TRUE,
        scrollX = TRUE,
        dom = 'ft',
        autoWidth = TRUE,
        responsive = TRUE,
        columnDefs = list(
          list(width = '20%', targets = 1))
      ),
      
      # Search functionality
      callback = JS(
        "$(document).ready(function() {",
        "  $('#example').DataTable();",
        "  $.fn.dataTable.ext.search.push(",
        "    function(settings, searchData, index, rowData, counter) {",
        "      var match = false;",
        "      var searchTerm = settings.oPreviousSearch.sSearch.toLowerCase();",
        "      searchData.forEach(function(item, index) {",
        "        if (item.toLowerCase().startsWith(searchTerm)) {",
        "          match = true;",
        "        }",
        "      });",
        "      return match;",
        "    }",
        "  );",
        "});"
      ),
      escape = F
    ))
    
    observe({
      DT::selectRows(dataTableProxy("metadataTable"), 1)
    })
    
    # User action
    observeEvent(input$metadataTable_rows_selected, {
      
      selected_row <- input$metadataTable_rows_selected
      selectedData <- metadata[selected_row,]
      
      output$datasetSummary <- renderUI({
        HTML(paste0("<h3 style='margin-bottom: 10px;'>", selectedData$Title, "</h3>",
                    
                    "<p style='margin-bottom: 10px;'><strong>DOI:</strong> <a href='",
                    selectedData$DOI, "' target='_blank'>", selectedData$DOI, "</a></p>",
                    
                    "<p style='margin-bottom: 20px;'><strong>Scientific name, Common name:</strong> ", 
                    selectedData$Scientific_Name, ", ", selectedData$Common_Name, "</p>",
                    
                    accordion(
                      id = "Abstract",
                      open = FALSE,
                      accordion_panel(
                        title = HTML("<strong>Abstract</strong>"),
                        HTML(paste0("<p>", selectedData$Abstract, "</p>"))
        )),
        
        accordion(
          id = "code",
          open = FALSE,
          accordion_panel(
            title = HTML("<strong>Coad to load, curate, and analyze</strong>"),
            HTML(paste0("<p>", "Loading", "</a></p>")),
            verbatimTextOutput("loaderCode", placeholder = TRUE),
            HTML(paste0("<p>", "Curating", "</a></p>")),
            verbatimTextOutput("curationCode", placeholder = TRUE),
            HTML(paste0("<p>", "Analyzing", "</a></p>")),
            verbatimTextOutput("analysisCode", placeholder = TRUE)
          ))
        ))
      })
      
      
      loaderCode <- assembleLoaderCode(selected_row)
      output$copyButton <- renderUI({
        rclipButton(
          inputId = "copy", 
          label = "",
          clipText = loaderCode,
          icon = icon("clipboard")
        )
      })
      output$loaderCode <- renderText(loaderCode)
      
      
      curationCode <- assembleCurationCode(selected_row)
      output$copyButton <- renderUI({
        rclipButton(
          inputId = "copy", 
          label = "",
          clipText = curationCode,
          icon = icon("clipboard")
        )
      })
      output$curationCode <- renderText(curationCode)
      
    })
    
  }
  
)

