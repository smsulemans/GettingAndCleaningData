data <- read.csv("household_power_consumption.txt", header = T, sep = ';', na.strings = "?") 
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
subset_data <- data[data$Date == '2007-02-01' | data$Date == '2007-02-02',]
datetime <- paste(as.Date(subset_data$Date), subset_data$Time)
subset_data$Datetime <- as.POSIXct(datetime)
png(file="plot3.png", width = 480, height = 480, bg="white")
plot(subset_data$Sub_metering_1 ~ subset_data$Datetime, type = "l", ylab = "Global Active Power (kilowatts)")
lines(subset_data$Sub_metering_2 ~ subset_data$Datetime, col = 'Red')
lines(subset_data$Sub_metering_3 ~ subset_data$Datetime, col = 'Blue')
legend("topright", col = c("black", "red", "blue"), lty = 1, lwd = 2, legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()

