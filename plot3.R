#file url
url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

#download zip file
download.file(url, destfile = "./power_consumption.ZIP")

#unzipping the file
unzip("power_consumption.ZIP")

#reading in the file
data = read.table(file = "household_power_consumption.txt", header = TRUE, sep = ";")

#making the values of the column 'Date' into date class from the given format
data[["Date"]] = as.Date(data[["Date"]], format="%d/%m/%Y")

#making an extra column 'DateTime' indicating the date and time in the format:
# Day/Month/Year Hour:Minute:Second
data[["DateTime"]] = strptime(paste(data[["Date"]], data[["Time"]], sep=" "),  "%Y-%m-%d %H:%M:%S")

#making an extra column called Day indicating the wekday
data[["Day"]] = weekdays(data[["Date"]],)

#making the data type of the column 'Global_active_power' numeric
data[["Global_active_power"]] = as.numeric(data[["Global_active_power"]])

#making the data type of the sub_metering columns numeric
data[["Sub_metering_1"]] = as.numeric(data[["Sub_metering_1"]])
data[["Sub_metering_2"]] = as.numeric(data[["Sub_metering_2"]])
data[["Sub_metering_3"]] = as.numeric(data[["Sub_metering_3"]])

#OR extracting those rows which have a date 01st or 2nd Feb 2007
rows = subset(data, Date == "2007-2-1" | Date == "2007-2-2")
##save the plot in a file with the use of graphics device

##save the plot in a file
if(!file.exists("./img"))
{
  dir.create("./img")
}
png(file = "./img/plot3.png", width=480, height=480)

plot(rows[["DateTime"]], rows[["Sub_metering_1"]], type="n", xlab = "", ylab = "Energy sub metering", yaxt="n")
points(rows[["DateTime"]], rows[["Sub_metering_1"]], type="l", col="black")
points(rows[["DateTime"]], rows[["Sub_metering_2"]], type="l", col="red")
points(rows[["DateTime"]], rows[["Sub_metering_3"]], type="l", col="blue")
legend("topright", col=c("black","red","blue"), lty = c(1,1,1), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
axis(2, at=c(10,20,30), labels = c(10,20,30))
dev.off()