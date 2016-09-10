# read in data
hpc<-read.csv(file="household_power_consumption.txt", head=TRUE,sep=";")
# subset data by date
hpc$Date2<-as.Date(as.character(hpc$Date), "%d/%m/%Y")
hpc_limited<-subset(hpc,as.Date("2007-2-1") <= Date2 & Date2 <=as.Date("2007-2-2"))
#make Global_active_power numberic
hpc_limited$Global_active_power<-as.numeric(levels(hpc_limited$Global_active_power))[hpc_limited$Global_active_power]
# create plot 1 - Global Active Power Histogram
par(mfrow=c(1,1))
hist(hpc_limited$Global_active_power, breaks = 12, main="Global Active Power", xlab="Global Active Power (kilowatts)", col="red")
# copy to PNG file
dev.copy(png,file="plot1.png")
dev.off()