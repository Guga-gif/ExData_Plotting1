power <- read.table("household_power_consumption.txt", header = TRUE, sep = ";")
power$Global_active_power <- as.numeric(power$Global_active_power)
power$Global_reactive_power <- as.numeric(power$Global_reactive_power)
power$Date <- as.Date(power$Date,format = "%d/%m/%Y")
power[,10] <- paste(power$Date,power$Time,sep = " ")
colnames(power)[10] <- "Date_Time"
power$Date_Time <- as.POSIXct(power$Date_Time, format = "%Y-%m-%d %H:%M:%S")
power$Sub_metering_1 <- as.numeric(power$Sub_metering_1)
power$Sub_metering_2 <- as.numeric(power$Sub_metering_2)
power$Sub_metering_3 <- as.numeric(power$Sub_metering_3)
power$Voltage <- as.numeric(power$Voltage)
par(mfrow = c(1,1))
power1 <- power[(power$Date_Time>="2007-02-01 00:00:00") & (power$Date_Time<"2007-02-03 00:00:00") & !is.na(power$Global_active_power),]
good <- complete.cases(power1)
power1 <- power1[good,]

#Plot 3
#sub 1
with(power1, {
        #1
        plot(Date_Time,Sub_metering_1, type = "l",ylab = "Energy sub metering", xlab = "",xaxt = 's')
        #2
        lines(Date_Time,Sub_metering_2,ylab = "Global Active Power (kilowatts)",  col = "red")
        #3
        lines(Date_Time,Sub_metering_3, ylab = "Global Active Power (kilowatts)", col = "blue")
        
})

legend("topright",lty = c(1,1,1), legend = paste("Sub_metering_",c(1:3)), col = c("black","red","blue"), cex = 0.8)

dev.copy(png,file = "plot3.png")
dev.off()