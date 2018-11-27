#read data
dataset <- readRDS("summarySCC_PM25.rds")
class <- readRDS("Source_Classification_Code.rds")

#sum Emissions for each year and store it in data_sum:
data_sum<- tapply(dataset$Emissions, dataset$year, sum)

#Open png device; create 'plot1.png' in my working directory:
png(filename = "plot1.png")

#plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008
plot(names(data_sum), data_sum, ylab= "PM2.5 (tons)", xlab ="Year", main = "Total PM2.5 emission ",
     col = "blue", pch =19, type = "h", lwd= 10)

#convert data_sum into data.frame: it is needed to be ale to feed data into lm model
d<- as.data.frame(data_sum)

#create linear model and plot it on top of data
model<- lm(d$data_sum~as.numeric(row.names(d)), d)
abline(model, lwd=2, col = "red")

#close plot device:
dev.off()