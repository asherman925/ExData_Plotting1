# read in data
hpc<-read.csv(file="household_power_consumption.txt", head=TRUE,sep=";")
# subset data by date
hpc$Date2<-as.Date(as.character(hpc$Date), "%d/%m/%Y")
hpc_limited<-subset(hpc,as.Date("2007-2-1") <= Date2 & Date2 <=as.Date("2007-2-2"))
#make Global_active_power, Voltage, Global_reactive_power numberic
hpc_limited$Global_active_power<-as.numeric(levels(hpc_limited$Global_active_power))[hpc_limited$Global_active_power]
hpc_limited$Global_reactive_power<-as.numeric(levels(hpc_limited$Global_reactive_power))[hpc_limited$Global_reactive_power]
hpc_limited$Voltage<-as.numeric(levels(hpc_limited$Voltage))[hpc_limited$Voltage]
# combine Date and Time columns into one and correct format
hpc_limited$TimeDate = paste(hpc_limited$Time,hpc_limited$Date, sep=" ")
hpc_limited$TimeDate = strptime(hpc_limited$TimeDate, '%H:%M:%S %d/%m/%Y')
# set plot windows
par(mfrow=c(2,2))
# create plot 1 of 4 - Global Active Power by Time and Day
plot(hpc_limited$TimeDate,hpc_limited$Global_active_power,type="n", ylab="Global Active Power", xlab="")
lines(hpc_limited$TimeDate,hpc_limited$Global_active_power)
# create plot 2 of 4 - Voltage by Time and Day
plot(hpc_limited$TimeDate,hpc_limited$Voltage,type="n", ylab="Voltage", xlab="datetime")
lines(hpc_limited$TimeDate,hpc_limited$Voltage)
# create plot 3 of 4 - Submetering by Time and Day
plot(hpc_limited$TimeDate,hpc_limited$Sub_metering_1,type="n", ylab="Energy sub metering", xlab="")
lines(hpc_limited$TimeDate,hpc_limited$Sub_metering_1)
lines(hpc_limited$TimeDate,hpc_limited$Sub_metering_2, col="red")
lines(hpc_limited$TimeDate,hpc_limited$Sub_metering_3, col="blue")
legend("topright", lty=1, col = c("black","blue", "red"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty="n", cex=.5)
# create plot 4 of 4 - Global Reactive Power by Time and Day
plot(hpc_limited$TimeDate,hpc_limited$Global_reactive_power,type="n", ylab="Global_reactive_power", xlab="datetime")
lines(hpc_limited$TimeDate,hpc_limited$Global_reactive_power)
# copy to PNG file
dev.copy(png,file="plot4.png")
dev.off()