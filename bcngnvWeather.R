library(weatherData)
getWeatherForDate("GNV", "2014-04-14")

#2010
gnv2010 <- getSummarizedWeather("GNV", start_date = "2010-01-01", 
                                end_date = "2010-12-31",
                                opt_custom_columns = TRUE,
                                custom_columns = c(2,4,8,9,20,21))

bcn2010 <- getSummarizedWeather("BCN", start_date = "2010-01-01", 
                            end_date = "2010-12-31",
                            opt_custom_columns = TRUE,
                            custom_columns = c(2,4,8,9,20,21))
#2011
gnv2011 <- getSummarizedWeather("GNV", start_date = "2011-01-01", 
                                end_date = "2011-12-31",
                                opt_custom_columns = TRUE,
                                custom_columns = c(2,4,8,9,20,21))

bcn2011 <- getSummarizedWeather("BCN", start_date = "2011-01-01", 
                                end_date = "2011-12-31",
                                opt_custom_columns = TRUE,
                                custom_columns = c(2,4,8,9,20,21))
#2012
gnv2012 <- getSummarizedWeather("GNV", start_date = "2012-01-01", 
                                end_date = "2012-12-31",
                                opt_custom_columns = TRUE,
                                custom_columns = c(2,4,8,9,20,21))

bcn2012 <- getSummarizedWeather("BCN", start_date = "2012-01-01", 
                                end_date = "2012-12-31",
                                opt_custom_columns = TRUE,
                                custom_columns = c(2,4,8,9,20,21))
#2013
gnv2013 <- getSummarizedWeather("GNV", start_date = "2013-01-01", 
                                end_date = "2013-12-31",
                                opt_custom_columns = TRUE,
                                custom_columns = c(2,4,8,9,20,21))

bcn2013 <- getSummarizedWeather("BCN", start_date = "2013-01-01", 
                                end_date = "2013-12-31",
                                opt_custom_columns = TRUE,
                                custom_columns = c(2,4,8,9,20,21))
#2014
gnv2014 <- getSummarizedWeather("GNV", start_date = "2014-01-01", 
                                end_date = Sys.Date()-1,
                                opt_custom_columns = TRUE,
                                custom_columns = c(2,4,8,9,20,21))

bcn2014 <- getSummarizedWeather("BCN", start_date = "2014-01-01", 
                                end_date = Sys.Date()-1,
                                opt_custom_columns = TRUE,
                                custom_columns = c(2,4,8,9,20,21))

#Merge
gnv <- rbind(gnv2010, gnv2011, gnv2012, gnv2013, gnv2014)
bcn <- rbind(bcn2010, bcn2011, bcn2012, bcn2013, bcn2014)


colnames(gnv) <- c("date", "maxTemp", "minTemp", "maxHumid", "meanHumid", "rain", "cloudCover")
colnames(bcn) <- c("date", "maxTemp", "minTemp", "maxHumid", "meanHumid", "rain", "cloudCover")

#add day
gnv$day <- as.numeric(gnv$date)
bcn$day <- as.numeric(bcn$date)


#######################
#
#
#########################
par(mfrow=c(3,2))
par(mar=c(4,4,2,1))
par(oma=c(0,0,0,0))


#maxTemp
plot(gnv$date, gnv$maxTemp,
     col=adjustcolor("red", alpha.f=0.1),
     pch=16,
     xlab="Date",
     ylab="Max temp (F)",
     main="Daily maximum temperature",
     ylim=c(0,100))
points(bcn$date, bcn$maxTemp,
       col=adjustcolor("blue", alpha.f=0.1),
       pch=16)
abline(h=seq(0,150,10),
       col=adjustcolor("black", alpha.f=0.1))
legend(x="bottomright",
       pch=16,
       col=adjustcolor(c("red", "blue"), alpha.f=0.3),
       legend=c("Gainesville", "Barcelona"))


#minTemp
plot(gnv$date, gnv$minTemp,
     col=adjustcolor("red", alpha.f=0.1),
     pch=16,
     xlab="Date",
     ylab="min temp (F)",
     main="Daily minimum temperature",
     ylim=c(0,100))
points(bcn$date, bcn$minTemp,
       col=adjustcolor("blue", alpha.f=0.1),
       pch=16)
abline(h=seq(0,150,10),
       col=adjustcolor("black", alpha.f=0.1))
legend(x="bottomright",
       pch=16,
       col=adjustcolor(c("red", "blue"), alpha.f=0.3),
       legend=c("Gainesville", "Barcelona"))

#maxHumid
library(SemiPar)
gnvMaxHumid= spm(gnv$maxHumid~f(gnv$day, spar=4), omit.missing=TRUE)
bcnMaxHumid= spm(bcn$maxHumid~f(bcn$day, spar=4), omit.missing=TRUE)

plot(gnv$date, gnv$maxHumid,
     col=adjustcolor("red", alpha.f=0.1),
     pch=16,
     xlab="Date",
     ylab="Max humidity (%)",
     main="Daily maximum humidity",
     ylim=c(30,100))
points(bcn$date, bcn$maxHumid,
       col=adjustcolor("blue", alpha.f=0.1),
       pch=16)
abline(h=seq(0,150,10),
       col=adjustcolor("black", alpha.f=0.1))
legend(x="bottomright",
       pch=16,
       col=adjustcolor(c("red", "blue"), alpha.f=0.3),
       legend=c("Gainesville", "Barcelona"))

lines(bcnMaxHumid, shade.col=adjustcolor("blue", alpha.f=0.2),
      rug.col=adjustcolor("blue", alpha.f=0.7), col=adjustcolor("blue", alpha.f=0.5))
lines(gnvMaxHumid, shade.col=adjustcolor("red", alpha.f=0.2),
      rug.col=adjustcolor("red", alpha.f=0.7), col=adjustcolor("red", alpha.f=0.5))


#meanHumid
gnvmeanHumid= spm(gnv$meanHumid~f(gnv$day, spar=4), omit.missing=TRUE)
bcnmeanHumid= spm(bcn$meanHumid~f(bcn$day, spar=4), omit.missing=TRUE)

plot(gnv$date, gnv$meanHumid,
     col=adjustcolor("red", alpha.f=0.1),
     pch=16,
     xlab="Date",
     ylab="Mean humidity (%)",
     main="Daily mean humidity",
     ylim=c(30,100))
points(bcn$date, bcn$meanHumid,
       col=adjustcolor("blue", alpha.f=0.1),
       pch=16)
abline(h=seq(0,150,10),
       col=adjustcolor("black", alpha.f=0.1))
legend(x="bottomright",
       pch=16,
       col=adjustcolor(c("red", "blue"), alpha.f=0.3),
       legend=c("Gainesville", "Barcelona"))

lines(bcnmeanHumid, shade.col=adjustcolor("blue", alpha.f=0.2),
      rug.col=adjustcolor("blue", alpha.f=0.7), col=adjustcolor("blue", alpha.f=0.5))
lines(gnvmeanHumid, shade.col=adjustcolor("red", alpha.f=0.2),
      rug.col=adjustcolor("red", alpha.f=0.7), col=adjustcolor("red", alpha.f=0.5))


#cloudCover
gnvcloudCover= spm(gnv$cloudCover[which(is.na(gnv$cloudCover)==FALSE)]~
                     f(gnv$day[which(is.na(gnv$cloudCover)==FALSE)], spar=2), omit.missing=TRUE)
bcncloudCover= spm(bcn$cloudCover[which(is.na(bcn$cloudCover)==FALSE)]~
                     f(bcn$day[which(is.na(bcn$cloudCover)==FALSE)], spar=2), omit.missing=TRUE)

plot(gnv$date, gnv$cloudCover,
     col=adjustcolor("red", alpha.f=0.1),
     pch=16,
     xlab="Date",
     ylab="Cloud cover (OCTA)",
     main="Daily mean cloud cover (0-8)")
points(bcn$date, bcn$cloudCover,
       col=adjustcolor("blue", alpha.f=0.1),
       pch=16)
abline(h=seq(0,150,10),
       col=adjustcolor("black", alpha.f=0.1))

lines(bcncloudCover, shade.col=adjustcolor("blue", alpha.f=0.2),
      rug.col=adjustcolor("blue", alpha.f=0.7), col=adjustcolor("blue", alpha.f=0.5))
lines(gnvcloudCover, shade.col=adjustcolor("red", alpha.f=0.2),
      rug.col=adjustcolor("red", alpha.f=0.7), col=adjustcolor("red", alpha.f=0.5))
legend(x="topleft",
       pch=16,
       col=adjustcolor(c("red", "blue"), alpha.f=0.3),
       legend=c("Gainesville", "Barcelona"))


#rain
gnv$rain <- as.numeric(as.character(gnv$rain))
bcn$rain <- as.numeric(as.character(bcn$rain))
gnvrain= spm(gnv$rain[which(is.na(gnv$rain)==FALSE)]~
                     f(gnv$day[which(is.na(gnv$rain)==FALSE)], spar=2), omit.missing=TRUE)
bcnrain= spm(bcn$rain[which(is.na(bcn$rain)==FALSE)]~
                     f(bcn$day[which(is.na(bcn$rain)==FALSE)], spar=2), omit.missing=TRUE)

plot(gnv$date, gnv$rain,
     col=adjustcolor("red", alpha.f=0.1),
     pch=16,
     xlab="Date",
     ylab="Precipitation (inches)",
     main="Daily precipitation",
     ylim=c(0,2))
points(bcn$date, bcn$rain,
       col=adjustcolor("blue", alpha.f=0.1),
       pch=16)
abline(h=seq(0,150,1),
       col=adjustcolor("black", alpha.f=0.1))


lines(bcnrain, shade.col=adjustcolor("blue", alpha.f=0.2),
      rug.col=adjustcolor("blue", alpha.f=0.7), col=adjustcolor("blue", alpha.f=0.5))
lines(gnvrain, shade.col=adjustcolor("red", alpha.f=0.2),
      rug.col=adjustcolor("red", alpha.f=0.7), col=adjustcolor("red", alpha.f=0.5))
legend(x="topleft",
       pch=16,
       col=adjustcolor(c("red", "blue"), alpha.f=0.3),
       legend=c("Gainesville", "Barcelona"))
