# Learning HBase Shell

	注意事項：
		1. 文章內容須先將 Apache HBase 建置完成。
		2. 文章中一行表示一個欄位，一筆則是由多行組成的一個 Row。
		3. 本文並不包含所有旨令內容，主要為常用指令。
		4. 僅供參考使用。

## 目錄

[TOC]

## Getting Start

* 進入 HBase 指令模式

		$ hbase shell
		
## List

* 取得 資料表 列表

		hbase> list
		
## Create

* 新增 資料表

	> Here is some for this command:

	> Creates a table. Pass a table name, and a set of column family
	> specifications (at least one), and, optionally, table configuration.
	> Column specification can be a simple string (name), or a dictionary
	> (dictionaries are described below in main help output), necessarily
	> including NAME attribute.

	> Examples:

	> Create a table with namespace=ns1 and table qualifier=t1

	> * hbase> create 'ns1:t1', {NAME => 'f1', VERSIONS => 5}

	> Create a table with namespace=default and table qualifier=t1

	> * hbase> create 't1', {NAME => 'f1'}, {NAME => 'f2'}, {NAME => 'f3'}
	> * hbase> create 't1', 'f1', 'f2', 'f3'
	> * hbase> create 't1', {NAME => 'f1', VERSIONS => 1, TTL => 2592000, BLOCKCACHE => true}
	> * hbase> create 't1', {NAME => 'f1', CONFIGURATION => {'hbase.hstore.blockingStoreFiles' => '10'}}

	> Table configuration options can be put at the end.

	> Examples:

	> * hbase> create 'ns1:t1', 'f1', SPLITS => ['10', '20', '30', '40']
	> * hbase> create 't1', 'f1', SPLITS => ['10', '20', '30', '40']
	> * hbase> create 't1', 'f1', SPLITS_FILE => 'splits.txt', OWNER => 'johndoe'
	> * hbase> create 't1', {NAME => 'f1', VERSIONS => 5}, METADATA => { 'mykey' => 'myvalue' }
	> * hbase> create 't1', 'f1', {NUMREGIONS => 15, SPLITALGO => 'HexStringSplit'}
	> * hbase> create 't1', 'f1', {NUMREGIONS => 15, SPLITALGO => 'HexStringSplit', CONFIGURATION => {'hbase.hregion.scan.loadColumnFamiliesOnDemand' => 'true'}}

	> You can also keep around a reference to the created table:

	> * hbase> t1 = create 't1', 'f1'

	> Which gives you a reference to the table named 't1', on which you can then call methods.


* Training

		hbase> create 'test', 'cf'
		
[TOP](#toc_0)
	
## Put

* 新增一行資料

	> Here is some help for this command:
	> Put a cell 'value' at specified table/row/column and optionally
	> timestamp coordinates.  To put a cell value into table 'ns1:t1' or 't1'
	> at row 'r1' under column 'c1' marked with the time 'ts1', do:

	> * hbase> put 'ns1:t1', 'r1', 'c1', 'value'
	> * hbase> put 't1', 'r1', 'c1', 'value'
	> * hbase> put 't1', 'r1', 'c1', 'value', ts1
	> * hbase> put 't1', 'r1', 'c1', 'value', {ATTRIBUTES=>{'mykey'=>'myvalue'}}
	> * hbase> put 't1', 'r1', 'c1', 'value', ts1, {ATTRIBUTES=>{'mykey'=>'myvalue'}}
	> * hbase> put 't1', 'r1', 'c1', 'value', ts1, {VISIBILITY=>'PRIVATE|SECRET'}

	> The same commands also can be run on a table reference. Suppose you had a reference
	> t to table 't1', the corresponding command would be:

	> * hbase> t.put 'r1', 'c1', 'value', ts1, {ATTRIBUTES=>{'mykey'=>'myvalue'}}

* Training

		hbase> put 'test','row0','cf:string','字串'
		hbase> put 'test','row0','cf:boolean',"\x01"
		hbase> put 'test','row0','cf:short',"\x00\x01"
		hbase> put 'test','row0','cf:int',"\x00\x00\x00\x01"
		hbase> put 'test','row0','cf:long',"\x00\x00\x00\x00\x00\x00\x00\x01"
		hbase> put 'test','row0','cf:float',"?\x80\x00\x00"
		hbase> put 'test','row0','cf:double',"?\xF0\x00\x00\x00\x00\x00\x00"
		hbase> put 'test','row1','cf:name','Cookie'
		hbase> put 'test','row1','cf:phone','0999123456'
		hbase> put 'test','row2','cf:name','Tom'
		hbase> put 'test','row3','cf:name','Mary'
		
[TOP](#toc_0)
	
## Get

* 取得一筆資料

	> Here is some help for this command:
	> Get row or cell contents; pass table name, row, and optionally
	> a dictionary of column(s), timestamp, timerange and versions. Examples:

	> * hbase> get 'ns1:t1', 'r1'
	> * hbase> get 't1', 'r1'
	> * hbase> get 't1', 'r1', {TIMERANGE => [ts1, ts2]}
	> * hbase> get 't1', 'r1', {COLUMN => 'c1'}
	> * hbase> get 't1', 'r1', {COLUMN => ['c1', 'c2', 'c3']}
	> * hbase> get 't1', 'r1', {COLUMN => 'c1', TIMESTAMP => ts1}
	> * hbase> get 't1', 'r1', {COLUMN => 'c1', TIMERANGE => [ts1, ts2], VERSIONS => 4}
	> * hbase> get 't1', 'r1', {COLUMN => 'c1', TIMESTAMP => ts1, VERSIONS => 4}
	> * hbase> get 't1', 'r1', {FILTER => "ValueFilter(=, 'binary:abc')"}
	> * hbase> get 't1', 'r1', 'c1'
	> * hbase> get 't1', 'r1', 'c1', 'c2'
	> * hbase> get 't1', 'r1', ['c1', 'c2']
	> * hbsae> get 't1','r1', {COLUMN => 'c1', ATTRIBUTES => {'mykey'=>'myvalue'}}
	> * hbsae> get 't1','r1', {COLUMN => 'c1', AUTHORIZATIONS => ['PRIVATE','SECRET']}

	> Besides the default 'toStringBinary' format, 'get' also supports custom formatting by
	> column.  A user can define a FORMATTER by adding it to the column name in the get
	> specification.  The FORMATTER can be stipulated:

	>  1. either as a org.apache.hadoop.hbase.util.Bytes method name (e.g, toInt, toString)
	>  2. or as a custom class followed by method name: e.g. 'c(MyFormatterClass).format'.

	> Example formatting cf:qualifier1 and cf:qualifier2 both as Integers:

	> * hbase> get 't1', 'r1' {COLUMN => ['cf:qualifier1:toInt', 'cf:qualifier2:c(org.apache.hadoop.hbase.util.Bytes).toInt'] }

	> Note that you can specify a FORMATTER by column only (cf:qualifer).  You cannot specify a FORMATTER for all columns of a column family.

	> The same commands also can be run on a reference to a table (obtained via get_table or
	> create_table). Suppose you had a reference t to table 't1', the corresponding commands
	> would be:

	> * hbase> t.get 'r1'
	> * hbase> t.get 'r1', {TIMERANGE => [ts1, ts2]}
	> * hbase> t.get 'r1', {COLUMN => 'c1'}
	> * hbase> t.get 'r1', {COLUMN => ['c1', 'c2', 'c3']}
	> * hbase> t.get 'r1', {COLUMN => 'c1', TIMESTAMP => ts1}
	> * hbase> t.get 'r1', {COLUMN => 'c1', TIMERANGE => [ts1, ts2], VERSIONS => 4}
	> * hbase> t.get 'r1', {COLUMN => 'c1', TIMESTAMP => ts1, VERSIONS => 4}
	> * hbase> t.get 'r1', {FILTER => "ValueFilter(=, 'binary:abc')"}
	> * hbase> t.get 'r1', 'c1'
	> * hbase> t.get 'r1', 'c1', 'c2'
	> * hbase> t.get 'r1', ['c1', 'c2']

* Training

		hbase> get 'test','row0'
		hbase> get 'test','row0',['cf:string','cf:boolean','cf:float']
		hbase> get 'test','row0', ['cf:string:toString','cf:boolean:toBoolean','cf:int:toInt','cf:float:toFloat']
		
[TOP](#toc_0)

## Scan

	注意事項：
		* Scan Filter 常用包含：
			1. RowFilter
			2. SingleColumnValueFilter
			3. ValueFilter
			4. PrefixFilter
		* FILTER ByteArrayComparable 常用包含：
			1. binary
			2. substring
			3. regexstring
			4. binaryprefix 

* 掃描 Table（查詢多筆資料）

	> Here is some help for this command:
	> Scan a table; pass table name and optionally a dictionary of scanner
	> specifications.  Scanner specifications may include one or more of:
	> TIMERANGE, FILTER, LIMIT, STARTROW, STOPROW, TIMESTAMP, MAXLENGTH,
	> or COLUMNS, CACHE or RAW, VERSIONS

	> If no columns are specified, all columns will be scanned.
	> To scan all members of a column family, leave the qualifier empty as in 'col_family:'.

	> The filter can be specified in two ways:

	>  1. Using a filterString - more information on this is available in the Filter Language document attached to the HBASE-4176 JIRA
	>  2. Using the entire package name of the filter.

	> Some examples:

	> * hbase> scan 'hbase:meta'
	> * hbase> scan 'hbase:meta', {COLUMNS => 'info:regioninfo'}
	> * hbase> scan 'ns1:t1', {COLUMNS => ['c1', 'c2'], LIMIT => 10, STARTROW => 'xyz'}
	> * hbase> scan 't1', {COLUMNS => ['c1', 'c2'], LIMIT => 10, STARTROW => 'xyz'}
	> * hbase> scan 't1', {COLUMNS => 'c1', TIMERANGE => [1303668804, 1303668904]}
	> * hbase> scan 't1', {REVERSED => true}
	> * hbase> scan 't1', {FILTER => "(PrefixFilter ('row2') AND
	>     (QualifierFilter (>=, 'binary:xyz'))) AND (TimestampsFilter ( 123, 456))"}
	> * hbase> scan 't1', {FILTER =
	>     org.apache.hadoop.hbase.filter.ColumnPaginationFilter.new(1, 0)}
	> For setting the Operation Attributes
	> * hbase> scan 't1', { COLUMNS => ['c1', 'c2'], ATTRIBUTES => {'mykey' => 'myvalue'}}
	> * hbase> scan 't1', { COLUMNS => ['c1', 'c2'], AUTHORIZATIONS => ['PRIVATE','SECRET']}
	> For experts, there is an additional option -- CACHE_BLOCKS -- which
	> switches block caching for the scanner on (true) or off (false).  By
	> default it is enabled.  

	> Examples:

	> * hbase> scan 't1', {COLUMNS => ['c1', 'c2'], CACHE_BLOCKS => false}

	> Also for experts, there is an advanced option -- RAW -- which instructs the
	> scanner to return all cells (including delete markers and uncollected deleted
	> cells). This option cannot be combined with requesting specific COLUMNS.
	> Disabled by default.  

	> Example:

	> * hbase> scan 't1', {RAW => true, VERSIONS => 10}

	> Besides the default 'toStringBinary' format, 'scan' supports custom formatting
	> by column.  A user can define a FORMATTER by adding it to the column name in
	> the scan specification.  The FORMATTER can be stipulated:

	>  1. either as a org.apache.hadoop.hbase.util.Bytes method name (e.g, toInt, toString)
	>  2. or as a custom class followed by method name: e.g. 'c(MyFormatterClass).format'.

	> Example formatting cf:qualifier1 and cf:qualifier2 both as Integers:
	> * hbase> scan 't1', {COLUMNS => ['cf:qualifier1:toInt', 'cf:qualifier2:c(org.apache.hadoop.hbase.util.Bytes).toInt'] }

	> Note that you can specify a FORMATTER by column only (cf:qualifer).  You cannot 
	> specify a FORMATTER for all columns of a column family.

	> Scan can also be used directly from a table, by first getting a reference to a table, like such:

	> * hbase> t = get_table 't'
	> * hbase> t.scan

	> Note in the above situation, you can still provide all the filtering, columns,
	> options, etc as described above.

* Training

		hbase> scan 'test'
		hbase> scan 'test', {STARTROW => 'row1', STOPROW => 'row2~'}
		hbase> scan 'test', {COLUMNS => 'cf:name'}
		hbase> scan 'test', {COLUMNS => ['cf:string:toString','cf:short:toShort','cf:long:toLong']}
		hbase> scan 'test', {FILTER => "ValueFilter(=,'binary:Cookie')"}
		hbase> scan 'test', {FILTER => "SingleColumnValueFilter('cf','name',=,'substring:o')"}
		hbase> scan 'test', {FILTER => "RowFilter(=,'regexstring:[03]$')"}

[TOP](#toc_0)

## Delete

* 刪除一行資料

	> Here is some help for this command:
	> Put a delete cell value at specified table/row/column and optionally
	> timestamp coordinates.  Deletes must match the deleted cell's
	> coordinates exactly.  When scanning, a delete cell suppresses older
	> versions. To delete a cell from  't1' at row 'r1' under column 'c1'
	> marked with the time 'ts1', do:

	> * hbase> delete 'ns1:t1', 'r1', 'c1', ts1
	> * hbase> delete 't1', 'r1', 'c1', ts1
	> * hbase> delete 't1', 'r1', 'c1', ts1, {VISIBILITY=>'PRIVATE|SECRET'}

	> The same command can also be run on a table reference. Suppose you had a reference
	> t to table 't1', the corresponding command would be:

	> * hbase> t.delete 'r1', 'c1',  ts1
	> * hbase> t.delete 'r1', 'c1',  ts1, {VISIBILITY=>'PRIVATE|SECRET'}

* Training

		hbase> delete 'test', 'row1', 'cf:phone'
		
[TOP](#toc_0)

## Delete All

* 刪除一筆資料

	> Here is some help for this command:

	> Delete all cells in a given row; pass a table name, row, and optionally
	> a column and timestamp. 

	> Examples:

	> * hbase> deleteall 'ns1:t1', 'r1'
	> * hbase> deleteall 't1', 'r1'
	> * hbase> deleteall 't1', 'r1', 'c1'
	> * hbase> deleteall 't1', 'r1', 'c1', ts1
	> * hbase> deleteall 't1', 'r1', 'c1', ts1, {VISIBILITY=>'PRIVATE|SECRET'}

	> The same commands also can be run on a table reference. Suppose you had a reference
	> t to table 't1', the corresponding command would be:

	> * hbase> t.deleteall 'r1'
	> * hbase> t.deleteall 'r1', 'c1'
	> * hbase> t.deleteall 'r1', 'c1', ts1
	> * hbase> t.deleteall 'r1', 'c1', ts1, {VISIBILITY=>'PRIVATE|SECRET'}

* Training

		hbase> deleteall 'test', 'row2'
		
[TOP](#toc_0)

## Disable

* 關閉 資料表

	> Here is some help for this command:

	> Start disable of named table:

	> * hbase> disable 't1'
	> * hbase> disable 'ns1:t1'

* Training

		hbase> disable 'test'
		
[TOP](#toc_0)

## Enable

* 開啟 資料表

	> Here is some help for this command:

	> Start enable of named table:

	> * hbase> enable 't1'
	> * hbase> enable 'ns1:t1'

* Training

		hbase> ensable 'test'
		
[TOP](#toc_0)

## Truncate

	注意事項：效果完全等同於 disable + drop + create 等指令。

* 清空資料表

	> Here is some help for this command:

	> Disables, drops and recreates the specified table.

* Training

		hbase> truncate 'test'
		
[TOP](#toc_0)

## Drop

	注意事項：執行 drop 前須確認資料表處於關閉狀態。（須先執行 diable）

* 刪除 資料表

	> Here is some help for this command:

	> Drop the named table. Table must first be disabled:

	> * hbase> drop 't1'
	> * hbase> drop 'ns1:t1'

* Training

		hbase> drop 'test'
		
[TOP](#toc_0)

	