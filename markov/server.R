library(shiny)
library(dplyr)

shinyServer(function(input, output) {
  ## reading in csv with quotes
  quoteData <- reactive({
    quotes <- fread("top_quotes.csv", header=T, fill=T, data.table=T, col.names=c("drop", "name", "quote"))
    quotes <- quotes[,-1]
  })
  
  ##----- sidebar widgets ------##
  output$charactersUI <- renderUI({
    checkboxGroupInput("characters", label = h3("Who?"), 
                       choices = list("Aang", "Sokka", "Katara", "Toph", "Zuko", "Iroh"),
                       selected = "Aang")
    
  }) 
  
  output$buttonUI <- renderUI({
    actionButton("button", label = h4("Show random line"))
  })
  ##--------------------------##
  
  output$textUI <- renderUI({
    names <- isolate(input$characters)
    stringToPrint <- c()
    quotes <- quoteData()
    
    if(length(input$button) > 0 && input$button){
      for(i in 1:length(names)){
        
        randomQuote <- sample((quotes %>% filter(name == names[i]))[,2], 1)
        
        stringToPrint <- c(stringToPrint,"<b>", names[i], ": </b>")
        stringToPrint <- c(stringToPrint, randomQuote, "<br> <br>")
      }
    }
    
    HTML(stringToPrint)
  })
  
  
  
})
