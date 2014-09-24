# FROM http://www.r-bloggers.com/seeing-the-daylight-with-r/
library(maptools)

# these functions need the lat/lon in an unusual format
portsmouth <- matrix(c(-70.762553, 43.071755), nrow=1)
for_date <- as.POSIXct("2014-12-25", tz="America/New_York")
sunriset(portsmouth, for_date, direction="sunrise", POSIXct.out=TRUE)

##         day_frac                time
## newlon 0.3007444 2014-12-25 07:13:04

# adapted from http://r.789695.n4.nabble.com/maptools-sunrise-sunset-function-td874148.html
ephemeris <- function(lat, lon, date, span=1, tz="UTC") {
  
  # convert to the format we need
  lon.lat <- matrix(c(lon, lat), nrow=1)
  
  # make our sequence - using noon gets us around daylight saving time issues
  day <- as.POSIXct(date, tz=tz)
  sequence <- seq(from=day, length.out=span , by="days")
  
  # get our data
  sunrise <- sunriset(lon.lat, sequence, direction="sunrise", POSIXct.out=TRUE)
  sunset <- sunriset(lon.lat, sequence, direction="sunset", POSIXct.out=TRUE)
  solar_noon <- solarnoon(lon.lat, sequence, POSIXct.out=TRUE)
  
  # build a data frame from the vectors
  data.frame(date=as.Date(sunrise$time),
             sunrise=as.numeric(format(sunrise$time, "%H%M")),
             solarnoon=as.numeric(format(solar_noon$time, "%H%M")),
             sunset=as.numeric(format(sunset$time, "%H%M")),
             day_length=as.numeric(sunset$time-sunrise$time))
  
}


gainesville <- ephemeris(29.656832, 
                         -82.326634, 
                         #Sys.Date(), 
                         "2014-01-01",
                         1000, 
                         tz="America/New_York")
plot(gainesville$date, gainesville$day_length, xlab = "Date", ylab = "Hours of daylight")
abline(v= Sys.Date(),
       col = adjustcolor("darkred", alpha.f=0.5),
       lwd = 3)
#lines(gainesville$date, (gainesville$sunset/100)-12, col = "blue")
#lines(gainesville$date, (gainesville$sunrise/100), col = "red", lty = 6)
