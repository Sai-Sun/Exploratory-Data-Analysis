library(sqldf)

data<-read.csv.sql(file.choose(),header=T,sep=";",
		sql="select*from file where(Date=='1/2/2007' OR Date=='2/2/2007')")
names(data)

temp<-with(data,paste(Date,Time))
datetime<-strptime(temp,"%d/%m/%Y %H:%M:%S")

new.data<-data.frame(datetime,data[,-c(1,2)])

with(new.data,plot(Global_active_power~datetime,type="l",
	xlab="",ylab="Global Active Power (kilowatts)"))

dev.copy(png,file="plot2.png",width=480,height=480)
dev.off()
