library(plotly)
library(colourpicker)
library(ggplot2)
library(gapminder)
library(shinycustomloader)
library(DT)

ui <- fluidPage(
    
    # App title ----
    titlePanel("Gapminder Data Visualization using Shiny and Plotly"),
    
    # Sidebar layout with input and output definitions ----
    sidebarLayout(
        
        # Sidebar panel for inputs ----
        sidebarPanel(
            
            # Input: Select the random distribution type ----
            textInput("title", "Title", "GDP vs life exp"),
            numericInput("size", "Point size", 1, 1),
            checkboxInput("fit", "Add line of best fit", FALSE),
            colourInput("color", "Point color", value = "blue"),

            
            selectInput("continent", "Continent",
                        choices = c("All", levels(gapminder$continent))),

            sliderInput(inputId = "life", label = "Life expectancy",
                        min = 0, max = 120,
                        value = c(30, 50)),
            downloadButton("download_data")
            
            
        ),
        
        # Main panel for displaying outputs ----
        mainPanel(
            
            # Output: Tabset w/ plot, summary, and table ----
            tabsetPanel(type = "tabs",
                        
                        tabPanel("Plot", withLoader(plotlyOutput("plot")) ),
                        tabPanel("Table", withLoader(DT::dataTableOutput("table")))
    
                        
            )
            
        )
    )
)