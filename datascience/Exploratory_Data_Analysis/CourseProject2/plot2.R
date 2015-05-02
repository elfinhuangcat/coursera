## plot2.R
## This R file reads the PM2.5 emmission data and answer this question:
## Have total emissions from PM2.5 decreased in the Baltimore City, 
## Maryland (fips == "24510") from 1999 to 2008? Use the base plotting 
## system to make a plot answering this question.

## How to run this file:
# 1. Set the current working directory as the directory containing this file.
# 2. Source this file by typing in:
#    source("plot2.R")
#    And press enter/return. This will run the code and produce plot2.png
#    in your working directory.

# Read the data:
NEI <- readRDS("summarySCC_PM25.rds")

# Calculate the total PM2.5 emission in each year.
# In order to use the split() function,
# we need to transform year as factor.
NEI$year <- as.factor(NEI$year)
# We only need the data of Baltimore.
NEI <- NEI[NEI$fips == "24510",]
# Split the dataframe by year
NEIbyyear <- split(NEI,NEI$year)
# Calculate the sum of PM2.5 emission of each year.
result <- sapply(NEIbyyear,function(x) {
    sum(x$Emissions)
})

# Create the plot and save it as a png file.
png("plot2.png",bg="transparent")
plot(x=as.character(names(result)),y=result,type="b",
     xlab="year",
     ylab="PM2.5 emission (in tons)",
     main = "PM2.5 emission in Baltimore City from 1999 to 2008")
dev.off()