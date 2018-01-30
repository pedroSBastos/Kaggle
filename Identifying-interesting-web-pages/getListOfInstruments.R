#make a list of isntruments
library(XML)
library(RCurl)
library(rlist)

theurl <- getURL("https://en.wikipedia.org/wiki/List_of_musical_instruments",.opts = list(ssl.verifypeer = FALSE) )
tables <- readHTMLTable(theurl)
tables <- list.clean(tables, fun = is.null, recursive = FALSE)

#get first column (intruments)
instruments <- c()
for(i in seq(4)){
  instruments <- append(instruments,tables[[i]][1])
}
instruments <- unlist(instruments)