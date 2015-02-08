data <- read.csv("household_power_consumption.txt", header = T, sep = ';', na.strings = "?") 
subset_data <- data[data$Date == '1/2/2007' | data$Date == '2/2/2007',]
png(file="plot1.png", width = 480, height = 480, bg="white")
hist(subset_data$Global_active_power, col = "red", main = paste("Global Active Power"), ylab="Frequency", xlab = "Global Active Power (kilowatts)")
dev.off()