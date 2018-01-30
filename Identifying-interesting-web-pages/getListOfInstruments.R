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
instruments <- gsub("([A-Za-z]+).*\n.*", "\\1", instruments)
instruments <- gsub("\\(.*\\)","",instruments)
instruments <- gsub("/", " " ,instruments)
instruments <- unlist(strsplit(instruments, " "))
instruments <- instruments[nchar(instruments)>2]
instruments <- unique(instruments)

vocal <- c("vocal")

generos <- readLines("C:\\Users\\asus\\Desktop\\kaggle\\Bands\\generes.txt")

know <- append(instruments,vocal)
know <- append(know, generos)
know <- unique(know)
know <- tolower(know)
