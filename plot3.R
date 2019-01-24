## plot3.R
## This file creates the plot3.png file requested by the peer graded assignement
dev.off()
par(bg=NA)
## Downloads and unzip the dataset 
if(!file.exists("household_power_consumption.txt")){
        fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        download.file(fileURL,"DataSet.zip",method = "curl")
        unzip("DataSet.zip")
        file.remove("DataSet.zip")
} else {
        print("household_power_consumption.txt is already available")
}

## Loads the dataset to a data.frame
HPC <- read.csv2("household_power_consumption.txt",skip=66637,nrows=2880,header = FALSE,as.is = TRUE)
HPC_names <- read.csv2("household_power_consumption.txt",nrows=1,header = FALSE,as.is = TRUE)
colnames(HPC) <- HPC_names

## create new column DateTime in POSIXlt 
DateTime <- strptime(paste(HPC[,1], HPC[,2]),"%d/%m/%Y %H:%M:%S")

## bind DataTime column, remove Date and Time Columns, convert other columns to numeric 
HPC <- cbind(DateTime,HPC[,3:9])
HPC[,2:8] <- as.numeric(unlist(HPC[,2:8]))

## plot the plot3 figure and copy it to plot3.png file
with(HPC,plot(DateTime,Sub_metering_1,type="l",ylab = "Energy sub metering",main = "",xlab = ""))
with(HPC,points(DateTime,Sub_metering_2,type="l",col="red"))
with(HPC,points(DateTime,Sub_metering_3,type="l",col="blue"))
legend("topright", lty= 1, col = c("black","red","blue"), legend = names(HPC)[6:8],y.intersp = 0.5)
dev.copy(png,file="plot3.png")
dev.off()