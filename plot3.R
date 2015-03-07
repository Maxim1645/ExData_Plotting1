library(datasets)
library(dplyr)
Sys.setlocale("LC_TIME", "English")

# read data
data <- read.table("household_power_consumption.txt", sep = ";", header = TRUE, stringsAsFactors = FALSE)
data$Date <- as.Date(data$Date, format="%d/%m/%Y")

# select two days' data
set <- data[data$Date >= "2007-02-01" & data$Date <= "2007-02-02",]

set$Sub_metering_1 <- as.numeric(set$Sub_metering_1)
set$Sub_metering_2 <- as.numeric(set$Sub_metering_2)
set$Sub_metering_3 <- as.numeric(set$Sub_metering_3)

# create column with timestamps
set2 <- mutate(set, "Timestamp" = as.POSIXct(paste(as.character(set$Date), set$Time, sep=" ")))

png(file="plot3.png")
plot(set2$Timestamp, set$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
lines(set2$Timestamp, set$Sub_metering_2, col="red")
lines(set2$Timestamp, set$Sub_metering_3, col="blue")
legend("topright", lty=1, col=c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()
