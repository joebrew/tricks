require(RCurl)
options(RCurlOptions = list(cainfo = system.file("CurlSSL", "cacert.pem", package = "RCurl")))


myLink<- "https://docs.google.com/spreadsheets/d/1ckfJLebzPYhJCp595aUn7IXkbDBBB21kZfGREw0l5PE/export?&format=csv"

myCsv <- getURL(myLink)
df <- read.csv(textConnection(myCsv))
