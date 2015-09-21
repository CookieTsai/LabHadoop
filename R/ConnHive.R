# Set JAVA_HOME, set max. memory, and load rJava library
# Sys.setenv(JAVA_HOME='/Library/Java/JavaVirtualMachines/jdk1.7.0_75.jdk/Contents/Home')

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

myData <- dbGetQuery(conn, "SELECT * FROM default.log")
str(myData)
myData

dbDisconnect(conn)
