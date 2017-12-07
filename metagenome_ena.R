# see https://github.com/cstubben/ENAbrowseR
#library(devtools)
#install_github("cstubben/ENAbrowseR")
library(ENAbrowseR)
library(dplyr)
library(ggmap)

ena_taxonomy("metagenomes")

m1 <-  ena_search("tax_tree(408169)", result= "assembly")
summary_ena(m1)

m2 <-  ena_search("tax_tree(408169)",result= "wgs_set")
summary_ena(m2)

m3 <- ena_search("tax_tree(408169)", result= "sequence_release")
m3 <- filter(m3,mol_type == "genomic DNA")

# system(curl x.gz | tar xvz)



# z <- table2(temp$country[temp$location==""])
# y <- geocode(rownames(z), output="more")
# 
# table2(temp$location)
# temp <- add_lat_lon(temp)
# x <- group_by(temp, lon, lat) %>% summarize( n=n()) 
# library(leaflet)
# x <- subset(temp, !is.na(lat))
# popups <- paste0("host: ", x$host, "<br> host_status: ", x$host_status) 
# leaflet(x)  %>% addTiles() %>%  
#   addCircleMarkers( x$lon, x$lat,  clusterOptions = markerClusterOptions(maxClusterRadius=20), radius=2,  popup= popups)