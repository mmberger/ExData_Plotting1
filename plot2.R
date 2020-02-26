# setup data directory
if(!dir.exists("data")){
  dir.create("data")
}
  
# download file if it does not exist
if(!file.exists("data\\household_power_consumption.txt")) {
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip","data\\exdata_data_household_power_consumption.zip")
  unzip("data\\exdata_data_household_power_consumption.zip", exdir="data")
}

# read data from file
data<-read.csv2("data\\household_power_consumption.txt", na.strings = c("?",""))

# rm NA's


# convert text date and time
data$DateTime<-strptime(paste(data$Date,data$Time,sep=" "),format="%d/%m/%Y %H:%M:%S")

# convert factors to numeric values
data$Global_active_power<-as.numeric(as.character(data$Global_active_power))
data$Global_reactive_power<-as.numeric(as.character(data$Global_reactive_power))
data$Voltage<-as.numeric(as.character(data$Voltage))
data$Global_intensity<-as.numeric(as.character(data$Global_intensity))
data$Sub_metering_1<-as.numeric(as.character(data$Sub_metering_1))
data$Sub_metering_2<-as.numeric(as.character(data$Sub_metering_2))
data$Sub_metering_3<-as.numeric(as.character(data$Sub_metering_3))

# create a subdataset with data from 2007-02-01 and 2007-02-02
data_subset<-data[(data$DateTime>="2007-02-01 00:00:00" & data$DateTime<"2007-02-03 00:00:00"),]

# open PNG file
png(filename="plot2.png")

# create plot 2
plot(data_subset$DateTime,data_subset$Global_active_power,type="l", xlab="", ylab="Global Active Power (kilowatts)")

# close device
dev.off()
