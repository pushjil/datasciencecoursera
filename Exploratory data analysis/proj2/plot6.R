## read each of the two files using the readRDS() function in R
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
##Emissions table to the actual name of the PM2.5 source.
##The sources are categorized in a few different ways from more general to more specific
##and you may choose to explore whatever categories you think are most useful.
##For example, source "10100101" is known as "Ext Comb /Electric Gen /Anthracite Coal /Pulverized Coal".

##Compare emissions from motor vehicle sources in Baltimore City with emissions 
##from motor vehicle sources in Los Angeles County, California (fips == "06037"). 
##Which city has seen greater changes over time in motor vehicle emissions?

 
library(dplyr)
library(ggplot2)
NEI<-tbl_df(NEI)
SCC<-tbl_df(SCC)
## having Baltimore(fips==24510) and LA(fips==06037) data only.
NEI<-filter(NEI,fips=="06037" | fips=="24510")
## to getmotor vehicle sources from SCC table- from Short.Name of SCC
##SCC.Level.One= "Mobile Sources"  - get all the Mobile sources from Level 1
Level1<-subset(SCC,grepl("Mobile Sources",SCC.Level.One))
##Short.Name="Highway Veh" and filter vehicles from that using Short.Name
MotorVeh<-subset(Level1,grepl("Highway Veh",Short.Name))
 
## match SCC from NEI and SCC(here-subset MotorVeh) and add Short.Name Column to NEI
NEI$Short.name<-MotorVeh[match(NEI$SCC,MotorVeh$SCC),3]

X<-filter(NEI,!is.na(Short.name))
## grouping 
by_year<-group_by(X,fips,year)
summdata<-summarize(by_year,sum_emissions=sum(Emissions))

##Plot
png("plot6.png")
## to get name for the legends
summdata$fips<-factor(summdata$fips,levels=c("06037","24510"),labels=c("Los Angeles","Baltimore"))
##plotting
sp <- ggplot(summdata, aes(x=year, y=sum_emissions,group=fips,color=fips,shape=fips)) + geom_point(size=4)
sp1<-sp+ggtitle("Emissions from motor vehicle sources over time - Baltimore Vs LA")+ylab("Total-Emissions")
##Rename the title of each legend to the same title so 3 US county renaming
sp2<-sp1+scale_linetype_discrete("US County") +scale_shape_discrete("US County") +scale_colour_discrete("US County")
sp2
dev.off()
## group by fips also in summdata. then do.
##sp1+scale_shape_discrete(name  =" U.S. county",breaks=c("06037", "24510"),labels=c("Los Angeles", "Baltomore"))
