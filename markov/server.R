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
  
  ## will update when use clicks button
  random <- reactiveValues(clicked = c())
  
  ## watching for button press
  # observeEvent(input$button,{
  #   random[['clicked']] <- c(random[['clicked']], 1)
  # })
  # 
  # text <- reactiveValues(quotes = c("testing"))
  
  
  
  output$textUI <- renderUI({
    names <- isolate(input$characters)
    stringToPrint <- c()
    
    if(length(input$button) > 0 && input$button){
      for(i in 1:length(names)){
        stringToPrint <- c(stringToPrint,"<b>", names[i], ": </b>", "<br>")
      }
    }
    
    HTML(stringToPrint)
  })
  
  
  
})
