setwd(dir='C:/Users/ntpuser3/datascience/Exploring the Data/ExploreData_Assignment2')
#1. Check if inputfiles are present and if so, read them in
if (file.exists("./summarySCC_PM25.rds")) {NEI <- readRDS("summarySCC_PM25.rds")}
if (file.exists("./Source_Classification_Code.rds")) {SCC <- readRDS("Source_Classification_Code.rds")}

#Calculate total PM2.5 emission by type and year for Baltimore City
library(dplyr)
baltimore <- subset(NEI, fips=="24510")
baltimore <- baltimore %>% mutate(year=as.factor(as.character(year)), type=as.factor(type))
#baltimore <- baltimore %>% mutate(year=as.factor(as.character(year)))
totals <- baltimore %>% group_by(year,type) %>% summarise(sum(Emissions, na.rm=TRUE)) 
names(totals)=c('year','type','totaal')

#Create a plot to show which sources increase and which decrease between 1999 and 2008 in Baltimore City
png(filename="plot3.png", width=580, height=580)
library(ggplot2)
g <- ggplot(data=totals,aes(x=year,y=totaal, group=type))
g + theme_bw()+facet_grid(.~type)+geom_point()+geom_line()+labs(x="year", y="total PM2.5 emissions", title="With the exception of point sources, all sources decreased PM2.5 emission")
#Alternative code with coloured timelines in one plot
#g <- ggplot(data=totals,aes(x=totals$year,y=totals$totaal, color=type, group=type))
#g+theme_bw()+geom_point()+geom_line()+labs(x="year", y="total PM2.5 emissions", title="With the exception of point sources, all sources decreased PM2.5 emission")
dev.off()