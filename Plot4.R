#Plot 4
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
par(mar = c(5.1, 4.1, 4.1, 2.1) ,mfrow = c(2,2))
power1 <- power[(power$Date_Time>="2007-02-01 00:00:00") & (power$Date_Time<"2007-02-03 00:00:00") & !is.na(power$Global_active_power),]
good <- complete.cases(power1)
power1 <- power1[good,]

#1
with(power1, {
        plot(Date_Time,Global_active_power, type = "l",ylab = "Global Active Power", xlab = "",xaxt = 's')
})

#2
with(power1, {
        plot(Date_Time,Voltage, type = "l",ylab = "Voltage", xlab = "datetime",xaxt = 's')
})

#3
with(power1, {
        #submeter1
        plot(Date_Time,Sub_metering_1, type = "l",ylab = "Energy sub metering", xlab = "",xaxt = 's')
        #submeter2
        lines(Date_Time,Sub_metering_2,ylab = "Global Active Power (kilowatts)",  col = "red")
        #submeter3
        lines(Date_Time,Sub_metering_3, ylab = "Global Active Power (kilowatts)", col = "blue")
        
})

legend("topright",lty = c(1,1,1), legend = paste("Sub_metering_",c(1:3)), col = c("black","red","blue"), cex = 0.4)

#4
with(power1, {
        plot(Date_Time,Global_reactive_power, type = "l",ylab = "Global_reactive_power", xlab = "datetime",xaxt = 's')
})

dev.copy(png,file = "plot4.png")
dev.off()
