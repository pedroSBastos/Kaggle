#librarys
library(arules)

#rating websites

data <- read.table("C:\\Users\\asus\\Desktop\\kaggle\\Bands\\index", sep="|", fill = T, colClasses = c("NULL",rep("character",4)), col.names = c("NULL","rating","url","date","name"))

data$url[49] <- "http://www.iuma.com/IUMA-2.0/ftp/volume1/Rebecca's_Mask/"
data$date[49] <- "Wed Jan  3 19:04:44 PST 1996"
data$name[49] <- "Rebecca's Mask"

#things about websites

websites <- matrix(nrow = 61, ncol = 2, data = NA)

for(i in seq(61)){
  ficheiro <- readLines(paste("C:\\Users\\asus\\Desktop\\kaggle\\Bands\\",i, sep=""))
  gS <- ficheiro[grep("olas/genre",ficheiro)]
  gS <- gsub("(.*>)(.+)(</A.*)", "\\2", gS)
  websites[i,] <- c(i,paste(paste(gS, collapse = ", "),paste(", ",data$rating[i]))) 
}
colnames(websites) <- c("id","items")
websites <- data.frame(websites)


websites <- matrix(nrow = 198, ncol = 2, data = NA)
row <- 1

for(i in seq(61)){
  ficheiro <- readLines(paste("C:\\Users\\asus\\Desktop\\kaggle\\Bands\\",i, sep=""))
  gS <- ficheiro[grep("olas/genre",ficheiro)]
  gS <- gsub("(.*>)(.+)(</A.*)", "\\2", gS)
  for(g in gS){
    websites[row,] <- c(i,g)
    row=row+1
  }
  websites[row,] <- c(i,data$rating[i])
  row=row+1
}
colnames(websites) <- c("id","genero")
trans <- as(split(websites[,"genero"], websites[,"id"]), "transactions")


write.csv(websites, file="band.csv")
