library(shiny)

shinyUI(fluidPage(
  
  # Application title
  titlePanel("Avatar: The Last Airbender Dialogue Generator"),
  
  
  sidebarLayout(
    sidebarPanel(
       uiOutput("entry"),
       uiOutput("charactersUI"),
       uiOutput("buttonUI")
    ),
    
   
    mainPanel(
       uiOutput("textUI")
    )
  )
))
