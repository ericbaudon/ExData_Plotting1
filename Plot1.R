library(dplyr)

#1.Creation of a working folder and download datas
if (!file.exists("data")){dir.create("Data")}
Url<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
temp <- tempfile()
download.file(Url,temp)

#2.Read the first 150 000 lignes enought for our study and slect desire set and remove unused one
data <- read.csv2(unz(temp, "household_power_consumption.txt"),header=TRUE,sep=";",nrows=100000)
unlink(temp); rm(temp,Url)
data<-data%>%mutate(Date=as.Date(strptime(Date,"%d/%m/%Y")))%>%filter(Date==c("2007-02-01","2007-02-02"))

#3.Plot histogramme
databis<-mutate(data,Global_active_power=as.numeric(as.character(Global_active_power)))
png(filename="Plot1.png")
hist(databis$Global_active_power,col="red",xlab="Global Active Power (kilowatts)",main="Global Active Power")
dev.off()

