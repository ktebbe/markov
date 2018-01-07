library(shiny)
library(dplyr)
## button inspiration from - https://gist.github.com/aagarw30/2b46c89e686a956098e20cb90b1cf004


shinyServer(function(input, output) {
  ## reading in quotes csv
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
  output$inputTextUI <- renderUI({
    textInput("text", label = h3("Finish this line"), value = "I like")
  })
  
  output$generateButtonUI <- renderUI({
    actionButton("generateButton", label = h4("Generate new quote"))
  })
  
  output$randomButtonUI <- renderUI({
    actionButton("randomButton", label = h4("Show random quote"))
  })

  ##--------------------------##
  
  randBut = reactiveValues(on=FALSE)
  genBut = reactiveValues(on=FALSE)
  
  observeEvent(input$randomButton,
               isolate({
                 randBut$on = TRUE
                 genBut$on = FALSE
               }))
  
  observeEvent(input$generateButton,
               isolate({
                 randBut$on = FALSE
                 genBut$on = TRUE
               }))
  
  output$textUI <- renderUI({
    names <- isolate(input$characters)
    userInput <- isolate(input$text)
    stringToPrint <- c()
    quotes <- quoteData()
    
    if(length(input$randomButton) > 0 && randBut$on){
      for(i in 1:length(names)){

        randomQuote <- sample((quotes %>% filter(name == names[i]))[,2], 1)

        stringToPrint <- c(stringToPrint,"<b>", names[i], ": </b>")
        stringToPrint <- c(stringToPrint, randomQuote, "<br> <br>")
      }
    } else if(length(input$generateButton) > 0 && genBut$on){

      for(i in 1:length(names)){
        if(names[i] == "Aang") file <- aangTrigram
        if(names[i] == "Katara") file <- kataraTrigram
        if(names[i] == "Sokka") file <- sokkaTrigram
        if(names[i] == "Toph") file <- tophTrigram
        if(names[i] == "Zuko") file <- zukoTrigram
        if(names[i] == "Iroh") file <- irohTrigram
        
        stringToPrint <- c(stringToPrint,"<b>", names[i], ": </b>")
        stringToPrint <- c(stringToPrint,  reformat(generateSentence(userInput, file, 20)), "<br> <br>")
      }

    }

   HTML(stringToPrint)
  })
  
  
  
})
