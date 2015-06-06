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

#3.Plot graphique
databis<-mutate(data,Global_active_power=as.numeric(as.character(Global_active_power)),Global_reactive_power=as.numeric(as.character(Global_reactive_power)),Voltage=as.numeric(as.character(Voltage)),Sub_metering_1=as.numeric(as.character(Sub_metering_1)),Sub_metering_2=as.numeric(as.character(Sub_metering_2)),Sub_metering_3=as.numeric(as.character(Sub_metering_3)),Day=as.POSIXct(paste(Date,Time,sep=" "), format="%Y-%m-%d %H:%M:%S"))

png(filename="Plot4.png")
par(mfrow = c(1, 1))

##First graphic
plot(databis$Global_active_power~databis$Day,type="l",xlab="",ylab="Global Active Power (kilowatts)",main="")

##Second graphic
plot(databis$Voltage~databis$Day,type="l",xlab="datetime",ylab="Voltage",main="")

##Third graphic
plot(databis$Sub_metering_1~databis$Day,type="l",xlab="",ylab="Energy sub metering",main="")
lines(databis$Sub_metering_2~databis$Day, col = "red")
lines(databis$Sub_metering_3~databis$Day, col = "blue")
legend("topright", lty=1, col = c("black","red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"))

##Fourth graphic
plot(databis$Global_reactive_power~databis$Day,type="l",xlab="datetime",ylab="Global_reactive_power",main="")
dev.off()
