# read in data
hpc<-read.csv(file="household_power_consumption.txt", head=TRUE,sep=";")
# subset data by date
hpc$Date2<-as.Date(as.character(hpc$Date), "%d/%m/%Y")
hpc_limited<-subset(hpc,as.Date("2007-2-1") <= Date2 & Date2 <=as.Date("2007-2-2"))
#make Global_active_power numberic
hpc_limited$Global_active_power<-as.numeric(levels(hpc_limited$Global_active_power))[hpc_limited$Global_active_power]
# combine Date and Time columns into one and correct format
hpc_limited$TimeDate = paste(hpc_limited$Time,hpc_limited$Date, sep=" ")
hpc_limited$TimeDate = strptime(hpc_limited$TimeDate, '%H:%M:%S %d/%m/%Y')
# create plot 2 - Global Active Power by Time & Date
par(mfrow=c(1,1))
plot(hpc_limited$TimeDate,hpc_limited$Global_active_power,type="n", ylab="Global Active Power (kilowatts)", xlab="")
lines(hpc_limited$TimeDate,hpc_limited$Global_active_power)
# copy to PNG file
dev.copy(png,file="plot2.png")
dev.off()