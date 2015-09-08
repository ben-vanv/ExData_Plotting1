## Data download and unzipping where not already downloaded
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
if(!file.exists("./PowerConsumptionDataset.zip")){
    download.file(url, "./PowerConsumptionDataset.zip", mode="wb")
    unzip("./PowerConsumptionDataset.zip", exdir = "./Data")
}

## Set path to data text file that has been unzipped
dataFile <- "./Data/household_power_consumption.txt"

## Read in data table for all power consumption data
powerConsumptionData <- read.table(dataFile, header = TRUE, sep = ";", stringsAsFactors = FALSE)

## Fix date column formatting
powerConsumptionData$Date <- strptime(powerConsumptionData$Date, format = "%d/%m/%Y")

## Filter consumption data set by relevant dates
relevantDates <- as.POSIXlt(c("2007-02-01", "2007-02-02"))
powerConsumptionData <- powerConsumptionData[powerConsumptionData$Date %in% relevantDates, ]


## Create file for output and plot using base graphics
png(file = "plot4.png")

joinedDateTime <- as.POSIXct(paste(powerConsumptionData$Date, powerConsumptionData$Time))

## Create frame for four plots
par(mfrow = c(2,2))
## Add plot 1 - top, left
plot(x = joinedDateTime, y = as.numeric(powerConsumptionData$Global_active_power), pch = "",
     ylab = "Global Active Power (kilowatts)", xlab = "")
lines(x = joinedDateTime, y = as.numeric(powerConsumptionData$Global_active_power))

## Add plot 2 - top, right
plot(x = joinedDateTime, y = as.numeric(powerConsumptionData$Voltage), pch = "",
     ylab = "Voltage", xlab = "datetime")
lines(x = joinedDateTime, y = as.numeric(powerConsumptionData$Voltage))

## Add plot 3 - bottom, left
plot(x = joinedDateTime, y = as.numeric(powerConsumptionData$Sub_metering_1), pch = "",
     ylab = "Energy sub metering", xlab = "")
lines(x = joinedDateTime, y = as.numeric(powerConsumptionData$Sub_metering_1), col="black")
lines(x = joinedDateTime, y = as.numeric(powerConsumptionData$Sub_metering_2), col="red")
lines(x = joinedDateTime, y = as.numeric(powerConsumptionData$Sub_metering_3), col="blue")
legend("topright", lty = 1, col= c("black","red","blue"), bty = "n",
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

## Add plot 4 - bottom, right
plot(x = joinedDateTime, y = as.numeric(powerConsumptionData$Global_reactive_power), pch = "",
     ylab = "Global_reactive_power", xlab = "datetime")
lines(x = joinedDateTime, y = as.numeric(powerConsumptionData$Global_reactive_power), lwd = "0.5")


dev.off()