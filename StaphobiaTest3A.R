##separate stuff in line 2 i thought i needed but dont actually..
##countrydata<-read.csv('country-capitals.csv', stringsAsFactors = FALSE)



###ADD LONG AND LAT COORDINATES TO D.F. OF 'SAMPLES' USING GOOGLE API GEOCODE:
geocoded <- data.frame(stringsAsFactors = FALSE)

allthecountries<-summarize(group_by(samples,location))

for(i in 1:nrow(allthecountries))
{
   
  result <- geocode(allthecountries$location[i], output = "latlona", source = "google")
  allthecountries$lon[i] <- as.numeric(result[1])
  allthecountries$lat[i] <- as.numeric(result[2])
  allthecountries$geoAddress[i] <- as.character(result[3])
}


# Write a CSV file containing samples to the working directory
write.csv(samples, "geocoded.csv", row.names=FALSE)