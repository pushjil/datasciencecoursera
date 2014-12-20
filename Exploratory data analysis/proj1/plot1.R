mydata = read.table("household_power_consumption.txt",header=TRUE,stringsAsFactors=F,sep=";")
data=subset(mydata,Date=="1/2/2007" | Date=="2/2/2007")
library(lubridate)
data$Date<-dmy(data$Date)

png("plot1.png")

hist(as.numeric(data$Global_active_power),col = "red",main= "Global Active Power",xlab="Global Active Power(kilowatts)")
dev.off()
