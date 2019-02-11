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

> baltimore <- (NEI[NEI$fips == "24510",])
> baltimore_emission <- aggregate(Emissions~year, data=baltimore, FUN=sum)
> png(filename = "plot2.png", width = 480, height = 480, units = "px")
> barplot(baltimore_emission$Emissions, names.arg=baltimore_emission$year,
+ xlab = "Year", ylab = "Baltimore Total Emissions", main = "Baltimore Annual Emissions (1999-2008)")
> dev.off()
null device 
          1 
> 
