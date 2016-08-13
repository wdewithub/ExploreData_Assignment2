#setwd(dir='C:/Users/ntpuser3/datascience/Exploring the Data/ExploreData_Assignment2')
#1. Check if inputfiles are present and if so, read them in
if (file.exists("./summarySCC_PM25.rds")) {NEI <- readRDS("summarySCC_PM25.rds")}
if (file.exists("./Source_Classification_Code.rds")) {SCC <- readRDS("Source_Classification_Code.rds")}

#2.Calculate total PM2.5 emissions in Baltimore City

library(dplyr)
baltimore <- subset(NEI, fips=="24510")
baltimore <- baltimore %>% mutate(year=as.factor(as.character(year)))
totals <- with(baltimore,tapply(Emissions,year,sum, na.rm=TRUE))

#3.Create a timelineplot fo the PM2.5 evolution in Baltimore City
png(filename="plot2.png", width=580, height=580)
par(cex.lab=0.90, cex.main=0.90)
with(baltimore,plot(levels(year),totals,type="b",pch=16, xaxt="n", ylim=c(1500,3500), xlab="year",ylab="total PM2.5 emissions in Baltimore City (tons)"))
title(main="Total PM2.5 emissions nearly halved in Baltimore City between 1999 and 2008")
text(levels(baltimore$year),totals, labels=round(totals,1), cex=0.9, pos=3)
axis(side=1,labels=levels(baltimore$year),at=seq(1999, 2008, by=3))
dev.off()