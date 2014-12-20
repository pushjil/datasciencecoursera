## read each of the two files using the readRDS() function in R
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
##Emissions table to the actual name of the PM2.5 source.
##The sources are categorized in a few different ways from more general to more specific
##and you may choose to explore whatever categories you think are most useful.
##For example, source "10100101" is known as "Ext Comb /Electric Gen /Anthracite Coal /Pulverized Coal".

##How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City? 

library(dplyr)
NEI<-tbl_df(NEI)
SCC<-tbl_df(SCC)
baltimore_NEI<-filter(NEI,fips=="24510")
## to getmotor vehicle sources from SCC table- from Short.Name of SCC
##SCC.Level.One= "Mobile Sources"  - get all the Mobile sources from Level 1
Level1<-subset(SCC,grepl("Mobile Sources",SCC.Level.One))
##Short.Name="Highway Veh"
MotorVeh<-subset(Level1,grepl("Highway Veh",Short.Name))
## from here
## match SCC from NEI and SCC(here-subset MotorVeh) and add Short.Name Column to NEI

baltimore_NEI$Short.name<-MotorVeh[match(baltimore_NEI$SCC,MotorVeh$SCC),3]
X<-filter(baltimore_NEI,!is.na(Short.name))
##grouping
by_year<-group_by(X,year)
summdata<-summarize(by_year,sum_emissions=sum(Emissions))
##Plot
png("plot5.png")
plot(summdata$year,summdata$sum_emissions,main="Emissions from motor vehicle sources over time @ Baltimore",xlab="year",ylab=" MotorVeh. Emissions")
abline(lm(summdata$sum_emissions~summdata$year), col="red")
lines(lowess(summdata$year,summdata$sum_emissions),col="blue")
dev.off()
