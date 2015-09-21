# Set JAVA_HOME, set max. memory, and load rJava library
Sys.setenv(JAVA_HOME='/Library/Java/JavaVirtualMachines/jdk1.7.0_75.jdk/Contents/Home')

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
for(l in list.files('/Users/Mitake/Cookie/lib/impala/2.5.22.1040/JDBC4/')){ 
  .jaddClassPath(paste("/Users/Mitake/Cookie/lib/impala/2.5.22.1040/JDBC4/",l,sep=""))
}
.jclassPath()

drv <- JDBC("com.cloudera.impala.jdbc4.Driver","/Users/Mitake/Cookie/lib/impala/2.5.22.1040/JDBC4/ImpalaJDBC4.jar",identifier.quote="`")
conn <- dbConnect(drv, "jdbc:impala://192.168.60.250:21050")

myData <- dbGetQuery(conn, "select p.* from t1000_pid_count p")
#str(myData)

conn.close()
