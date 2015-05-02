## plot6.R
## This R file reads the PM2.5 emmission data and answer this question:
## Compare emissions from motor vehicle sources in Baltimore City 
## with emissions from motor vehicle sources in Los Angeles County, 
## California (fips == "06037"). Which city has seen greater changes 
## over time in motor vehicle emissions?

## How to run this file:
# 1. Set the current working directory as the directory containing this file.
# 2. Please make sure you've install the "ggplot2" package and add it to your 
#    package list by:
#    install.packages("ggplot2")
#    library(ggplot2)
# 3. Please make sure the source data lies in the same directory as the R code.
# 4. Source this file by typing in:
#    source("plot6.R")
#    And press enter/return. This will run the code and produce plot6.png
#    in your working directory.
# 5. If sourcing the file cannot create the correct graph in plot6.png,
#    (The most common case is that the code creates a blank png file)
#    then please open this file in your R platform and run it sentence by
#    sentence.
#    I do this in RStudio by selecting all the code and click "Run".

library(ggplot2)
# 1. Read the data:
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# 2. Only Baltimore and Los Angeles will be counted in.
fips <- c("24510","06037")
# 3. Only PM2.5 emissions from motor vehicles will be counted in.
motorRelated <- levels(SCC$EI.Sector)[43:52]

# 4. Subset the SCC data. Only use the motor vehicles related items.
SCC <- SCC[SCC$EI.Sector %in% motorRelated,]

# 5. Subset the NEI data. Only use the motor vehicles related 
#    & Baltimore/LosAngeles items.
NEI <- NEI[NEI$fips %in% fips,]
NEI <- NEI[NEI$SCC %in% SCC$SCC,] 
NEI$year <- as.factor(NEI$year)

# 6. Store the data from Baltimore city to NEIbal
#    and the data from Los Angeles county to NEIlos:
NEIbal <- NEI[NEI$fips == fips[1],]
NEIlos <- NEI[NEI$fips == fips[2],]

# 7. Split the data by year:
NEIbal <- split(NEIbal,NEIbal$year)
NEIlos <- split(NEIlos,NEIlos$year)

# 8. Calculate the sum of emissions by year.
resultBAL <- sapply(NEIbal,function(x) {
    sum(x$Emissions)
})
resultLOS <- sapply(NEIlos,function(x) {
    sum(x$Emissions)
})

# 9. Combine the results to one data frame
result <- data.frame(BAL = resultBAL, LOS = resultLOS)

# 10. Plot the graph showing the comparison of changes
#     and output to "plot6.png"
png("plot6.png",width=1500,height=1000)
par(mfrow=c(1,2))
# Baltimore:
plot(x=names(resultBAL), y=resultBAL,
     xlab="Year",
     ylab="PM2.5 Emissions from Motor Vehicles",
     type="b",
     main="Baltimore")
plot(x=names(resultLOS), y=resultLOS,
     xlab="Year",
     ylab="PM2.5 Emissions from Motor Vehicles",
     type="b",
     main="Los Angeles")
dev.off()

