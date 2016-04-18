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
data_use_subplot1 <- data_use[data_use$Global_active_power != "?" 
                           & data_use$Time != "?", ]

data_use_subplot2 <- data_use[data_use$Voltage != "?" 
                           & data_use$Time != "?", ]

data_use_subplot3 <- data_use[data_use$Sub_metering_1 != "?" 
                           & data_use$Sub_metering_2 != "?"
                           & data_use$Sub_metering_3 != "?", ]

data_use_subplot4 <- data_use[data_use$Global_reactive_power != "?" 
                           & data_use$Time != "?", ]

# Creating plot 4
# making space for four subplots
par(mfrow = c(2,2))
### plot 4-1
with(data_use_subplot1, 
     plot(Date.Time, as.numeric(Global_active_power), type = "n", 
          xlab = "", ylab = "Global Active Power (kilowatts)"))
lines(data_use_subplot1$Date.Time, as.numeric(data_use_subplot1$Global_active_power))
###
### plot 4-2
with(data_use_subplot2, 
     plot(Date.Time, as.numeric(Voltage), type = "n", 
          xlab = "datetime", ylab = "Voltage"))
lines(data_use_subplot2$Date.Time, as.numeric(data_use_subplot2$Voltage))
###
### plot 4-3
with(data_use_subplot3, 
     plot(Date.Time, as.numeric(Sub_metering_1), type = "n", 
          xlab = "", ylab = "Energy sub metering"))
lines(data_use_subplot3$Date.Time, as.numeric(data_use_subplot3$Sub_metering_1), col = "black")
lines(data_use_subplot3$Date.Time, as.numeric(data_use_subplot3$Sub_metering_2), col = "red")
lines(data_use_subplot3$Date.Time, as.numeric(data_use_subplot3$Sub_metering_3), col = "blue")
legend("topright", lty = 1, col = c("black", "red", "blue"), cex = 0.75,
       legend = c("Sub_metering_1", "Other Sub_metering_2", "Sub_metering_3"))
###
### plot 4-4
with(data_use_subplot4, 
     plot(Date.Time, as.numeric(Global_reactive_power), type = "n", 
          xlab = "datetime", ylab = "Global_reactive_power"))
lines(data_use_subplot4$Date.Time, as.numeric(data_use_subplot4$Global_reactive_power))

# Copying to png file
dev.copy(png, file = "plot4.png", width = 480, height = 480)
dev.off()
