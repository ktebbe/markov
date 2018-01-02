library(shiny)

shinyServer(function(input, output) {
  
  output$charactersInput <- renderUI({
    checkboxGroupInput("characters", label = h3("Who?"), 
                       choices = list("Aang", "Sokka", "Katara", "Toph", "Zuko", "Iroh"),
                       selected = 1)
    
  }) 
  
  output$text <- renderUI({
    
  })
  
})
