#setwd(dir='C:/Users/ntpuser3/datascience/Exploring the Data/ExploreData_Assignment2')
#1. Check if inputfiles are present and if so, read them in
if (file.exists("./summarySCC_PM25.rds")) {NEI <- readRDS("summarySCC_PM25.rds")}
if (file.exists("./Source_Classification_Code.rds")) {SCC <- readRDS("Source_Classification_Code.rds")}

#2.Calculate total PM2.5 emissions in Baltimore City

(subset functie gebruiken)

#3.Create a timelineplot fo the PM2.5 evolution in Baltimore City

(analoog aan plot1)