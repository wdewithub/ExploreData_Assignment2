#setwd(dir='C:/Users/ntpuser3/datascience/Exploring the Data/ExploreData_Assignment2')
#1. Check if inputfiles are present and if so, read them in
if (file.exists("./summarySCC_PM25.rds")) {NEI <- readRDS("summarySCC_PM25.rds")}
if (file.exists("./Source_Classification_Code.rds")) {SCC <- readRDS("Source_Classification_Code.rds")}

#Select motor vehicle emission sources from Baltimore City
a <- grepl("motor",tolower(SCC$Short.Name))
b <- SCC[a,c(1,3)]
motor <- b[c,]  #138 sources
motor_sel <- subset(NEI,NEI$SCC %in% motor[,1] & fips=="24510") #in Baltimore only 24 of these occur
motor_sel_base <- subset(motor_sel,year==1999)

#How did motor vehicle emissions evolved in Baltimore City between 1999 and 2008
png(filename="plot5.png",height=600,width=600)
par(cex.main=0.9)
boxplot(data=motor_sel,motor_sel$Emissions~motor_sel$year,main="After an initial strong decline, in 2008 the median PM2.5 emission nearly returned to its 1999-level", xlab="year", ylab="PM2.5 emission (tons)")
abline(h=median(motor_sel_base$Emissions),col='red', lwd=2, lty=2)
dev.off()
