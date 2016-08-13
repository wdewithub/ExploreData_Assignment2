#setwd(dir='C:/Users/ntpuser3/datascience/Exploring the Data/ExploreData_Assignment2')
#1. Check if inputfiles are present and if so, read them in
if (file.exists("./summarySCC_PM25.rds")) {NEI <- readRDS("summarySCC_PM25.rds")}
if (file.exists("./Source_Classification_Code.rds")) {SCC <- readRDS("Source_Classification_Code.rds")}
library(dplyr)
library(ggplot2)

#Select motor vehicle emission sources from Baltimore City
a <- grepl("motor",tolower(SCC$Short.Name))
motor <- SCC[a,c(1,3)] #138 sources
motor_sel <- subset(NEI,NEI$SCC %in% motor[,1] & fips=="24510") #in Baltimore only 34 of these occur

#How did motor vehicle emissions evolved in Baltimore City between 1999 and 2008
totals <- motor_sel %>% mutate(year=as.factor(year)) %>% group_by(year) %>% summarise(mean(Emissions))
names(totals) <- c("year","emission")

png(filename="plot5.png",height=850,width=850)
g <- ggplot(totals, aes(x=levels(year),y=emission))
g <- g + geom_bar(stat="identity",aes(fill="red"))+theme_bw()
g <- g+labs(x="year",y="mean PM2.5 emission (in tons)",title="After a strong increase, in 2008 total PM2.5 emission from coal combustion declined again slightly under its original level of 1999")
g+geom_text(aes(label=round(emission,2), size=3, hjust=0.5, vjust=1.5))+guides(fill=FALSE, size=FALSE)
dev.off()
