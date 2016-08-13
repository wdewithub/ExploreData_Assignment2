#setwd(dir='C:/Users/ntpuser3/datascience/Exploring the Data/ExploreData_Assignment2')
#1. Check if inputfiles are present and if so, read them in
if (file.exists("./summarySCC_PM25.rds")) {NEI <- readRDS("summarySCC_PM25.rds")}
if (file.exists("./Source_Classification_Code.rds")) {SCC <- readRDS("Source_Classification_Code.rds")}

#Select coal-combustion-related sources across the US
a <- grepl("coal",tolower(SCC$Short.Name))
b <- SCC[a,c(1,3)]
c <- grepl("comb",tolower(b[,2]))
coal_comb <- b[c,]  #91 coal-combustion related sources possible
coal_comb_sel <- subset(NEI,NEI$SCC %in% coal_comb[,1]) #in US only 76 of these occur

#How have PM2.5 emissions from these 76 coal-combustion related sources changed between 1999-2008 ?
library(dplyr)
library(ggplot2)
totals <- coal_comb_sel %>% mutate(year=as.factor(year)) %>% group_by(year) %>% summarise(mean(Emissions))
names(totals) <- c("year","emission")
png(filename="plot4.png", width=775, height=775)
g <- ggplot(totals, aes(x=levels(year),y=emission))
g <- g + geom_bar(stat="identity",aes(fill="red"))+theme_bw()
g <- g+labs(x="year",y="average PM2.5 emission (in tons)",title="On average PM2.5 emission from coal combustion declined with 60% between 1999 and 2008")
g+geom_text(aes(label=round(emission,1), size=3, hjust=0.5, vjust=1.5))+guides(fill=FALSE, size=FALSE)
dev.off()