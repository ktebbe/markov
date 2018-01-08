library(shiny)

shinyUI(fluidPage(theme = "styles.css",
  
  # Application title
  headerPanel("Avatar: The Last Airbender Dialogue Generator"),
  
  
  sidebarLayout(
    sidebarPanel(
       uiOutput("charactersUI"),

       uiOutput("randomButtonUI"),
       br(),
       uiOutput("inputTextUI"),
       uiOutput("generateButtonUI")

    ),
    
   
    mainPanel(
       uiOutput("textUI")
    )
  )
))
