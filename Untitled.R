library(shiny)
library(ggplot2)

data = read.csv("dataset1.csv")
names(data)[names(data) == "wastage"] <- "Expenditure"
names(data)[names(data) == "Income"] <- "IncomeDollarsPerWeek"



interface = (fluidPage(id = 'shiny',
                       titlePanel("Relation between Income,Food Expenditure, Food Wastage in $"),
                       fluidRow(sidebarPanel(id = 'sidebar',selectInput("IncomeDollarsPerWeek","IncomeDollarsPerWeek",choices = data$IncomeDollarsPerWeek))),
                       fluidRow(sliderInput(inputId= "IncomeDollarsPerWeek",
                                   label = "type",
                                   min = 500, 
                                   max = 1500, value = 500, step = 200),
                       fluidRow(mainPanel(   
                         tabsetPanel(tabPanel("Income in dollars Vs Food Expenditure")),
                         splitLayout(cellWidths = c("140%","60%"),plotOutput('distPlot', height = "1000"))
                         
                       )))))

server <- function(input, output,session) {

  
  observeEvent(data$type,{
    
   updateSliderInput(session,
                      "numberOfElements",
                      min=500,
                      max = 1500,
                      value = 500,
                      step=200)})
    output$distPlot = renderPlot({ggplot(data=data[data$IncomeDollarsPerWeek == input$IncomeDollarsPerWeek,], aes(x=type, y=Expenditure, fill=Expenditure)) +
        geom_bar(stat="identity")})
  
}

shinyApp(ui = interface, server = server)
