#LOAD REQUIRED PACKAGES
library(maptools)
library(rgdal)

# SET WD TO THE GIS FOLDER
setwd("E:/fdoh/public/gis")

####################

#Read in map with odd coordinate system
zip <- readOGR("alachuazipcodes", 
                 layer="ACDPS_zipcode")

#Read in another map with same odd coordinate system
elem <- readOGR("elem", 
                "SBAC_school_zones_elementary")

#Read in points with lat long projection
loc <- read.csv("E:/fdoh/public/mosquito/traplatlong.csv")

#In order to plot points onto elem, we'll convert elem to 
#lat long
elem2 <- spTransform(elem, CRS("+proj=longlat +datum=WGS84"))

#Now plot points onto elem
plot(elem2)
points(loc$long, loc$lat)

#Create a latlong map of Florida
library(maps)
myMap <- map("county", "florida")

#add elem 2 to that map
plot(elem2, add=T)

#add those points as well
points(loc$long, loc$lat, col="red", pch=16, cex=0.2)
