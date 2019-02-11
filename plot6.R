> setwd("./R/Coursera/Exploratory Data Analysis/Course Project 2")
> library("data.table")
data.table 1.11.8  Latest news: r-datatable.com
> path <- getwd()
> download.file(url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip",
+ destfile = paste(path, "PM2.5Files.zip", sep = "/"))
trying URL 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip'
Content type 'application/zip' length 30643310 bytes (29.2 MB)
downloaded 29.2 MB

> unzip(zipfile = "PM2.5Files.zip")
> SCC <- data.table::as.data.table(x = readRDS(file = "Source_Classification_Code.rds"))
> NEI <- data.table::as.data.table(x = readRDS(file = "summarySCC_PM25.rds"))

> library(ggplot2)
> condition <- grepl("vehicle", SCC[, SCC.Level.Two], ignore.case=TRUE)
> vehiclesSCC <- SCC[condition, SCC]
> vehiclesNEI <- NEI[NEI[, SCC] %in% vehiclesSCC,]
> 
> vehiclesBaltimoreNEI <- vehiclesNEI[fips == "24510",]
> vehiclesBaltimoreNEI[, city := c("Baltimore City")]
> vehiclesLosAngelesNEI <- vehiclesNEI[fips == "24510",]
> vehiclesLosAngelesNEI[, city := c("Los Angeles")]
> 
> bothNEI <- rbind(vehiclesBaltimoreNEI,vehiclesLosAngelesNEI)
> 
> png(filename = "plot6.png",width = 480, height = 480,units = "px",)
> ggplot(bothNEI, aes(x=factor(year), y=Emissions))+
+ geom_bar(aes(fill=year),stat="identity",fill="grey", width=0.5)+
+ facet_grid(scales="free", space="free", .~city)+
+ xlab("Year")+
+ ylab("Total Emissions")+
+ labs(title="Los Angeles and Baltimore City Vehicle Emissions (1999-2008)")
> dev.off()
null device 
          1 
