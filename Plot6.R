#setwd(dir='C:/Users/ntpuser3/datascience/Exploring the Data/ExploreData_Assignment2')
#1. Check if inputfiles are present and if so, read them in
if (file.exists("./summarySCC_PM25.rds")) {NEI <- readRDS("summarySCC_PM25.rds")}
if (file.exists("./Source_Classification_Code.rds")) {SCC <- readRDS("Source_Classification_Code.rds")}

#Select motor vehicle emission sources from Baltimore City and LA
a <- grepl("motor",tolower(SCC$Short.Name))
b <- SCC[a,c(1,3)]
motor <- b[c,]  #138 sources
motor_sel_balti <- subset(NEI,NEI$SCC %in% motor[,1] & fips=="24510") #in Baltimore only 24 of these occur
motor_sel_la <- subset(NEI,NEI$SCC %in% motor[,1] & fips=="06037") #in LA 39 sources of motor vehicles emission

#Compare the evolution of total PM2.5 emissions from motor vehicle emissions in both counties
totals_balti <- motor_sel_balti %>% mutate(year=as.factor(year)) %>% group_by(year) %>% summarise(sum(Emissions,na.rm=TRUE))
names(totals_balti) <- c('year','totaal')
totals_la <- motor_sel_la %>% mutate(year=as.factor(year)) %>% group_by(year) %>% summarise(sum(Emissions,na.rm=TRUE))
names(totals_la) <- c('year','totaal')

png(filename="plot6.png",height=750, width=750)
par(cex.lab=0.9,cex.main=0.95)
with(totals_balti,plot(levels(year),totaal,pch=16, type="l", xaxt='n',xlab='year',ylab='PM2.5 emission motor vechicles (in tons)', ylim=c(0,16)))
with(totals_la,lines(levels(year),totaal,pch=17, col='red'))
title(main="While PM2.5 emission by motor cycles remained stable in Baltimore, it nearly tripled in LA between 1999 and 2008")
axis(side=1,labels=levels(totals_balti$year) ,at=seq(1999, 2008, by=3))
legend(x="right",legend=c("LA", "Baltimore City"),col=c("red","black"),lty=1)
text(levels(totals_balti$year),totals_balti$totaal, labels=round(totals_balti$totaal,2), cex=0.9, pos=3)
text(levels(totals_la$year),totals_la$totaal, labels=round(totals_la$totaal,2), cex=0.9, pos=1)
dev.off()