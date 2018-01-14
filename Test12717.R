print("Got here1")
library(maps)
library(maptools)
library(devtools)
library("staphopia")
library("devtools")
library(httr)  #for GET(...)
library(rjson)
library(dplyr)
library(leaflet)
library(magrittr)
####SET UP MAP
#Saureusmap <- map("world", fill=TRUE, plot=FALSE)
#data("wrld_simpl")
#Saureusmap2<-leaflet(wrld_simpl) %>% setView(0, 0, 1) %>%
#  addPolygons(weight = 1, label = ~NAME)
print("Got here2")

ui <- bootstrapPage(
  headerPanel("S. aureus in the world"),
  tags$style(type = "text/css", "html, body {width:100%;height:100%}"),
  leafletOutput("Saureusmap2"),
  sidebarPanel(
    selectInput("Category", 'Choose Region', choices = list("United States"=1, "United Kingdom"=2, "Tanzania"=3, "Germany"=4, "Denmark"=5, "Ireland"=6, "Gambia"=7))
  ),

 #h4('The number of strains in a given location'),
 plotOutput("plotattempt")

  #   tableOutput("MarkedCrime")
)

strainPlot<-function(samples_by_location){
  print("Got here3")
  strainTable<-table(samples_by_location$country)
  print(strainTable)
  plotattempt<- plot(strainTable, col="red", bg=109, lty=5, type= 'o', xlab='country')
  return(plotattempt)}



server <- function(input, output, session) {
  print("Test1")
  selected_samples<- reactiveValues(clickedMarker=NULL)
  filteredData <- reactive({
    print("In reactive")
    countryname<-c("United States", "United Kingdom", "Tanzania", "Germany", "Denmark", "Ireland", "Gambia")
    print(countryname[as.numeric(input$country)])
    samples_by_location<<-samples[samples$country==countryname[as.numeric(input$country)]]
    print("test1")
   # output$plotattempt<- renderPlot(strainPlot(samples_by_location))
  return(samples_by_location)
  })
 
  ##convert country to x and y coordinates before below
  output$Saureusmap2 <- renderLeaflet({
    leaflet() %>%
      addTiles() %>%   
      addCircleMarkers(data=samples, samples$lon, samples$lat,popup = samples$location, radius = 5,clusterOptions = markerClusterOptions()) 
      #addMarkers(data=filteredData(), filteredData()$lon, filteredData()$lat)
  })
  
 output$plotattempt <- renderPlot({
   dat <- filteredData()
   p<-ggplot(data=dat, aes(x=filteredData,fill=..count..))+geom_histogram()+ggtitle("Distribution of prices")
   #return(p)
})
 
  observeEvent(input$Saureusmap2_marker_click,{
    print("observed map_marker_click")
    selected_samples$clickedMarker <- input$Saureusmap2_marker_click
    print(selected_samples$clickedMarker)
   # output$MarkedCrime <- renderTable({
    #  Longitude = c(data=selected_crimedata$clickedMarker$lng ) 
     # Latitude = c(data=selected_crimedata$clickedMarker$lat) 
      #df = data.frame(Longitude, Latitude)  
      #return(df)
      #caption="Longitude and Latitude of selected crime location"
      #return(list(data=selected_crimedata$clickedMarker$lng, data=selected_crimedata$clickedMarker$lat))
      #colnames(MarkedCrime) <- c("lat", "lng")
      #colnames(MarkedCrime)=c("lat","lng")
      #MarkedCrime
    #},caption="Longitude and Latitude of selected crime location")
    }
      )
}


shinyApp(ui, server)