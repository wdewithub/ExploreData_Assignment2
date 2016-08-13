setwd(dir='C:/Users/ntpuser3/datascience/Exploring the Data/ExploreData_Assignment2')
#1. Check if inputfiles are present and if so, read them in
if (file.exists("./summarySCC_PM25.rds")) {NEI <- readRDS("summarySCC_PM25.rds")}
if (file.exists("./Source_Classification_Code.rds")) {SCC <- readRDS("Source_Classification_Code.rds")}

#Calculate total PM2.5 emission by type and year for Baltimore City
library(dplyr)
baltimore <- subset(NEI, fips=="24510")
baltimore <- baltimore %>% mutate(year=as.factor(as.character(year)), type=as.factor(type))
table(baltimore$year,baltimore$type)
#As one has very different number of observations by type and by year, we'll compare the average
#evolution
totals <- baltimore %>% group_by(year,type) %>% summarise(mean(Emissions, na.rm=TRUE)) 
names(totals)=c('year','type','mean')

#Create a plot to show which sources increase and which decrease between 1999 and 2008 in Baltimore City
png(filename="plot3.png", width=800, height=800)
library(ggplot2)
g <- ggplot(data=totals,aes(x=year,y=mean, group=type))
g + theme_bw()+facet_grid(.~type)+geom_point()+geom_line()+labs(x="year", y="Average PM2.5 emissions", title="With the exception of point sources, all sources continuously decreased PM2.5 emission on average")
#Alternative code with coloured timelines in one plot
#g <- ggplot(data=totals,aes(x=totals$year,y=totals$totaal, color=type, group=type))
#g+theme_bw()+geom_point()+geom_line()+labs(x="year", y="total PM2.5 emissions", title="With the exception of point sources, all sources decreased PM2.5 emission")
dev.off()