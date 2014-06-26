library(maptools)
library(rgdal)

####################
# SET WD TO THE GIS FOLDER
####################
setwd("E:/fdoh/public/gis")

####################
zip <- readOGR("alachuazipcodes", 
                 layer="ACDPS_zipcode")

#####################
br <- readOGR("BRFSS",
              layer="BRFSS_MMSA_2010")

elem <- readOGR("elem", 
                "SBAC_school_zones_elementary")


elem2 <- spTransform(elem, CRS("+proj=longlat +datum=WGS84"))

loc <- read.csv("E:/fdoh/public/mosquito/traplatlong.csv")

points(loc$long, loc$lat,
       col="red", pch=16, cex=2)
points(loc$long, loc$lat, cex=2)


library(maps)
myMap <- map("county", "florida")
