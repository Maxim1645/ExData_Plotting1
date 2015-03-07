library(datasets)
library(dplyr)
Sys.setlocale("LC_TIME", "English")

# read data
data <- read.table("household_power_consumption.txt", sep = ";", header = TRUE, stringsAsFactors = FALSE)
data$Date <- as.Date(data$Date, format="%d/%m/%Y")

# select two days' data
set <- data[data$Date >= "2007-02-01" & data$Date <= "2007-02-02",]

set$Global_active_power <- as.numeric(set$Global_active_power)

# create column with timestamps
set <- mutate(set, "Timestamp" = as.POSIXct(paste(as.character(set$Date), set$Time, sep=" ")))

png(file="plot2.png")
plot(set$Timestamp, set$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")
dev.off()
