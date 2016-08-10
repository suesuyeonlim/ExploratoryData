x<-read.table("household_power_consumption.txt",sep=";",header=TRUE)
x$Date<-as.Date(x$Date,format="%d/%m/%Y")
y<-subset(x,Date=="2007-02-01"|Date=="2007-02-02")

png("plot2.png",width=480,height=480)
y$Dates<-strptime(paste(y$Date,y$Time),"%Y-%m-%d %H:%M:%S")
plot(1:length(y$Dates),y$Global_active_power,type="l",xlab="",ylab="Global Active Power (kilowatts)", xaxt="n")
axis(1,at=c(0,length(y$Dates)/2,length(y$Dates)),labels=c("Thu","Fri","Sat"))
dev.off()