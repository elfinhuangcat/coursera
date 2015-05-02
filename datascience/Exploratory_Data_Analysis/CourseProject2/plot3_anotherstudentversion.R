# Plot3 : Another student version.
library(ggplot2)

#Setup files path
srcPath <- "./"

#Reads source files
NEI <- readRDS(paste0(srcPath,"summarySCC_PM25.rds"))

#Filters Baltimore city
BALT <- NEI[which(NEI$fips == "24510"),]

#Aggregates Baltimore emissions by year and type
d <- aggregate(BALT$Emissions, by=list(Type=BALT$type, Year=BALT$year), FUN=sum)

#Draw graph and saves it to file
png(file = paste0(srcPath,"plot3.png"), width = 480, height = 480, units = "px")
qplot(x=Year, y=x, data=d,    geom="line", color=Type, ylab="Emission tones")	
dev.off() 