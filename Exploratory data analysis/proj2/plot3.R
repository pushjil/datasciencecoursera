library(dplyr)
library(ggplot2)
## read each of the two files using the readRDS() function in R
NEI <- readRDS("summarySCC_PM25.rds")

##Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad)
##variable, which of these four sources have seen decreases in emissions from 1999-2008
##for Baltimore City? Which have seen increases in emissions from 1999-2008?
##Use the ggplot2 plotting system to make a plot answer this question.
NEI<-tbl_df(NEI)
baltimore_NEI<-filter(NEI,fips=="24510")
by_year<-group_by(baltimore_NEI,year,type)
summdata<-summarize(by_year,sum_emissions=sum(Emissions))
##ggplot2

png("plot3.png")
sp <- ggplot(summdata, aes(x=year, y=sum_emissions,group=type,color=type,shape=type)) + geom_point(size=4)
sp+facet_wrap(~type,ncol=2)+geom_point(stat="identity")+ggtitle("Emission over time @ Baltimore for 4 types of Sources")+ylab("Total-Emissions")
##qplot(year,sum_emissions,data=summdata,color=type,shape=type,main="Emission over time @ Baltimore city for each type ")
##qplot(year,sum_emissions,data=summdata,facets=summdata[2],color=type,shape=type,main="Emission over time @ Baltimore city-Separate grid for each type")
dev.off()
