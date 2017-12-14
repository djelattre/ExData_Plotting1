#----------------------------------------------------------
# Load library
#----------------------------------------------------------

library(dplyr)

#----------------------------------------------------------
# Prepare dataset
#----------------------------------------------------------

# Load Data
filepath <- "household_power_consumption.txt"
data <- read.table(filepath, header=TRUE, sep=";", na.strings="?", stringsAsFactors=FALSE)
rm(filepath)

# Convert data$Date to data 
data$Date <- as.Date(data$Date,"%d/%m/%Y")
tbl_data<-tbl_df(data)
rm(data)

# Create Dataset 
dataset<-filter(tbl_data, Date >= "2007-02-01" & Date <="2007-02-02")
rm(tbl_data)

# Build histogram and save it as png
png("plot1.png", width=480, height=480)
hist(dataset$Global_active_power, main="Global Active Power",xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")
dev.off()
