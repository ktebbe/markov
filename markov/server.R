library(shiny)

shinyServer(function(input, output) {
  
  output$charactersUI <- renderUI({
    checkboxGroupInput("characters", label = h3("Who?"), 
                       choices = list("Aang", "Sokka", "Katara", "Toph", "Zuko", "Iroh"),
                       selected = "Aang")
    
  }) 
  
  output$buttonUI <- renderUI({
    actionButton("button", label = "Show random line")
  })
  
  ## watching for button press
  observeEvent(input$button,{
    
  })
  
  text <- reactiveValues(quotes = c("testing"))
  
  output$textUI <- renderUI({
    names <- input$characters
    stringToPrint <- c()
    for(i in 1:length(names)){
      stringToPrint <- c(stringToPrint, names[i], "<br>")
    }
    #paste(text[['quotes']], names)
    HTML(stringToPrint)
  })
  
  
  
})
