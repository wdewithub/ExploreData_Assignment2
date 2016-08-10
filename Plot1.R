#setwd(dir='C:/Users/ntpuser3/datascience/Exploring the Data/ExploreData_Assignment2')
#1. Check if inputfiles are present and if so, read them in
if (file.exists("./summarySCC_PM25.rds")) {NEI <- readRDS("summarySCC_PM25.rds")}
if (file.exists("./Source_Classification_Code.rds")) {SCC <- readRDS("Source_Classification_Code.rds")}

#2. Calculate total PM2.5 pollution by year in the US
total <- with(NEI,tapply(Emissions,year,sum, na.rm=TRUE))

#3. Create timelineplot of total PM2.5 pollution evolution in the US
png(filename="plot1.png", width=480, height=480)
par(cex.lab=0.90)
with(NEI,plot(levels(as.factor(year)),total/1000, type="b", pch=16, xlab="year",
              ylab="total PM2.5 emission (in K tons)", xaxt="n", ylim=c(min(total/1000)-1000,max(total/1000)+1000)))
title(main="Total PM2.5 pollution declined in US between 1999 and 2008")
axis(side=1,labels=levels(as.factor(NEI$year)) ,at=seq(1999, 2008, by=3))
text(levels(as.factor(NEI$year)),total/1000, labels=round(total/1000), cex=0.9, pos=3)
dev.off()

