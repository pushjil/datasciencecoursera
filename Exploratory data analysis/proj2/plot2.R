library(dplyr)
## read each of the two files using the readRDS() function in R
NEI <- readRDS("summarySCC_PM25.rds")
##Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510")
##from 1999 to 2008? Use the base plotting system to make a plot answering this question.
NEI<-tbl_df(NEI)
baltimore_NEI<-filter(NEI,fips=="24510")
by_year<-group_by(baltimore_NEI,year)
summdata<-summarize(by_year,sum_emissions=sum(Emissions))
png("plot2.png")
plot(summdata$year,summdata$sum_emissions,main="Emission over time @ Baltimore",xlab="year",ylab="Emissions")
abline(lm(summdata$sum_emissions~summdata$year), col="red")
lines(lowess(summdata$year,summdata$sum_emissions),col="blue")
dev.off()
