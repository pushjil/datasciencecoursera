library(dplyr)
## read each of the two files using the readRDS() function in R
NEI <- readRDS("summarySCC_PM25.rds")
# total emissions from PM2.5 decreased in the United States from 1999 to 2008?
#Using the base plotting system, make a plot showing the total PM2.5 emission from 
# all sources for each of the years 1999, 2002, 2005, and 2008.
NEI<-tbl_df(NEI)
by_year<-group_by(NEI,year)
summdata<-summarize(by_year,sum_emissions=sum(Emissions))
png("plot1.png")
plot(summdata$year,summdata$sum_emissions,main="Emission over time",xlab="year",ylab="Emissions")
abline(lm(summdata$sum_emissions~summdata$year), col="red")
lines(lowess(summdata$year,summdata$sum_emissions),col="blue")
dev.off()
