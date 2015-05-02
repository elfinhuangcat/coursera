## plot1.R
## This R file reads the PM2.5 emmission data and answer this question:
## Have total emissions from PM2.5 decreased in the United States from 
## 1999 to 2008? Using the base plotting system, make a plot showing the 
## total PM2.5 emission from all sources for each of the years 1999, 
## 2002, 2005, and 2008.

## How to run this file:
# 1. Set the current working directory as the directory containing this file.
# 2. Source this file by typing in:
#    source("plot1.R")
#    And press enter/return. This will run the code and produce plot1.png
#    in your working directory.

# Read the data:
NEI <- readRDS("summarySCC_PM25.rds")

# Calculate the total PM2.5 emission in each year.
# In order to use the split() function, we need to 
# transform year as factor.
NEI$year <- as.factor(NEI$year)
# We only need these two columns
NEI <- NEI[,c("Emissions","year")]
# Split the dataframe by year
NEIbyyear <- split(NEI,NEI$year)
# Calculate the sum of PM2.5 emission of each year.
result <- sapply(NEIbyyear,function(x) {
    sum(x$Emissions)
})

# Create the png file.
png("plot1.png",bg="transparent")
plot(x=as.character(names(result)),y=result,type="b",
     xlab="year",
     ylab="PM2.5 emissions (in tons)",
     main="Change of PM2.5 Emissions by Year")
dev.off()