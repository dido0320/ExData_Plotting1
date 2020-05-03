setwd("/Users/zhengyang/Desktop")
a <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?", colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))
a$Date <- as.Date(a$Date, "%d/%m/%Y")
a <- subset(a,Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))

dateTime <- paste(a$Date, a$Time)
a <- a[ ,!(names(a) %in% c("Date","Time"))]
a <- cbind(dateTime, a)
a$dateTime <- as.POSIXct(dateTime)
## Create plot1
hist(a$Global_active_power, main="Global Active Power", xlab = "Global Active Power (kilowatts)", col="red")
## Save file and close device
dev.copy(png,"plot1.png", width=480, height=480)
dev.off()
## Create Plot 2
plot(a$Global_active_power~a$dateTime, type="l", ylab="Global Active Power (kilowatts)", xlab="")
## Save file and close device
dev.copy(png,"plot2.png", width=480, height=480)
dev.off()
## Create Plot 3
with(a, {plot(Sub_metering_1~dateTime, type="l",ylab="Global Active Power (kilowatts)", xlab="")
lines(Sub_metering_2~dateTime,col='Red')
lines(Sub_metering_3~dateTime,col='Blue')})

legend("topright", col=c("black", "red", "blue"), lwd=c(1,1,1), c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
## Saving to file
dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()
## Create Plot 4
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(a, {
  plot(Global_active_power~dateTime, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  plot(Voltage~dateTime, type="l", 
       ylab="Voltage (volt)", xlab="")
  plot(Sub_metering_1~dateTime, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~dateTime,col='Red')
  lines(Sub_metering_3~dateTime,col='Blue')
  legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(Global_reactive_power~dateTime, type="l", 
       ylab="Global Rective Power (kilowatts)",xlab="")
})
## Saving to file
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()