library(shiny)

shinyUI(fluidPage(theme = "styles.css",
  
  # Application title
  headerPanel("Avatar: The Last Airbender Dialogue Generator"),
  
  
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
