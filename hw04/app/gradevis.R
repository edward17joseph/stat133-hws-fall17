#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
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
                    tabPanel("Barchart",value=1,plotOutput("gradePlot",height=600)),
                    tabPanel("Histogram",value=2,
                             plotOutput("HistPlot",height=600),
                             h3(textOutput('caption1')),
                             verbatimTextOutput("view")),
                    tabPanel("Scatterplot",value=3,
                             plotOutput("scatPlot",height=800),
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
  
  output$gradePlot <- renderPlot({
    barplot(table(dat$Grade),xlab = 'Grade',ylab = 'frequency',col = 'lightblue',font.lab=2)
    grid(nx = 10,lty = 'solid')})
  
  output$scatPlot <- renderPlot({
    plot(dat[[input$xax]],dat[[input$yax]],
         col=adjustcolor('black',input$opac),pch=16,cex=2,xlab = input$xax,ylab=input$yax,font.lab=2)
    axis(1, at=seq(0,100,10), labels=seq(0,100,10))
    axis(2, at=seq(0,100,10), labels=seq(0,100,10))
    grid(nx = 10,lty = 'solid')
    if (input$line=='lm'){
      abline(lm(dat[[input$xax]]~dat[[input$yax]]), col="red") 
    }
    if (input$line=='loess'){
      lines(lowess(dat[[input$xax]],dat[[input$yax]]), col="blue")
    }
  })
  
  output$cor <- renderPrint(cat(cor(dat[[input$xax]],dat[[input$yax]])))
  
  output$caption <- renderText('Correlation:')
  
  output$HistPlot <- renderPlot({
    x    <- dat[[input$type]] 
    bins <- seq(min(x), max(x), length.out = input$bins + 1)
    
    h <- hist(x, breaks = bins, col = 'darkgray', border = 'white',xlim = c(-10,110),xaxt='n',xlab = input$type,
              ylab = 'count',font.lab=2,main = NULL)
    grid(nx = 10,lty = 'solid')
    axis(1, at=seq(-10,110,10), labels=seq(-10,110,10))
  })
  
  output$view <- renderPrint(print_stats(summary_stats(dat[[input$type]])))
  
  output$caption1 <- renderText('Summary Statistics')
   
}

# Run the application 
shinyApp(ui = ui, server = server)

