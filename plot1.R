## read the data table into powerconsumption
powerconsumption = read.table("exdata_data_household_power_consumption/household_power_consumption.txt", sep=";", header=T)

## convert the date data to Date format and subset the data that matches the dates
powerconsumption$Date <- strptime(powerconsumption$Date, "%d/%m/%Y")
powerconsumption$Date <- as.Date(powerconsumption$Date)
subpower <-  powerconsumption[powerconsumption$Date %in% as.Date(c("2007-2-1", "2007-2-2")),]

## convert the global active power to numeric format. 
global <- as.numeric(as.character(subpower$Global_active_power))

## save the plot to plot1.png file. 
png("plot1.png", width=480, height=480)
hist(global, col="red", xlab="Global Active Power (kilowatts)", main="Global Active Power")
dev.off()
