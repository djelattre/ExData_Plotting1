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

# Build line chart and save it as png
png("plot2.png", width=480, height=480)
with(dataset, {
	plot(Global_active_power ~ DateTime, type="l", ylab="Global Active Power (kilowatts)", xlab="")
})
dev.off()
