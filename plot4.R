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

png(file="plot4.png")

par(mfrow=c(2,2))
plot(final$Global_active_power,type="l", main="", xlab="", ylab="Global Active Power", xaxt="n")
axis(1, at=c(1,1441,2880), labels=c("Thu", "Fri", "Sat")) 

plot(final$Voltage, type="l", main="", xlab="datetime", ylab="Voltage", xaxt="n")
axis(1, at=c(1,1441,2880), labels=c("Thu", "Fri", "Sat"))

plot(final$Sub_metering_1,type="l", main="", xlab="", ylab="Energy sub metering", xaxt="n")
points(final$Sub_metering_2,type="l", col="red")
points(final$Sub_metering_3,type="l", col="blue")
axis(1,at=c(1,1441,2880), labels=c("Thu", "Fri", "Sat"))
legend("topright" ,legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, col=c("black", "red", "blue"), bty="n")

plot(final$Global_reactive_power, type="l", main="", xlab="datetime", ylab="Global_reactive_power", xaxt="n")
axis(1, at=c(1,1441, 2880), labels=c("Thu", "Fri", "Sat"))

dev.off()