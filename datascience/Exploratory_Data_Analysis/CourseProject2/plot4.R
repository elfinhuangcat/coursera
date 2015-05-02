## plot4.R
## This R file reads the PM2.5 emmission data and answer this question:
## Across the United States, how have emissions from coal 
## combustion-related sources changed from 1999-2008?

## How to run this file:
# 1. Set the current working directory as the directory containing this file.
# 2. Please make sure the source data lies in the same directory as the R code.
# 3. Source this file by typing in:
#    source("plot4.R")
#    And press enter/return. This will run the code and produce plot4.png
#    in your working directory.
# 4. If sourcing the file cannot create the correct graph in plot4.png,
#    (The most common case is that the code creates a blank png file)
#    then please open this file in your R platform and run it sentence by
#    sentence.
#    I do this in RStudio by selecting all the code and click "Run".

# 1. Read the data:
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# By inspecting the data in `SCC`, I found that there are only 59 levels
# of the variable `EI.Sector`, and there are 3 levels related to coal
# combustion: 
# [13] "Fuel Comb - Comm/Institutional - Coal"
# [18] "Fuel Comb - Electric Generation - Coal"
# [23] "Fuel Comb - Industrial Boilers, ICEs - Coal"
# So I will make the graph according to the value of this variable.

# 2. Subset the SCC data, only use the SCC items that are 
#    coal combustion related.
coalCombRelated <- levels(SCC$EI.Sector)[c(13,18,23)]
SCC <- SCC[SCC$EI.Sector %in% coalCombRelated,]

# 3. Subset the NEI data, only use the NEI$SCC in SCC.
NEI <- NEI[NEI$SCC %in% SCC$SCC,]

# 4. Calculate the PM2.5 emission of each year:
NEI$year <- as.factor(NEI$year)
NEIbyyear <- split(NEI,NEI$year)
result <- lapply(NEIbyyear,function(x) {
    sum(x$Emissions)
})
result <- unlist(result)

# 5. Output the plot to "plot4.png":
png("plot4.png")
plot(x = names(result), y = result,
     xlab = "Year",
     ylab = "PM2.5 Emissions (in tons)",
     main = "Change of CoalComb PM2.5 Emissions by Year",
     type = "b")
dev.off()
