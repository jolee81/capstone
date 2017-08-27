# create map based on kmeans clustering
#
library(plyr)
library(ggplot2)
library(maptools)
library(RColorBrewer)
library(maps)
library(mapproj)

clusters <-read.csv("Clusters.csv")
wmap <- read.csv("wmap.csv")

#countrylist<-as.vector(unique(slider$recipient))

# Define UI for application that draws a histogram
ui <- fluidPage(
  headerPanel('K-Means Clustering'),
  title = "K-Means Clustering",
  fluidRow(
    column(5, offset=1,
           selectInput("year","Choose a Year:",choices=c("1990","1995","2000","2005"))
           
    )
   
  ),
  plotOutput("map")
)

# Define server logic required to draw a histogram
server <- function(input, output) {

  clusterYear <- reactive({
    clusters[which(clusters$year==input$year),]
  })

  output$map <- renderPlot({
    mapWorld <- borders("world", colour="gray50", fill="gray25") # create a layer of borders
    ggplot(clusterYear(), aes(map_id=country)) +
      mapWorld +
      coord_map("mollweide") +
      geom_map(aes(fill = vector), map = wmap) +
      expand_limits(x=wmap$long, y=wmap$lat) +
      xlab("Cluster") +
      theme(text = element_text(size=20)) 
  })
  
  output$timeline <- renderPlot({
    #pull timeline plot
    
    
  })
}

# Run the application 
shinyApp(ui = ui, server = server)

