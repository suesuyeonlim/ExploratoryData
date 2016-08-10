x<-read.table("household_power_consumption.txt",sep=";",header=TRUE)
x$Date<-as.Date(x$Date,format="%d/%m/%Y")
y<-subset(x,Date=="2007-02-01"|Date=="2007-02-02")
y$Dates<-strptime(paste(y$Date,y$Time),"%Y-%m-%d %H:%M:%S")

y$Global_active_power<-as.numeric(as.character(y$Global_active_power))
y$Voltage<-as.numeric(as.character(y$Voltage))
y$Global_reactive_power<-as.numeric(as.character(y$Global_reactive_power))

library(dplyr)
subset<-select(y,Dates,Sub_metering_1,Sub_metering_2,Sub_metering_3)
subset$Dates<-as.POSIXct(subset$Dates)
gathered<-gather(subset,key= class,value= metering, -Dates)

png("plot4.png",width=480,height=480)
par(mfrow=c(2,2),mar=c(4,4,2,2),oma=c(2,2,2,2))
with(y,{
  plot(Dates,Global_active_power,xlab="",ylab="Global Active Power",type="l")
  plot(Dates,Voltage,xlab="datetime",ylab="Voltage",type="l")
  
  with(gathered,plot(Dates,metering,xlab="",ylab="Energy sub metering",type="n"))
  with(subset(gathered,class=="Sub_metering_1"),points(Dates,metering,col="black",type="l"))
  with(subset(gathered,class=="Sub_metering_2"),points(Dates,metering,col="red",type="l"))
  with(subset(gathered,class=="Sub_metering_3"),points(Dates,metering,col="blue",type="l"))
  legend("topright",cex=0.9,bty="n",lty=c(1,1,1),col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
  
  plot(Dates,Global_reactive_power,xlab="datetime",ylab="Global_reactive_power",type="l")
})
dev.off()