
##read the data into powerconsumption. 
powerconsumption = read.table("exdata_data_household_power_consumption/household_power_consumption.txt", sep=";", header=T)

## convert the data data into Date format and subset data that matches specific dates. 
powerconsumption$Date <- strptime(powerconsumption$Date, "%d/%m/%Y")
powerconsumption$Date <- as.Date(powerconsumption$Date)
subpower <-  powerconsumption[powerconsumption$Date %in% as.Date(c("2007-2-1", "2007-2-2")),]

## combine date and time data into datetime and convert it to datetime format. 
datetime <- paste(subpower$Date, subpower$Time)
subpower$Datetime <- as.POSIXct(datetime)

## convert global active power, sub metering 1, 2,3, voltage and global reactive power into numeric formats. 
subpower$Global_active_power <- as.numeric(as.character(subpower$Global_active_power))
subpower$Sub_metering_1 <- as.numeric(as.character(subpower$Sub_metering_1))
subpower$Sub_metering_2 <- as.numeric(as.character(subpower$Sub_metering_2))
subpower$Sub_metering_3 <- as.numeric(as.character(subpower$Sub_metering_3))
subpower$Voltage <- as.numeric(as.character(subpower$Voltage))
subpower$Global_reactive_power <- as.numeric(as.character(subpower$Global_reactive_power))

## create layout for 4 plots and add 4 plots to the layout. 
## add the plots of the layout into plot4.png file. 
png("plot4.png", width=480, height=480)
par(mfrow=c(2,2))
plot(subpower$Datetime, subpower$Global_active_power, type="l", xlab = "", ylab = "Global Active Power")
plot(subpower$Datetime, subpower$Voltage, type="l", xlab="datetime", ylab="")

plot(subpower$Datetime, subpower$Sub_metering_1, type="l", xlab="", ylab="Energy Submetering")
lines(subpower$Datetime, subpower$Sub_metering_2, type="l", col="red")
lines(subpower$Datetime, subpower$Sub_metering_3, type="l", col="blue")
legend("topright", col=c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty="n", lty=1)

plot(subpower$Datetime, subpower$Global_reactive_power, type="l", xlab = "datetime", ylab = "Global_reactive_power", lty=1)

dev.off()