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

#Add column DateTime to dataset
dataset<-mutate(dataset, DateTime = as.POSIXct(paste(as.Date(Date), Time)))

# Build line chart, add legend and save it as png
png("plot4.png", width=480, height=480)

# Set the screen 2x2 by column
par(mfcol = c(2, 2)) 
# Top left
with(dataset, {
	plot(Global_active_power ~ DateTime, type="l", ylab="Global Active Power", xlab="")
})
# Bottom left
with(dataset, {
	plot(Sub_metering_1 ~ DateTime, type="l", ylab="Energy Submetering", xlab="")
	lines(Sub_metering_2 ~ DateTime,col="Red")
	lines(Sub_metering_3 ~ DateTime,col="Blue")
})
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
# Top right
with(dataset, {
plot(Voltage ~ DateTime, type="l", xlab="datetime", ylab="Voltage")
})
# Bottom right
with(dataset, {
	plot(Global_reactive_power ~ DateTime, type="l", cex=0.2, ylab="Global Active Power (kilowatts)", xlab="")
})

dev.off()
