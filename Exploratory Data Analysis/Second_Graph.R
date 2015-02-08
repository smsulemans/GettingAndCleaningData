data <- read.csv("household_power_consumption.txt", header = T, sep = ';', na.strings = "?") 
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
subset_data <- data[data$Date == '2007-02-01' | data$Date == '2007-02-02',]
datetime <- paste(as.Date(subset_data$Date), subset_data$Time)
subset_data$Datetime <- as.POSIXct(datetime)
png(file="plot2.png", width = 480, height = 480, bg="white")
plot(subset_data$Global_active_power ~ subset_data$Datetime, type = "l", ylab = "Global Active Power (kilowatts)", xlab = "")
dev.off()

