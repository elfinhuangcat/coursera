## plot5.R
## This R file reads the PM2.5 emmission data and answer this question:
## How have emissions from motor vehicle sources changed 
## from 1999-2008 in Baltimore City?

## How to run this file:
# 1. Set the current working directory as the directory containing this file.
# 2. Please make sure the source data lies in the same directory as the R code.
# 3. Source this file by typing in:
#    source("plot5.R")
#    And press enter/return. This will run the code and produce plot5.png
#    in your working directory.
# 4. If sourcing the file cannot create the correct graph in plot5.png,
#    (The most common case is that the code creates a blank png file)
#    then please open this file in your R platform and run it sentence by
#    sentence.
#    I do this in RStudio by selecting all the code and click "Run".

# 1. Read the data:
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# By inspecting the data in `SCC`, I found that there are only 59 levels
# of the variable `EI.Sector`, the following labels are related to 
# motor vehicles:
# [43] "Mobile - Aircraft"                                 
# [44] "Mobile - Commercial Marine Vessels"                
# [45] "Mobile - Locomotives"                              
# [46] "Mobile - Non-Road Equipment - Diesel"              
# [47] "Mobile - Non-Road Equipment - Gasoline"            
# [48] "Mobile - Non-Road Equipment - Other"               
# [49] "Mobile - On-Road Diesel Heavy Duty Vehicles"       
# [50] "Mobile - On-Road Diesel Light Duty Vehicles"       
# [51] "Mobile - On-Road Gasoline Heavy Duty Vehicles"     
# [52] "Mobile - On-Road Gasoline Light Duty Vehicles"
# So I will make the graph according to the value of this variable.

# 2. Subset the SCC data, only use the motorRelated items.
motorRelated <- levels(SCC$EI.Sector)[43:52]
SCC <- SCC[SCC$EI.Sector %in% motorRelated,]

# 3. Subset the NEI data, only use the data from Baltimore:
NEI <- NEI[NEI$fips == "24510",]
# 4. Subset the NEI data, only use the motorRelated items.
NEI <- NEI[NEI$SCC %in% SCC$SCC,]

# 5. Calculate the sum of emissions of each year.
NEI$year <- as.factor(NEI$year)
NEIbyyear <- split(NEI, NEI$year)
result <- sapply(NEIbyyear, function(x) {
    sum(x$Emissions)
})

# 6. Plot the result and output to "plot5.png":
png("plot5.png")
plot(x=names(result),
     y=result,
     xlab = "Year",
     ylab ="PM2.5 Emissions (in tons)",
     main = "Change of Motor Vehicle PM2.5 Emissions in Baltimore by Year",
     type = "b")
dev.off()

