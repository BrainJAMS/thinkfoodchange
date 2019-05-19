library(shiny)
library(ggplot2)

data = read.csv("dataset1.csv")
names(data)[names(data) == "wastage"] <- "Expenditure"
names(data)[names(data) == "Income"] <- "IncomeDollarsPerWeek"



interface = (fluidPage(id = 'shiny',
                       titlePanel("Food Expenditure, Food Wastage in $"),
                       fluidRow(sidebarPanel(id = 'sidebar',selectInput("IncomeDollarsPerWeek","IncomeDollarsPerWeek",choices = data$IncomeDollarsPerWeek))),
                                fluidRow(mainPanel(   
                                  tabsetPanel(tabPanel("Income in dollars Vs Food Expenditure")),
                                  splitLayout(cellWidths = c("100%","50%"),plotOutput('distPlot', height = "300"))
                                  
                                ))))

server <- function(input, output,session) {

  output$distPlot = renderPlot({ggplot(data=data[data$IncomeDollarsPerWeek == input$IncomeDollarsPerWeek,], aes(x=type, y=Expenditure, fill=Expenditure)) +
      geom_bar(stat="identity") + scale_y_continuous() + geom_text(aes(label=Expenditure), vjust=-0.25)})
  
}

shinyApp(ui = interface, server = server)
