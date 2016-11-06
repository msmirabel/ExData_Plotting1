## read the data table into powerconsumption
powerconsumption = read.table("exdata_data_household_power_consumption/household_power_consumption.txt", sep=";", header=T)

## convert the date data into Date format and subset data that matches the specific dates. 
powerconsumption$Date <- strptime(powerconsumption$Date, "%d/%m/%Y")
powerconsumption$Date <- as.Date(powerconsumption$Date)
subpower <-  powerconsumption[powerconsumption$Date %in% as.Date(c("2007-2-1", "2007-2-2")),]

## create a combination of date and time data into datetime and convert into datetime format.
datetime <- paste(subpower$Date, subpower$Time)
subpower$Datetime <- as.POSIXct(datetime)

## convert global active power into numeric format and save the plot plot2.png file. 
subpower$Global_active_power <- as.numeric(as.character(subpower$Global_active_power))
png("plot2.png", width=480, height=480)
plot(subpower$Datetime, subpower$Global_active_power, type="l", xlab = "", ylab = "Global Active Power (kilowatts)")
dev.off()