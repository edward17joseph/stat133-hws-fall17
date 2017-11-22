#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggvis)
source("../code/functions.r")
dat <- read.csv("../data/cleandata/cleanscores.csv")

# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
   titlePanel("Grade Visualizer"),
   
   # Sidebar with a slider input for number of bins 
   sidebarLayout(
      sidebarPanel(
        conditionalPanel(condition = "input.tabselected==1",tableOutput('grade')),
        conditionalPanel(condition = "input.tabselected==3",
                         selectInput("xax",
                                     "X-axis Variable",
                                     choices = names(dat[1:22]),
                                     selected = "Test1"),
                         selectInput("yax",
                                     "Y-axis Variable",
                                     choices = names(dat[1:22]),
                                     selected = "Overall"),
                         sliderInput("opac",
                                     "Opacity",
                                     min = 0,
                                     max = 1,
                                     value = .5),
                         radioButtons('line',
                                      "Show Line",
                                      choices = c('none','lm','loess'),
                                      selected = 'none',
                                      width = 200)),
        conditionalPanel(condition = "input.tabselected==2",
                         selectInput("type",
                                     "X-Axis Variable",
                                     choices = names(dat[1:22]),
                                     selected = "HW1"),
                         sliderInput("bins",
                                     "Bin Width",
                                     min = 1,
                                     max = 10,
                                     value = 10)
        )
         
      ),
      
      # Show a plot of the generated distribution
      mainPanel(
        tabsetPanel(type = 'tabs', 
                    tabPanel("Barchart",value=1,ggvisOutput("gradePlot")),
                    tabPanel("Histogram",value=2,
                             ggvisOutput("HistPlot"),
                             h3(textOutput('caption1')),
                             verbatimTextOutput("view")),
                    tabPanel("Scatterplot",value=3,
                             ggvisOutput("scatPlot"),
                             h3(textOutput('caption')),
                             verbatimTextOutput('cor')),
                    id='tabselected'
          
        )
         
      )
   )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  t <- table(dat$Grade)
  t <- cbind(names(t),t,round(prop.table(t),2))
  t <- t[c(3,1,2,6,4,5,9,7,8,10,11),]
  colnames(t) <- c('Grade','Freq','Prop')
  output$grade <- renderTable(t)
  
  output$cor <- renderPrint(cat(cor(dat[[input$xax]],dat[[input$yax]])))
  
  output$caption <- renderText('Correlation:')
  
  vis_plot1 <- reactive({
    data <- as.data.frame(table(dat$Grade))
    names(data) <- c("Grades","Frequency")
    bar <- data%>%
      ggvis(x = ~Grades,y=~Frequency,fill:='lightblue') %>%
      layer_bars()
  })
  bind_shiny(vis_plot1,"gradePlot")
  
  vis_plot2 <- reactive({
    xvar <- prop("x", as.symbol(input$type))
    histogram <- dat %>%
      ggvis(x = xvar) %>%
      layer_histograms(stroke := 'white', width = input$bins)
  })
  bind_shiny(vis_plot2,"HistPlot")
  
  vis_plot3 <- reactive({
    if (input$line!='none'){
      xvar <- prop("x", as.symbol(input$xax))
      yvar <- prop("y", as.symbol(input$yax))
      histogram <- dat %>%
        ggvis(x = xvar,y=yvar,opacity:=input$opac) %>%
        layer_points()%>%
        layer_model_predictions(model = input$line,opacity:=1,stroke:='red')
    }else{
      xvar <- prop("x", as.symbol(input$xax))
      yvar <- prop("y", as.symbol(input$yax))
      histogram <- dat %>%
        ggvis(x = xvar,y=yvar,opacity:=input$opac) %>%
        layer_points()
    }
  })
  bind_shiny(vis_plot3,"scatPlot")
  
  
  output$view <- renderPrint(print_stats(summary_stats(dat[[input$type]])))
  
  output$caption1 <- renderText('Summary Statistics')
   
}

# Run the application 
shinyApp(ui = ui, server = server)

