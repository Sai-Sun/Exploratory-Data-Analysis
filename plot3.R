library(sqldf)

data<-read.csv.sql(file.choose(),header=T,sep=";",
		sql="select*from file where(Date=='1/2/2007' OR Date=='2/2/2007')")
names(data)

temp<-with(data,paste(Date,Time))
datetime<-strptime(temp,"%d/%m/%Y %H:%M:%S")

new.data<-data.frame(datetime,data[,-c(1,2)])

with(new.data,plot(Sub_metering_1~datetime,type="l",
	xlab="",ylab="Energy sub metering"))

with(new.data,lines(Sub_metering_2~datetime,col="red"))

with(new.data,lines(Sub_metering_3~datetime,col="blue"))

legend<-c("Sub_metering_1","Sub_metering_2","Sub_metering_3")
leg.col<-c("black","red","blue")
legend("topright",legend=legend,lty=1,col=leg.col)

dev.copy(png,file="plot3.png",width=480,height=480)
dev.off()
