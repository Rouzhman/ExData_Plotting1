set.seed(15)
# Data must exit in the working directory
# reading the entire data
data <- read.table("household_power_consumption.txt", sep = ";", header = TRUE, colClasses = "character")
data$Date <- as.Date(data$Date, "%d/%m/%Y")
data$Time <- strptime(data$Time, "%H:%M:%S")
data$Time <- strftime(data$Time, "%H:%M:%S")
# subsetting the data
data_use <- data[data$Date == "2007-02-01" | data$Date == "2007-02-02", ]
# Adding one column to represent both time and date
data_use <- cbind(paste(data_use$Date, data_use$Time), data_use) 
colnames(data_use)[1] = "Date.Time"
data_use$Date.Time <- strptime(as.character(data_use$Date.Time), format = "%Y-%m-%d %H:%M:%S")
# removing missing data if any
data_use_plot3 <- data_use[data_use$Sub_metering_1 != "?" 
                           & data_use$Sub_metering_2 != "?"
                           & data_use$Sub_metering_3 != "?", ]

# Creating plot 3
with(data_use_plot3, 
     plot(Date.Time, as.numeric(Sub_metering_1), type = "n", 
          xlab = "", ylab = "Energy sub metering"))
lines(data_use_plot3$Date.Time, as.numeric(data_use_plot3$Sub_metering_1), col = "black")
lines(data_use_plot3$Date.Time, as.numeric(data_use_plot3$Sub_metering_2), col = "red")
lines(data_use_plot3$Date.Time, as.numeric(data_use_plot3$Sub_metering_3), col = "blue")
legend("topright", lty = 1, col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Other Sub_metering_2", "Sub_metering_3"))

# Copying to png file
dev.copy(png, file = "plot3.png", width = 480, height = 480)
dev.off()
