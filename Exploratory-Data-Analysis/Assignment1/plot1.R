# load dataset:
data_full<-read.table("household_power_consumption.txt", header = TRUE, sep= ";",stringsAsFactors=FALSE)
#convert dates to Date format and only choose data for 2007-02-01 and 2007-02-02:
data<- data_full[data_full$Date == "1/2/2007"|data_full$Date=="2/2/2007",]
data_full$Date<- as.Date(data_full$Date, "%d/%m/%Y")
#Open png device; create 'plot1.png' in my working directory
#(no need to set up 480x480 pixels, as it is default value)
png(filename = "plot1.png")
# create histogramm:
with(data, (hist(as.numeric(Global_active_power), col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")))
#close device
dev.off()
