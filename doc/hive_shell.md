## Create Table

Normal

```
CREATE TABLE Normal_Table(name string, phone string);
```

From File

```
CREATE EXTERNAL TABLE log (
	 pid STRING,
    cnt INT,
    price INT
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
STORED AS TEXTFILE
LOCATION '/tmp.log';
```

From HBase

```
CREATE EXTERNAL TABLE log(key string, name string, phone string)
STORED BY 'org.apache.hadoop.hive.hbase.HBaseStorageHandler' 
WITH SERDEPROPERTIES ("hbase.columns.mapping" = ":key,cf:name,cf:phone") TBLPROPERTIES("hbase.table.name" = "MyTable");
```