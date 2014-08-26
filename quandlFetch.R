library(Quandl)
#QUANDL CODE: JOE_BREW
#Authentication Token: u4mBpopqodNKmQpxzLQi
#vanity url. eg: http://quandl.com/JOE_BREW/
#Great Quandl cheat sheet: 
#https://s3.amazonaws.com/quandl-static-content/Documents/Quandl+-+R+Cheat+Sheet.pdf
Quandl.auth("u4mBpopqodNKmQpxzLQi")

haitiPop = Quandl("PENN/HTI_POP")
haitiPop$Date <- as.Date(haitiPop$Date,
                         format="%Y-%m-%d")
plot(haitiPop$Date, haitiPop$Value)

quandlFun <- function(sourceCode, tableCode){
  paste0("www.quandl.com/api/v1/datasets/",
         sourceCode,
         "/",
         tableCode,
         ".csv?auth_token=u4mBpopqodNKmQpxzLQi")
}

test <- read.csv(quandlFun("FRED", "GDP"))
