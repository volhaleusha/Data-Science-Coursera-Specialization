# load dataset:
data_full<-read.table("household_power_consumption.txt", header = TRUE, sep= ";", stringsAsFactors=FALSE)
#only choose data for 2007-02-01 and 2007-02-02:
data<- data_full[data_full$Date == "1/2/2007"|data_full$Date=="2/2/2007",]
#paste together Date and Time and convert Time to Time format
data$Time <- paste(data$Date, data$Time)
data$Time<- strptime(data$Time, format<-"%d/%m/%Y %H:%M:%S")
#Open png device; create 'plot1.png' in my working directory
#(no need to set up 480x480 pixels, as it is default value)
png(filename = "plot3.png")
#plot sub_metering 1 vs time
plot(data$Time, data$Sub_metering_1,type = "l", xlab = "", ylab="")
# add line for sub metering 2
lines(data$Time, data$Sub_metering_2, type = "l", col = "red" , xlab = "", ylab="")
#add line for sub metering 3
lines(data$Time, data$Sub_metering_3, type = "l", col = "blue", xlab = "", ylab="" )
#add titles for axis
title(ylab = "Energy sub mettering", xlab= "")
#add legend
legend("topright", lty =1, col = c("black" ,"red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"))
#close device
dev.off()
