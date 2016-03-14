# Set JAVA_HOME, set max. memory, and load rJava library
# Sys.setenv(JAVA_HOME='/Library/Java/JavaVirtualMachines/jdk1.7.0_75.jdk/Contents/Home')

# setwd("~/Cookie/git/LabHadoop/R")

if(!require(DBI)){
  install.packages("DBI",dep=TRUE)
  library(DBI)
}
if(!require(rJava)){
  install.packages("rJava",dep=TRUE)
  library(rJava)
}
if(!require(RJDBC)){
  install.packages("RJDBC",dep=TRUE)
  library(RJDBC)
}
.libPaths()

# Output Java version
.jinit(parameters="-Xmx1024m")
print(.jcall("java/lang/System", "S", "getProperty", "java.version"))

current.path <- getwd()
jdbc.path <- "hive/JDBC4"
driver.jar.name <- "HiveJDBC4.jar"
driver.package.name <- "com.cloudera.hive.jdbc4.HS2Driver"

class.path <- paste(current.path, jdbc.path, sep="/")

for(file.name in list.files(class.path)){ 
  .jaddClassPath(paste(class.path, file.name, sep="/"))
}
.jclassPath()

drv <- JDBC(driver.package.name,
            paste(current.path, jdbc.path, driver.jar.name, sep="/"),
            identifier.quote="`")

conn <- dbConnect(drv, "jdbc:hive2://192.168.60.101:10000")

myData <- dbGetQuery(conn, "SELECT * FROM default.count")
str(myData)

data <- myData

## barplot

### viewcnt
vector <- data$count.viewcnt
names(vector) <- data$count.key
barplot(vector, main = "barplot of viewcnt")

## Pie Chart

### likecnt
slices <- data$count.likecnt
lbls <- data$count.key
pie(slices, labels = lbls, main="Pie Chart of likecnt")

## plot and model

### orderamount ~ ordercnt
plot(data$count.orderamount ~ data$count.ordercnt)
data.lm = lm(data$count.orderamount ~ data$count.ordercnt)
abline(data.lm, col="red")
summary(data.lm)


dbDisconnect(conn)
