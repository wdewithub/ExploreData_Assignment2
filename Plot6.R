#setwd(dir='C:/Users/ntpuser3/datascience/Exploring the Data/ExploreData_Assignment2')
#1. Check if inputfiles are present and if so, read them in
if (file.exists("./summarySCC_PM25.rds")) {NEI <- readRDS("summarySCC_PM25.rds")}
if (file.exists("./Source_Classification_Code.rds")) {SCC <- readRDS("Source_Classification_Code.rds")}
library(dplyr)
library(ggplot2)

#Select motor vehicle emission sources from Baltimore City and LA
a <- grepl("motor",tolower(SCC$Short.Name))
motor <- SCC[a,c(1,3)]
motor_sel_balti <- subset(NEI,NEI$SCC %in% motor[,1] & fips=="24510") #in Baltimore only 34 of these occur
motor_sel_la <- subset(NEI,NEI$SCC %in% motor[,1] & fips=="06037") #in LA 39 sources of motor vehicles emission

#Compare the evolution of total PM2.5 emissions from motor vehicle emissions in both counties
totals_balti <- motor_sel_balti %>% mutate(year=as.factor(year)) %>% group_by(year) %>% summarise(mean(Emissions,na.rm=TRUE))
names(totals_balti) <- c('year','mean')
totals_la <- motor_sel_la %>% mutate(year=as.factor(year)) %>% group_by(year) %>% summarise(mean(Emissions,na.rm=TRUE))
names(totals_la) <- c('year','mean')

png(filename="plot6.png",height=800, width=800)
par(cex.lab=0.9,cex.main=0.95)
with(totals_balti,plot(levels(year),mean,pch=16, type="l", xaxt='n',xlab='year',ylab='average PM2.5 emission motor vechicles (in tons)', ylim=c(0,20)))
with(totals_la,lines(levels(year),mean,pch=17, col='red'))
title(main="While PM2.5 emission by motor cycles went back around its original level in Baltimore, they tripled on average in LA between 1999 and 2008")
axis(side=1,labels=levels(totals_balti$year) ,at=seq(1999, 2008, by=3))
legend(x="topleft",legend=c("LA", "Baltimore City"),col=c("red","black"),lty=1)
text(levels(totals_balti$year),totals_balti$mean, labels=round(totals_balti$mean,2), cex=0.9, pos=3)
text(levels(totals_la$year),totals_la$mean, labels=round(totals_la$mean,2), cex=0.9, pos=3)
dev.off()