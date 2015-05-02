# Please first set the current working directory as
# the path containing this source file.

# Please make sure the source data lies in the same 
# directory.
# (data: "household_power_consumption.txt")

# After you correctly change the working directory,
# type and run:
#        source("plot4.R")
# And then the code will run and output the "plot4.png".

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
png(file = "plot4.png",bg="transparent")
df$Time <- strptime(df$Time,format = '%Y-%m-%d %H:%M:%S')
par(mfrow=c(2,2))
with(df, {
    plot(Time,Global_active_power,type="l",xlab=NA,ylab="Global Active Power")
    plot(Time,Voltage,type="l",xlab="datetime")
    plot(Time,Sub_metering_1,type="l",xlab=NA,ylab="Energy sub metering")
    lines(Time,Sub_metering_2,col="red",type="l")
    lines(Time,Sub_metering_3,col="blue",type="l")
    legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
           lty=c(1,1,1),col=c("black","red","blue"),box.col="transparent")
    plot(Time,Global_reactive_power,type="l",xlab="datetime")
})
dev.off()