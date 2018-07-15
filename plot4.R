# Read in entire File
power_consumption <- read.table("household_power_consumption.txt", sep=";", header =TRUE)

#subset the data with the 2 dates
power_Feb <- subset(power_consumption,Date == "1/2/2007" | Date =="2/2/2007")

# Check the distinct dates in the subset as a sanity check
unique(power_Feb$Date)

#delete the big file so the the memory does not get full
  rm(power_consumption)

#Add a new column as a DateTime
library(dplyr)
library(lubridate)

#Convert Date and time to Date and time formats and add new Datetime column 
 power_Datetime <- mutate(power_Feb, Datetime= as.POSIXct(paste(power_Feb$Date, power_Feb$Time)))

#change the number of plots per row and column
par(mfrow = c(2,2))

# Create the plots in my window and copy them to png

with(power_Datetime, plot(Datetime, as.numeric(as.character(Global_active_power)), type="l",xlab="",ylab="Global Active Power"))
with(power_Datetime, plot(Datetime, as.numeric(as.character(Voltage)), type="l",xlab="Datetime",ylab="Voltage"))

with(power_Datetime, {
                       plot(Datetime,as.numeric(as.character(Sub_metering_1)), type="l",
                        ylab="Energy sub metering	", xlab="")

                        lines(Datetime,as.numeric(as.character(Sub_metering_2)),col="Orange")
  				lines(Datetime,as.numeric(as.character(Sub_metering_3)),col="Blue")

			legend("topright", col=c("Black", "Orange", "Blue"), lty=1, lwd=2, 
       		 legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
})

plot(power_Datetime$Datetime, as.numeric(as.character(power_Datetime$Global_reactive_power)),
     type="l",xlab="",ylab="Global_reactive_power")
	 
dev.copy(png, file="plot4.png", height=480, width=480)

dev.off()
