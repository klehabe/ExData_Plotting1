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
power_Feb$Date <- as.Date(power_Feb$Date, format="%d/%m/%Y")
power_Datetime <- mutate(power_Feb, Datetime= as.POSIXct(paste(power_Feb$Date, power_Feb$Time)))


# Create the plot in my png

png(filename= "plot2.png", width=480, height=480,units ="px") 
 plot(power_Datetime$Datetime, as.numeric(as.character(power_Datetime$Global_active_power)),
      type="l",xlab="",ylab="Global Active Power (kilowatts)")
dev.off()
