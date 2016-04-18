set.seed(15)
# Data must exit in the working directory
# reading the entire data
data <- read.table("household_power_consumption.txt", sep = ";", header = TRUE)
data$Date <- as.Date(data$Date, "%d/%m/%Y")
data$Time <- strptime(data$Time, "%H:%M:%S")
data$Time <- strftime(data$Time, "%H:%M:%S")
# subsetting the data
data_use <- data[data$Date == "2007-02-01" | data$Date == "2007-02-02", ]
# removing missing data if any
data_use_hist <- data_use[as.character(data_use$Global_active_power) != "?", ]

# Creating plot 1
hist(as.numeric(as.character(data_use_hist$Global_active_power)), 
     col = "red", 
     xlab = "Global Active Power (kilowatts)",
     main = "Global Active Power")

# Copying to png file
dev.copy(png, file = "plot1.png", width = 480, height = 480)
dev.off()
