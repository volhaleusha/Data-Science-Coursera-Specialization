#read data:
dataset <- readRDS("summarySCC_PM25.rds")
class <- readRDS("Source_Classification_Code.rds")

#only choose names in class that have Coal and Comb in them:
class<-class[grep("[Vv]ehicle", class$EI.Sector),]

#select only data for chosen SCC:
data<- dataset[dataset$SCC %in% as.character(class$SCC),]

#extract data only for Baltimor and sum Emissions for each year
#store data in data_sum:
data_baltimore<- subset(data, fips =="24510")
data_baltimore<- cbind(data_baltimore, rep("Baltimore", dim(data_baltimore)[1]))
names(data_baltimore)[7] <- "City"

#extract data only for LA and sum Emissions for each year
#store data in data_sum:
data_LA<- subset(data, fips =="06037")
data_LA<- cbind(data_LA, rep("LA", dim(data_LA)[1]))
names(data_LA)[7] <- "City"

#combine data_LA and data_Baltimore:
data<- rbind(data_baltimore, data_LA)

#group data by city and year and sum Emissions:
data_sum<-aggregate(data$Emissions, list(data$City, as.character(data$year)), sum)

#remane columns after aggregation back to previous names:
colnames(data_sum)<- c("City", "Year", "Emissions")

#Open png device; create 'plot6.png' in my working directory:
png(filename = "plot6.png")

#plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008
#qplot(x=as.numeric(Year), y = Emissions, data= data_sum, fill=City)
g<- ggplot(data = data_sum, aes(x=Year, y=log10(Emissions), fill = City))
g+ geom_col(position="dodge") +xlab("Year") +ggtitle("Emissions by City and Year")

#close plot device:
dev.off()