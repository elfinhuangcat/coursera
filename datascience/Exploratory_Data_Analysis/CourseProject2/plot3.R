## plot3.R
## This R file reads the PM2.5 emmission data and answer this question:
## Of the four types of sources indicated by the type 
## (point, nonpoint, onroad, nonroad) variable, which of these four sources 
## have seen decreases in emissions from 1999-2008 for Baltimore City? 
## Which have seen increases in emissions from 1999-2008? 
## Use the ggplot2 plotting system to make a plot answer this question.

## How to run this file:
# 1. Set the current working directory as the directory containing this file.
# 2. Please make sure you've install the "ggplot2" library and add it to your 
#    package list by:
#    library(ggplot2)
# 3. Please make sure the source data lies in the same directory as the R code.
# 4. Source this file by typing in:
#    source("plot3.R")
#    And press enter/return. This will run the code and produce plot3.png
#    in your working directory.
# 5. If sourcing the file cannot create the correct graph in plot3.png,
#    (The most common case is that the code creates a blank png file)
#    then please open this file in your R platform and run it sentence by
#    sentence.
#    I do this in RStudio by selecting all the code and click "Run".

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

# Split the dataframe of each year by type
# This is the submitted wrong version:
# for (i in 1:length(NEIbyyear)) {
#     NEIbyyear[[i]] <- split(NEIbyyear[[i]],NEI$type)
# }
for (i in 1:length(NEIbyyear)) {
    NEIbyyear[[i]] <- split(NEIbyyear[[i]],NEIbyyear[[i]]$type)
} 

# Calculate the total PM2.5 emission of each year and 
# of each type.
result <- sapply(NEIbyyear,function(x) {
    sapply(x,function(y) {
        sum(y$Emissions)
    })
})
# I can't draw the graph directly with the result table.
# So I need to transform it.
df <- data.frame(emission = numeric(),
                 type = character(),
                 year = character())
rowNames <- as.character(rownames(result))
colNames <- as.character(colnames(result))
df$type <- as.character(df$type)
df$year <- as.character(df$year)
counter <- 1
for (i in 1:nrow(result)) {
    for (j in 1:ncol(result)) {
        df[counter,"emission"] <- result[i,j]
        df[counter,"type"] <- rowNames[i]
        df[counter,"year"] <- colNames[j]
        counter <- counter + 1
    }
}

## So now what `df` looks like:
# emission     type year
# 1   522.940000 NON-ROAD 1999
# 2     6.235873 NON-ROAD 2002
# 3     6.636450 NON-ROAD 2005
# 4  1268.059531 NON-ROAD 2008
# 5  2107.625000 NONPOINT 1999
# 6   150.891788 NONPOINT 2002
# 7   135.202392 NONPOINT 2005
# 8   156.880106 NONPOINT 2008
# 9   346.820000  ON-ROAD 1999
# 10 2238.151935  ON-ROAD 2002
# 11 2619.773076  ON-ROAD 2005
# 12  406.431375  ON-ROAD 2008
# 13  296.795000    POINT 1999
# 14   58.636148    POINT 2002
# 15  329.742150    POINT 2005
# 16   30.910498    POINT 2008

# Create the plot and save it as a png file.
library(ggplot2)
png(file="plot3.png",bg="transparent")
g<-ggplot(data=df,aes(x=year,y=emission,group=type,color=type))
g  + geom_point()+geom_line() + 
    labs(title="Different Types of Emissions of Baltimore City from 1999-2008")
dev.off()
