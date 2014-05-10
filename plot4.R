# for plot4
f <- file("household_power_consumption.txt","rt");

nolines <- 100
greped<-c()
repeat {
  lines=readLines(f,n=nolines)       #read lines
  idx <- grep("^[12]/2/2007", lines) #find those that match
  greped<-c(greped, lines[idx])      #add the found lines
  #
  if(nolines!=length(lines)) {
    break #are we at the end of the file?
  }
}
close(f)

tc<-textConnection(greped,"rt") #now we create a text connection and load data
df<-read.csv(tc,sep=";",header=FALSE)
#read in the column names
colname <- read.table("household_power_consumption.txt", sep = ";", nrows =1, header = TRUE)
#assign column names to df 
colnames(df) <- colnames(colname)

datetime <- paste(df$Date, df$Time)
df$DateTime <-strptime(datetime, "%d/%m/%Y %H:%M:%S")

#saving plot4.png
png(bg = "white", 
    filename = "plot4.png",
    width = 480, 
    height = 480
)
par(mfrow=c(2,2))
#graph 1
plot(x<- df$DateTime, y<-df$Global_active_power, ylab = list("Global Active Power", cex=0.9), xlab = "", type = "l", col = "black") 
#graph 2
plot(x<- df$DateTime, y<-df$Voltage, ylab = list("Voltage", cex=0.9), xlab = "datetime", type = "l", col = "black") 
#graph 3
plot(x<- df$DateTime, y<-df$Sub_metering_1, ylab = list("Energy sub metering", cex=0.9), xlab = "", type = "l", col = "black") 
lines(x<-df$DateTime, y<-df$Sub_metering_2, col ="red")
lines(x<-df$DateTime, y<-df$Sub_metering_3, col ="blue")
#set legend
y.leg <- c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
col.leg<- c("black","red","blue")
legend("topright", y.leg, col=col.leg,lty=1, bty="n") #no legend border 
#graph4
plot(x<- df$DateTime, y<-df$Global_reactive_power, xlab = "datetime", ylab=list("Global_reactive_power", cex=0.9),type = "l", col = "black") 

dev.off()
