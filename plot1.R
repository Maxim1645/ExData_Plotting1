library(datasets)

# read data
data <- read.table("household_power_consumption.txt", sep = ";", header = TRUE, stringsAsFactors = FALSE)
data$Date <- as.Date(data$Date, format="%d/%m/%Y")

# select two days' data
set <- data[data$Date >= "2007-02-01" & data$Date <= "2007-02-02",]

set$Global_active_power <- as.numeric(set$Global_active_power)

png(file="plot1.png")
hist(set$Global_active_power, xlab = "Global Active Power (kilowatts)", main = "Global Active Power", col = "red")
dev.off()