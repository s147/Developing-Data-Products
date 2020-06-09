library(plotly)
library(colourpicker)
library(ggplot2)
library(gapminder)
library(shinycustomloader)
library(DT)

server <- function(input, output) {
    filtered_data <- reactive({
        data <- gapminder
        data <- subset(
            data,
            lifeExp >= input$life[1] & lifeExp <= input$life[2]
        )
        if (input$continent != "All") {
            data <- subset(
                data,
                continent == input$continent
            )
        }
        data
    })
    
    output$table <- DT::renderDataTable({
        data <- filtered_data()
        data
    })
    
    output$download_data <- downloadHandler(
        filename = function() {
            paste("gapminder-data-", Sys.Date(), ".csv", sep="")
        },
        content = function(file) {
            write.csv(filtered_data(), file)
        }
    )
    
    
    output$plot <- renderPlotly({

        ggplotly({
            data <- filtered_data()
            
            p <- ggplot(data, aes(gdpPercap, lifeExp)) +
                geom_point(size = input$size, col = input$color) +
                scale_x_log10() +
                ggtitle(input$title) + 
                
            
            if (input$fit) {
                p <- p + geom_smooth(method = "lm")
            }
            p
        })
    })
}