library(lubridate)
library(dplyr)
consumption <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings="?", colClasses= c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric","numeric"), nrows=70570)
elec<-tbl_df(consumption)
elec$Date<-dmy(elec$Date)
subset<-elec[grepl('2007-02-01|2007-02-02', elec$Date),]

dates<- subset$Date
times <- subset$Time
time_variable<-paste(dates, times)
Full_time<- strptime(time_variable, "%Y-%m-%d %H:%M:%S")
final<- cbind(Full_time, subset[,3:9])

par(cex.axis=0.75, cex.lab=0.75)
plot(final$Global_active_power,type="l", main="", xlab="", ylab="Global Active Power (kilowatts)", xaxt="n")
axis(1, at=c(1,1441,2880), labels=c("Thu", "Fri", "Sat"))

dev.copy(png,file="plot2.png")
dev.off()

