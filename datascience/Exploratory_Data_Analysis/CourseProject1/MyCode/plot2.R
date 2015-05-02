# Please first set the current working directory as
# the path containing this source file.

# Please make sure the source data lies in the same 
# directory.
# (data: "household_power_consumption.txt")

# After you correctly change the working directory,
# type and run:
#        source("plot2.R")
# And then the code will run and output the "plot2.png".

# Read the raw data line by line
rawdata <- readLines("household_power_consumption.txt")
# Remove useless data
usedata <- rawdata[grepl(pattern="^1/2/2007|^2/2/2007|^Date",x=rawdata)]
# Split the data by semicolon
datalist <- strsplit(x=usedata,split=";")
# Transform the data into a matrix
datamatrix <- matrix(unlist(datalist[-1]),
                     ncol=length(datalist[[1]]),byrow = TRUE)
# Transform the data into a data frame
df <- data.frame(datamatrix,stringsAsFactors = F)
# Change column names
colnames(df) <- datalist[[1]]
# Transform the "Date" column to Date format
df$Date <- as.Date(df$Date,"%d/%m/%Y")
# Combine date and time
df$Time <- paste(df$Date,df$Time)
# Delete the first column
df <- df[,-1]
# Deal with missing values
for (i in 1:nrow(df)) {
    for (j in 1:ncol(df)) {
        if (df[i,j] == "?") {
            df[i,j] <- NA
        }
    }
}
# Output the png file
png(file = "plot2.png",bg="transparent")
plot(x=strptime(df$Time,format = '%Y-%m-%d %H:%M:%S'),
     y=df$Global_active_power,
     type="l",xlab="",ylab="Global Active Power (kilowatts")
dev.off()