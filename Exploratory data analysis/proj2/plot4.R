## read each of the two files using the readRDS() function in R
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
##Emissions table to the actual name of the PM2.5 source.
##The sources are categorized in a few different ways from more general to more specific
##and you may choose to explore whatever categories you think are most useful.
##For example, source "10100101" is known as "Ext Comb /Electric Gen /Anthracite Coal /Pulverized Coal".

##Across the United States, how have emissions from coal combustion-related sources changed
##from 1999-2008?
##SCC$Short.Name- take this 
library(dplyr)
NEI<-tbl_df(NEI)
SCC<-tbl_df(SCC)
## to get coal related combustion type from SCC table- from Short.Name of SCC
Coal_related_SCC<-subset(SCC,grepl("Coal", Short.Name))
##Combustion related within coal.
Coal_comb<-subset(Coal_related_SCC,grepl("Comb",Short.Name))
## match SCC from NEI and SCC(here-subset Coal_comb) and add Short.Name Column to NEI
NEI$Short.name<-Coal_comb[match(NEI$SCC,Coal_comb$SCC),3]
X<-filter(NEI,!is.na(Short.name))
##grouping
by_year<-group_by(X,year)
summdata<-summarize(by_year,sum_emissions=sum(Emissions))
##Plot
png("plot4.png")
plot(summdata$year,summdata$sum_emissions,main="Emission from coal_combustion related source over time",xlab="year",ylab="Emissions")
abline(lm(summdata$sum_emissions~summdata$year), col="red")
lines(lowess(summdata$year,summdata$sum_emissions),col="blue")
dev.off()
