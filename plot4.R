library(sqldf)

data<-read.csv.sql(file.choose(),header=T,sep=";",
		sql="select*from file where(Date=='1/2/2007' OR Date=='2/2/2007')")
names(data)

temp<-with(data,paste(Date,Time))
datetime<-strptime(temp,"%d/%m/%Y %H:%M:%S")

new.data<-data.frame(datetime,data[,-c(1,2)])

par(mfrow=c(2,2))

with(new.data,plot(Global_active_power~datetime,type="l",
	xlab="",ylab="Global Active Power"))
	
with(new.data,plot(Voltage~datetime,type="l"))

with(new.data,plot(Sub_metering_1~datetime,type="l",
	xlab="",ylab="Energy sub metering"))
with(new.data,lines(Sub_metering_2~datetime,col="red"))
with(new.data,lines(Sub_metering_3~datetime,col="blue"))

legend<-c("Sub_metering_1","Sub_metering_2","Sub_metering_3")
leg.col<-c("black","red","blue")
legend("topright",legend=legend,lty=1,bty="n",col=leg.col,cex=0.7)

with(new.data,plot(Global_reactive_power~datetime,type="l"))

dev.copy(png,file="plot4.png",width=480,height=480)
dev.off()
