##This is Exploratory Data Analysis Course Project 1 Peer Assessment - plot1
# for plot1
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

#saving plot1.png
png(bg = "white", 
    filename = "plot1.png",
    width = 480, 
    height = 480
)
hist(x<-df$Global_active_power,main ="Global Active Power", xlab ="Global Active Power (kilowatts)", ylab = "Frequency", col = "red") 
dev.off()
