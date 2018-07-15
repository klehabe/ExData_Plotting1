# Read in entire File
power_consumption <- read.table("household_power_consumption.txt", sep=";", header =TRUE)

#subset the data with the 2 dates
power_Feb <- subset(power_consumption,Date == "1/2/2007" | Date =="2/2/2007")

# Check the distinct dates in the subset as a sanity check
unique(power_Feb$Date)

#delete the big file so the the memory does not get full
  rm(power_consumption)
# Create the plot in png

png(filename= "plot1.png", width=480, height=480,units ="px")
hist(as.numeric(as.character(power_Feb$Global_active_power)), col="Red", xlab= "Global Active Power(kilowatt)", ylab ="Frequency", main= "Global Active Power")
dev.off()
