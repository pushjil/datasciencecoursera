mydata = read.table("household_power_consumption.txt",header=TRUE,stringsAsFactors=F,sep=";")
data=subset(mydata,Date=="1/2/2007" | Date=="2/2/2007")
library(lubridate)
data$Date<-dmy(data$Date)
data$DateTime<-paste(data$Date,data$Time)
data$DateTime<-strptime(data$DateTime,format="%Y-%m-%d %H:%M:%S")
png("plot4.png")
par(mfrow=c(2,2))
##1st plot
plot(data$DateTime,data$Global_active_power,type="l",ylab="Global Active Power",xlab="")
## 2nd plot
plot(data$DateTime,data$Voltage,type="l",ylab="Voltage",xlab="datetime")
##3rd plot
plot(data$DateTime,data$Sub_metering_1,type="l",ylab="Energy sub metering",xlab="")
lines(data$DateTime,data$Sub_metering_2,type="l",col="red")
lines(data$DateTime,data$Sub_metering_3,type="l",col="blue")
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red","blue"),pch="l")
## 4th plot
plot(data$DateTime,data$Global_reactive_power,type="l",ylab="Global_reactive_power",xlab="datetime")
dev.off()
