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
png(file = "plot2.png")
joinedDateTime <- as.POSIXct(paste(powerConsumptionData$Date, powerConsumptionData$Time))
plot(x = joinedDateTime, y = as.numeric(powerConsumptionData$Global_active_power), pch = "",
     ylab = "Global Active Power (kilowatts)", xlab = "")

## Add lines to base plot 
lines(x = joinedDateTime, y = as.numeric(powerConsumptionData$Global_active_power))

dev.off()