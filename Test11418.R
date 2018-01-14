library(shiny)
library(leaflet)
library(graphics)
library(methods)
library(grDevices)
library(magrittr)
library(sp)
library(stats)
library(datasets)
library(utils)
library(base)
library(dplyr)
library(maps)
library(maptools)
library(stringr)
library(ggplot2)
library(staphopia)
library(devtools)
library(httr)  #for GET(...)
library(rjson)


ui <- bootstrapPage(
  headerPanel("S. aureus in the world"),
  tags$style(type = "text/css", "html, body {width:100%;height:100%}"),
  leafletOutput("Saureusmap2"),
  
  absolutePanel(top = 20, right = 20,
                selectInput('country', 'Choose the category', choices = c("United States"=1, "United Kingdom"=2, "Tanzania"=3, "Germany"=4, "Denmark"=5, "Ireland"=6, "Gambia"=7))
                
  ),
  h4('SNPs 1-10'),
  #plotOutput("plot2"),
  plotOutput("plot_SNPs")
  #tableOutput("MarkedCrime")
)
#crimePlot == SNP_Plot
#new_crimedata == SNP_by_location
#crimeTable == SNP_Table

SNP_Plot<-function(SNP_by_location){
  # load("/Users/carissa/StaphopiaProject/oldDF.rda")
  # count_snps<-count(oldDF, snp_id)
  # print("Arranging")
  # arranged_snps<-arrange(count_snps, desc(n))
  # print("Arranged")
  # arranged_snps_topten<- arranged_snps[1:1000,]
  # print(arranged_snps_topten$snp_id)
  # plot(factor(arranged_snps_topten$snp_id),arranged_snps_topten$n)
  
  # #get_snps(SNP_by_location$sample_id)
  
  sample_location<-c('United States', 'United Kingdom', 'Tanzania', 'Germany', 'Denmark', 'Ireland', 'Gambia')
  for (region in sample_location){
    typeof(region)
    SNP_by_location <<-samples%>%
      filter(str_detect(country, sample_location[as.numeric(region)]))
    Unique_sample_ID<-unique(SNP_by_location$sample_id)
    oldDF<-get_snps(Unique_sample_ID[1])
    for (ID in Unique_sample_ID[2:10] ){
      Returned_SNPs_Test <- get_snps(ID)
      oldDF<-rbind(oldDF, Returned_SNPs_Test)
      print(count(oldDF,snp_id))
    }
    filename<-c(region, '.rda')
    filename_concat<-cbind(filename)
    filename_final<-str_c(filename_concat, collapse="")
    save(oldDF, file=filename_final)
  }
  
  # count_snps<-count(oldDF, snp_id)
  # print("Arranging")
  # arranged_snps<-arrange(count_snps, desc(n))
  # print("Arranged")
  # arranged_snps_topten<- arranged_snps[1:1000,]
  # print(arranged_snps_topten$snp_id)
  # plot(factor(arranged_snps_topten$snp_id),arranged_snps_topten$n)
 
}

#selected_crimedata == selected_samples
#crimename == sample_location
server <- function(input, output, session) {
  selected_samples <- reactiveValues(clickedMarker=NULL)
  filteredData <- reactive({
    sample_location<-c('United States', 'United Kingdom', 'Tanzania', 'Germany', 'Denmark', 'Ireland', 'Gambia')
    print(sample_location[as.numeric(input$country)])
    #SNP_by_location<<-samples[samples$country==sample_location[as.numeric(input$country)],]
    # SNP_by_location <<-samples%>%
    #   filter(str_detect(country, sample_location[as.numeric(input$country)]))
    output$plot_SNPs<- renderPlot(SNP_Plot(SNP_by_location))
    # return(SNP_by_location)
  })
  
  print("Test")
  #SFMap == Saureusmap2
  #X == lat, Y == lon
  output$Saureusmap2<- renderLeaflet({
    leaflet(filteredData()) %>%
      addTiles() %>%   
      addCircleMarkers(data=samples, samples$lon, samples$lat,popup = samples$location, radius = 5,clusterOptions = markerClusterOptions())
  })
 
  
  
}


shinyApp(ui=ui, server=server)