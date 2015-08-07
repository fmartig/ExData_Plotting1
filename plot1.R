library(lubridate)
library(dplyr)
#1. read the data
consumption <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings="?", colClasses= c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric","numeric"), nrows=70570)
elec<-tbl_df(consumption)

#2. subset the data
elec$Date<-dmy(elec$Date)
subset<-elec[grepl('2007-02-01|2007-02-02', elec$Date),]

#3. make the histogram
par(cex.axis=0.75, cex.lab=0.75, cex.main=0.75)
hist(subset$Global_active_power,main="Global Active Power", xlab="Global Active Power (kilowatts)", col='red')

#4. copy it into a png file
dev.copy(png, file="plot1.png")
dev.off()
