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

ui <- bootstrapPage(
  headerPanel("S. aureus in the world"),
  tags$style(type = "text/css", "html, body {width:100%;height:100%}"),
  leafletOutput("Saureusmap2")
  # absolutePanel(top = 20, right = 20,
  #               selectInput('Category', 'Choose the category', choices = c('Australia'=1, 'Denmark:Zealand'=2, 'France:Huningue' =3, 'Gambia'=4, 'Germany'=5, 'United States'=6))
  #               
  # ),
#   h4('The number of strains in a given location'),
#   plotOutput("plot2"),
#   tableOutput("MarkedCrime")
)

# samplePlot<-function(new_samples){
#   sampleTable<-table(samples$location)
#   print(sampleTable)
#   plot2<- plot(sampleTable, col="red", bg=109, lty=5, type= 'o', xlab='location')
#   return(plot2)}

server <- function(input, output, session) {
  selected_samples<- reactiveValues(clickedMarker=NULL)
  # filteredData <- reactive({
  #   locationname<-c('Australia', 'Denmark:Zealand', 'France:Huningue', 'Gambia', 'Germany','United States')
  #   print(locationname[as.numeric(input$location)])
  #   new_samples<<-samples[samples$location==locationname[as.numeric(input$location)],]
  #   output$plot2<- renderPlot(samplePlot(new_samples))
  #   return(new_samples)
  #   
  # })
  
  print("Test")
  ##convert country to x and y coordinates before below
  output$Saureusmap2 <- renderLeaflet({
    leaflet() %>%
      addTiles() %>%   
      addCircleMarkers(data=samples, samples$lon, samples$lat,popup = samples$location, radius = 5,clusterOptions = markerClusterOptions())
  })
  
  
  #observeEvent(input$SFmap_marker_click,{
  #   print("observed map_marker_click")
  #   selected_crimedata$clickedMarker <- input$SFmap_marker_click
  #   print(selected_crimedata$clickedMarker)
  #   output$MarkedCrime <- renderTable({
  #     Longitude = c(data=selected_crimedata$clickedMarker$lng ) 
  #     Latitude = c(data=selected_crimedata$clickedMarker$lat) 
  #     df = data.frame(Longitude, Latitude)  
  #     return(df)
  #     caption="Longitude and Latitude of selected crime location"
  #     ##return(list(data=selected_crimedata$clickedMarker$lng, data=selected_crimedata$clickedMarker$lat))
  #     ##colnames(MarkedCrime) <- c("lat", "lng")
  #     ##colnames(MarkedCrime)=c("lat","lng")
  #     MarkedCrime
  #   },caption="Longitude and Latitude of selected crime location")}
  # )
  
  
}
shinyApp(ui, server)

