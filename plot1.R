
x<-read.table("c:/Users/Sue/Desktop/power/household_power_consumption.txt",sep=";",header=TRUE)
x$Date<-as.Date(x$Date,format="%d/%m/%Y")
y<-subset(x,Date=="2007-02-01"|Date=="2007-02-02")
y$Global_active_power<-as.numeric(as.character(y$Global_active_power))
png("plot3.png",width=480,height=480)
z<-hist(y$Global_active_power,breaks=16,col="red",main="Global Active Power",xlab="Global Active Power (kilowatts)",ylab="Frequency")
dev.off()