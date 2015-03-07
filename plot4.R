library(datasets)
library(dplyr)
Sys.setlocale("LC_TIME", "English")

data <- read.table("household_power_consumption.txt", sep = ";", header = TRUE, stringsAsFactors = FALSE)
data$Date <- as.Date(data$Date, format="%d/%m/%Y")

set <- data[data$Date >= "2007-02-01" & data$Date <= "2007-02-02",]

set$Sub_metering_1 <- as.numeric(set$Sub_metering_1)
set$Sub_metering_2 <- as.numeric(set$Sub_metering_2)
set$Sub_metering_3 <- as.numeric(set$Sub_metering_3)

# create column with timestamps
set <- mutate(set, "Timestamp" = as.POSIXct(paste(as.character(set$Date), set$Time, sep=" ")))

png(file="plot4.png")
par(mfcol = c(2, 2))
plot(set$Timestamp, set$Global_active_power, type="l", xlab="", ylab="Global Active Power")
plot(set$Timestamp, set$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
lines(set$Timestamp, set$Sub_metering_2, col="red")
lines(set$Timestamp, set$Sub_metering_3, col="blue")
legend("topright", lty=1, col=c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty = "n")
plot(set$Timestamp, set$Voltage, type="l", xlab="datetime", ylab="Voltage")
plot(set$Timestamp, set$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")
dev.off()
