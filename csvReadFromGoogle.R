require(RCurl)
options(RCurlOptions = list(cainfo = system.file("CurlSSL", "cacert.pem", package = "RCurl")))


myLink<- "https://docs.google.com/spreadsheets/d/1ckfJLebzPYhJCp595aUn7IXkbDBBB21kZfGREw0l5PE/export?&format=csv"

myCsv <- getURL(myLink)
df <- read.csv(textConnection(myCsv))

# FUNCTION TO READ DATA FROM GOOGLE
GooFun <- function(myLink){
  myLink <- "https://docs.google.com/spreadsheets/d/1fR1FQQrtAUHxXHgDz5IMKrrZAQbFz2D-kbGMQTUo0ew/pubhtml"
  csvLink <- gsub("/pubhtml", "/export?&format=csv", myLink)
  myCsv <- getURL(csvLink)
  df <- read.csv(textConnection(myCsv))
  return(df)
}
