# from http://www.statslife.org.uk/significance/science-technology/1715-never-miss-another-sunset-with-r

# LOAD HILARY PARKER'S PACKAGE
if(!require(devtools)){
  install.packages("devtools")
}

if(!require(StreamMetabolism)){
  install.packages("StreamMetabolism")
}
library('devtools')
install_github('hilary','hilaryparker')
library('hilary')

# LOAD GOOGLE'S LAT LONG API STUFF
#### This script uses RCurl and RJSONIO to download data from Google's API:
#### Latitude, longitude, location type (see explanation at the end), formatted address
#### Notice ther is a limit of 2,500 calls per day

if(!require(RCurl)){
  install.packages("RCurl")
}

if(!require(RJSONIO)){
  install.packages("RJSONIO")
}

if(!require(plyr)){
  install.packages("plyr")
}
library(RCurl)
library(RJSONIO)
library(plyr)

url <- function(address, return.call = "json", sensor = "false") {
  root <- "http://maps.google.com/maps/api/geocode/"
  u <- paste(root, return.call, "?address=", address, "&sensor=", sensor, sep = "")
  return(URLencode(u))
}

geoCode <- function(address,verbose=FALSE) {
  if(verbose) cat(address,"\n")
  u <- url(address)
  doc <- getURL(u)
  x <- fromJSON(doc,simplify = FALSE)
  if(x$status=="OK") {
    lat <- x$results[[1]]$geometry$location$lat
    lng <- x$results[[1]]$geometry$location$lng
    location_type <- x$results[[1]]$geometry$location_type
    formatted_address <- x$results[[1]]$formatted_address
    return(c(lat, lng, location_type, formatted_address))
  } else {
    return(c(NA,NA,NA, NA))
  }
}



# Use plyr to getgeocoding for a vector
address <- c("530 NW 2nd Street, Gainesville, FL 32601")
locations <- ldply(address, function(x) geoCode(x))
names(locations) <- c("lat","lon","location_type", "forAddress")

locations$lat <- as.numeric(locations$lat)
locations$lon <- as.numeric(locations$lon)

# WRITE CSV
setwd("C:/Users/BrewJR/Documents/tricks/")
create_sunset_cal(date="2014/01/01",
                  lat = locations$lat,
                  long = locations$lon,
                  timezone = "America/New_York",
                  num.days = 365,
                  file="sunset.csv",
                  location = "530 NW 2nd Street, Gainesville, FL 32601, USA")

