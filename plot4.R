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
> combustion <- grepl(pattern = "combustion",x = SCC$SCC.Level.One,ignore.case = TRUE)
> coal <- grepl(pattern = "coal",x = SCC$SCC.Level.Four,ignore.case = TRUE)
> combustioncoal <- (combustion & coal)
> combustionSCC <- SCC[combustioncoal,]$SCC
> combustionNEI <- NEI[NEI$SCC %in% combustionSCC,]
> 
> png(filename = "plot4.png",width = 480, height = 480,units = "px",)
> 
> ggplot(data = combustionNEI, aes(factor(year), Emissions)) +
+ geom_bar(stat = "identity",fill = "grey", width = 0.5)+
+ xlab("Year")+
+ ylab("Total Emissions")+
+ labs(title="Coal Combustion Related Sources Emissions(1999-2008)")
> dev.off()
null device 
          1 
> 
