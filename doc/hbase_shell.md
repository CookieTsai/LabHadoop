## Create

Command

```
$ create <table name>, <column family name(s)>
```

Sample

```
$ create 'MyTable', 'cf'
```

## Put

Command

```
$ put <table name>, <row>, <column>, <value>
```

Sample

```
$ put 'MyTable', 'row1', 'cf:name', 'Tom'
$ put 'MyTable', 'row2', 'cf:name', 'Mary'
$ put 'MyTable', 'row2', 'cf:phone', '0999xxxxxx'
$ put 'MyTable', 'row3', 'cf:name', 'John'
```
## Scan

Command

```
$ scan <table name>
```

Sample

```
$ scan 'MyTable'
```

## Get

Command

```
$ scan <table name>, <row>
```

Sample

```
$ scan 'MyTable', 'row2'
```



