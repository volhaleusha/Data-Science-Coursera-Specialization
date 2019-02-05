# load dataset:
data_full<-read.table("household_power_consumption.txt", header = TRUE, sep= ";", stringsAsFactors=FALSE)
#only choose data for 2007-02-01 and 2007-02-02:
data<- data_full[data_full$Date == "1/2/2007"|data_full$Date=="2/2/2007",]
#paste together Date and Time and convert Time to Time format
data$Time <- paste(data$Date, data$Time)
data$Time<- strptime(data$Time, format<-"%d/%m/%Y %H:%M:%S")
#Open png device; create 'plot1.png' in my working directory
#(no need to set up 480x480 pixels, as it is default value)
png(filename = "plot2.png")
plot(data$Time, data$Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)", xlab= "")
#close device
dev.off()
