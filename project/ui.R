library(shiny)


shinyUI(fluidPage(
  titlePanel("plant data"),
  
  sidebarLayout(
    sidebarPanel(
      selectInput('plant_code', 'Plant code',
                  df$plant_code),
      selectInput('plant_code2', 'Plant code',
                  df$plant_code),
      br(),
      selectInput('species', 'Species',
                  unique(df$species_lower)),
      selectInput('species2', 'Species',
                  unique(df$species_lower))
      #selectInput('cats', 'Categories',
      #            colnames(df))
      
    ),
  
  mainPanel(
    tabsetPanel(
    tabPanel("compare plant code",
    plotOutput('plant_code_plot')),
    tabPanel("compare species",
             plotOutput('species_plot')),
    tabPanel("native",
             plotOutput('cat_plot')),
    tabPanel("height",
             plotOutput('height_plot')),
    tabPanel("life",
             plotOutput('life_plot'))
    
    
    )
  )
  
  )))