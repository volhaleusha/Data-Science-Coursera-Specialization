#read data:
dataset <- readRDS("summarySCC_PM25.rds")
class <- readRDS("Source_Classification_Code.rds")

#open ggplot2 library:
library("ggplot2")

#extract data only for Baltimor and sum Emissions for each year
#store data in data_sum:
data_baltimore<- subset(dataset, fips =="24510")

#group data by type and yearc and sum Emissions:
data_sum<-aggregate(data_baltimore$Emissions, list(data_baltimore$type, as.character(data_baltimore$year)), sum)

#remane columns after aggregation back to previous names:
colnames(data_sum)<- c("type", "year", "Emissions")

#Open png device; create 'plot3.png' in my working directory:
png(filename = "plot3.png")

#plot data by type. Add geom_smooth to show trend for each type.
g<- ggplot(data = data_sum, aes(x=as.numeric(year), y=Emissions))
g+ geom_point() + facet_wrap(data_sum$type~.)+geom_smooth(method= "lm", se= FALSE, lwd=.5, col="red")+
    xlab("Year") +ggtitle("Emissions by Type for Baltimore City")

#close plot device:
dev.off()
