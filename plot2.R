# for plot2
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

#saving plot2.png
png(bg = "white", 
    filename = "plot2.png",
    width = 480, 
    height = 480
)
plot(x<- df$DateTime, y<-df$Global_active_power, ylab = list("Global Active Power (kilowatts)", cex=0.9), xlab = "", type = "l", col = "black") 
dev.off()
