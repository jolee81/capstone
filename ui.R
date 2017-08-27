
library(shiny)
library(plotly)

clusters <-read.csv("MoneyClusters.csv")
features <- read.csv('modeldata.csv')

shinyUI(fluidPage(
  
  navbarPage("Global People & Money Trends", id="nav",
             countryvars<-as.vector(unique(features$country)),
             clusternum <- c("All","Donor","Neutral","Receiver"),
             tabPanel("Learn",
                      div(class="outer",
                          tags$head(
                            includeCSS("styles.css"),
                            includeScript("gomap.js")
                          ),
                          h2("Countries Clustered Based on Financial Data"),
                          plotlyOutput("map2",width="100%", height="100%"),
                          
                          absolutePanel(id = "controls", class = "panel panel-default", fixed = TRUE,
                                        draggable = TRUE, bottom = 60, right = "auto", left = 20, top = "auto",
                                        width = 300, height = 500,
                                        h2("Map Explorer"),
                                        sliderInput("year", "Year:",min = 1985, max = 2013,value = 2005,step=1,sep = ""),
                                        selectInput("cluster", "Clusters", clusternum),
                                        h5("Typical Characteristics:"),
                                        plotOutput("description", height = 200)
                                        
                                      
                          ),

                          tags$div(id="cite",
                                   'Data is drawn from several sources: AidData, OECD, UN.'
                          )
                      )
             ),

             tabPanel("Predict",
                      h2("Make a Prediction"),
                      fluidRow(
                        column(6,
                               selectInput("country", "Country", choices=countryvars),
                               uiOutput('controls_UI')
                        ),
                        column(6,
                            
                            uiOutput("prediction")
                        )
                      ),
                      hr(),
                      plotlyOutput("timeline", height = 200),
                      tags$div(id="cite",
                               'Data is drawn from several sources: AidData, OECD, UN.'
                      )
             ),
             tabPanel("Explore",
                      div(class="outer",
                          tags$head(
                            includeCSS("styles.css")
                          ),
                          
                          h3("Explore the raw data on foreign investment."),
                          fluidRow(
                            column(5,
                                   plotlyOutput("invest2",width="110%", height="100%")
                            ),
                            column(5,
                                   plotlyOutput("invest",width="110%", height="100%")
                            )
                          ),
                          tags$div(id="cite",
                                   'Data is drawn from several sources: AidData, OECD, UN.'
                          )
                      )
                      
             ),
             conditionalPanel("false", icon("crosshair"))
  )

))
