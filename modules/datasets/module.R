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
            text-align: left;
          }
        ")),
          
          column(12, DTOutput("metadataTable")) 
        ),
        style = "overflow-y: scroll; height=100%;"
      ),
      
      card(
           navset_tab(nav_panel(title = "Summary and code", htmlOutput("datasetSummary")),
                      nav_panel(title = "Loader code", uiOutput("copyButton"),
                                verbatimTextOutput("loaderCode")))
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
        scrollY = 700,
        scrollX = TRUE,
        dom = 'ft',
        autoWidth = TRUE,
        responsive = TRUE,
        columnDefs = list(list(width = '20%', targets = c(0,1,3,4,5)),
                          list(visible = FALSE, targets = 2))
      ),
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
    
    observeEvent(input$metadataTable_rows_selected, {
      
      selected_row <- input$metadataTable_rows_selected
      selectedData <- metadata[selected_row,]
      
      output$datasetSummary <- renderUI({
        HTML(paste0("<h3 style='margin-bottom: 10px;'>", selectedData$Title, "</h3>",
                    "<p style='margin-bottom: 10px;'><strong>DOI:</strong> <a href='",
                    selectedData$DOI, "' target='_blank'>", selectedData$DOI, "</a></p>",
                    
                    "<p style='margin-bottom: 20px;'><strong>Scientific name:</strong> ", 
                    selectedData$Scientific_Name, "</p>",
                    
                    "<p style='margin-bottom: 5px;'><strong>Abstract:</strong></p>", 
                    "<p>", selectedData$Abstract, "</p>"
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
          
    })
    
  }
  
)