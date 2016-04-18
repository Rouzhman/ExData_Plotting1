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
data_use_plot2 <- data_use[data_use$Global_active_power != "?" 
                           & data_use$Time != "?", ]
# Creating plot 2
with(data_use_plot2, 
     plot(Date.Time, as.numeric(Global_active_power), type = "n", 
          xlab = "", ylab = "Global Active Power (kilowatts)"))
lines(data_use_plot2$Date.Time, as.numeric(data_use_plot2$Global_active_power))

# Copying to png file
dev.copy(png, file = "plot2.png", width = 480, height = 480)
dev.off()
