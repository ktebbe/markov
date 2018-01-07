library(shiny)

shinyUI(fluidPage(
  
  # Application title
  titlePanel("Avatar: The Last Airbender Dialogue Generator"),
  
  
  sidebarLayout(
    sidebarPanel(
       uiOutput("charactersUI"),
       uiOutput("inputTextUI"),
       uiOutput("generateButtonUI"),
       uiOutput("randomButtonUI")
    ),
    
   
    mainPanel(
       uiOutput("textUI")
    )
  )
))
