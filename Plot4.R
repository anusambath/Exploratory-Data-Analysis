library(dplyr)
library(lubridate)

### Download the data file
url <- "https://archive.ics.uci.edu/ml/machine-learning-databases/00235/household_power_consumption.zip"
download.file(url, "datafiles.zip")
unzip(zipfile = "datafiles.zip")

### Read data file into table
consumption <- tbl_df(read.table("household_power_consumption.txt" , header= TRUE, sep=";", na.strings = c("?")))

### Subset to a period of two days in Feb 2007
TwoDay  <- filter(consumption, Date %in% c("1/2/2007", "2/2/2007"))

### Convert Date & Time to date format
TwoDay <- TwoDay %>% mutate (Datetime  = as.POSIXct(paste(dmy(Date), Time)))

### Plot the graph - Plot 4
par(mfrow=c(2,2),  oma=c(0,2,2,0))   
#graph1
with(TwoDay, plot(Global_active_power~Datetime, main="", 
                  xlab="", ylab="Global Active Power", type="l"))

#graph2
with(TwoDay, plot(Voltage~Datetime, main="", 
                  xlab="datetime", ylab="Voltage", type="l"))

#graph3
with(TwoDay, {
    plot(Sub_metering_1~Datetime, main="", type="l", col="black", xlab="", ylab="Energy sub metering")
    lines(Sub_metering_2~Datetime, main="", type="l", col="red")
    lines(Sub_metering_3~Datetime, main="", type="l", col="blue")
} )

legend("topright", col=c("black", "red", "blue"), lty=1 ,
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty="n") 

#graph4
with(TwoDay, plot(Global_reactive_power~Datetime, main="", 
                  xlab="", ylab="Global_reactive_power", type="l"))

### Copy the graph to png file & then close the device
dev.copy(png, file="plot4.png", height=500, width=500)
dev.off()

