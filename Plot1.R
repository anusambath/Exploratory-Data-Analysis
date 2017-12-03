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

### Plot the graph - Plot 1
with(TwoDay, hist(Global_active_power, main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red"))

### Copy the graph to png file & then close the device
dev.copy(png, file="plot1.png", height=500, width=500)
dev.off()



