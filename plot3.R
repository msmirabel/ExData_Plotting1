
## read the data into powerconsumption table. 
powerconsumption = read.table("exdata_data_household_power_consumption/household_power_consumption.txt", sep=";", header=T)

## convert the date date into Date fomrat and subset data that matches specific dates. 
powerconsumption$Date <- strptime(powerconsumption$Date, "%d/%m/%Y")
powerconsumption$Date <- as.Date(powerconsumption$Date)
subpower <-  powerconsumption[powerconsumption$Date %in% as.Date(c("2007-2-1", "2007-2-2")),]

## create a combination of date and time data into datetime and convert into datetime format. 
datetime <- paste(subpower$Date, subpower$Time)
subpower$Datetime <- as.POSIXct(datetime)

## convert Sub_metering_1, Sub_metering_2, Sub_metering_3 into numeric formats. 
subpower$Sub_metering_1 <- as.numeric(as.character(subpower$Sub_metering_1))
subpower$Sub_metering_2 <- as.numeric(as.character(subpower$Sub_metering_2))
subpower$Sub_metering_3 <- as.numeric(as.character(subpower$Sub_metering_3))

## plot the data with legend and add to plog3.png file. 
png("plot3.png", width=480, height=480)
plot(subpower$Datetime, subpower$Sub_metering_1, type="l",  xlab="", ylab="Energy Submetering")
lines(subpower$Datetime, subpower$Sub_metering_2, type="l", col="red")
lines(subpower$Datetime, subpower$Sub_metering_3, type="l", col="blue")
legend("topright", col=c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, lwd=1)

dev.off()