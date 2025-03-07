Class {
	#name : #CpNodeJSSqlite3Statement,
	#superclass : #CpJavaScriptObject,
	#category : #'CodeParadise-NodeJS-Sqlite3-Core'
}

{ #category : #'class initialization' }
CpNodeJSSqlite3Statement class >> beLoaded [

	CpNodeJSSqliteError beLoaded
]

{ #category : #accessing }
CpNodeJSSqlite3Statement class >> getClassName [

	"Answer the name of the JavaScript class"

	^ #Statement
]

{ #category : #accessing }
CpNodeJSSqlite3Statement class >> module [

	^ CpNodeJSBetterSqlite3
]

{ #category : #operations }
CpNodeJSSqlite3Statement >> all [

	^ self allWithBindings: nil
]

{ #category : #operations }
CpNodeJSSqlite3Statement >> allWithBindings: aDictionaryOrArray [

	"Similar to .get(), but instead of only retrieving one row all matching rows will be retrieved. The return value is an array of row objects.

	If no rows are found, the array will be empty. If execution of the statement fails, an Error is thrown."

	^ self apply: #all withArguments: (aDictionaryOrArray ifNotNil: [ { aDictionaryOrArray } ])
]

{ #category : #operations }
CpNodeJSSqlite3Statement >> bind: aDictionaryOrArray [

	"Binds the given parameters to the statement permanently. Unlike binding parameters upon execution, these parameters will stay bound to the prepared statement for its entire life.

	After a statement's parameters are bound this way, you may no longer provide it with execution-specific (temporary) bound parameters.

	This method is primarily used as a performance optimization when you need to execute the same prepared statement many times with the same bound parameters."

	^ self apply: #bind withArguments: (aDictionaryOrArray ifNotNil: [ { aDictionaryOrArray } ])
]

{ #category : #accessing }
CpNodeJSSqlite3Statement >> busy [

	"boolean - Whether the prepared statement is busy executing a query via the .iterate() method"

	^ self propertyAt: #busy
]

{ #category : #operations }
CpNodeJSSqlite3Statement >> columns [

	"This method is primarily used in conjunction with raw mode. It returns an array of objects, where each object describes a result column of the prepared statement. Each object has the following properties:

	.name: the name (or alias) of the result column.
	.column: the name of the originating table column, or null if it's an expression or subquery.
	.table: the name of the originating table, or null if it's an expression or subquery.
	.database: the name of the originating database, or null if it's an expression or subquery.
	.type: the name of the declared type, or null if it's an expression or subquery."

	^ self apply: #columns
]

{ #category : #accessing }
CpNodeJSSqlite3Statement >> database [

	"object - The parent database object"

	^ self propertyAt: #database
]

{ #category : #operations }
CpNodeJSSqlite3Statement >> expand: aBoolean [

	"Causes the prepared statement to return data namespaced by table. Each key in a row object will be a table name, and each corresponding value will be a nested object that contains the associated column data. This is useful when performing a JOIN between two tables that have overlapping column names. If a result column is an expression or subquery, it will be available within the special $ namespace.

	You can toggle this on/off as you please:"

	^ self apply: #expand withArguments: { aBoolean }
]

{ #category : #operations }
CpNodeJSSqlite3Statement >> get [

	^ self getWithBindings: nil
]

{ #category : #operations }
CpNodeJSSqlite3Statement >> getWithBindings: aDictionaryOrArray [

	"Executes the prepared statement. When execution completes it returns an object that represents the first row retrieved by the query. The object's keys represent column names.

	If the statement was successful but found no data, undefined is returned. If execution of the statement fails, an Error is thrown.

	See also #runWithBindings: for an explanation about the parameter bindings."

	^ self apply: #get withArguments: (aDictionaryOrArray ifNotNil: [ { aDictionaryOrArray } ])
]

{ #category : #operations }
CpNodeJSSqlite3Statement >> iterate [

	^ self iterateWithBindings: nil
]

{ #category : #operations }
CpNodeJSSqlite3Statement >> iterateWithBindings: aDictionaryOrArray [

	"Similar to .all(), but instead of returning every row together, an iterator is returned so you can retrieve the rows one by one. If you plan on retrieving every row anyways, .all() will perform slightly better.

If execution of the statement fails, an Error is thrown and the iterator is closed."

	self error: 'Iterators are not implemented yet!'.

	^ self apply: #iterate withArguments: (aDictionaryOrArray ifNotNil: [ { aDictionaryOrArray } ])
]

{ #category : #operations }
CpNodeJSSqlite3Statement >> raw: aBoolean [

	"Causes the prepared statement to return rows as arrays instead of objects. This is primarily used as a performance optimization when retrieving a very high number of rows. Column names can be recovered by using the .columns() method.

You can toggle this on/off as you please:"

	^ self apply: #raw withArguments: { aBoolean }
]

{ #category : #accessing }
CpNodeJSSqlite3Statement >> reader [

	"boolean - Whether the prepared statement returns data"

	^ self propertyAt: #reader
]

{ #category : #accessing }
CpNodeJSSqlite3Statement >> readonly [

	"boolean - Whether the prepared statement is readonly, meaning it does not mutate the database (note that SQL functions might still change the database indirectly as a side effect, even if the .readonly property is true)"

	^ self propertyAt: #readonly
]

{ #category : #operations }
CpNodeJSSqlite3Statement >> run [

	^ self runWithBindings: nil
]

{ #category : #operations }
CpNodeJSSqlite3Statement >> runWithBindings: aDictionaryOrArray [

	"Executes the prepared statement. When execution completes it returns an info object describing any changes made. The info object has two properties:

	info.changes: the total number of rows that were inserted, updated, or deleted by this operation. Changes made by foreign key actions or trigger programs do not count.
	info.lastInsertRowid: the rowid of the last row inserted into the database (ignoring those caused by trigger programs). If the current statement did not insert any rows into the database, this number should be completely ignored.

	Binding parameters can be an array consisting of positional parameters
	or it can be an array with key, value pairs (keys in the odd and values in the even positions)
	or it can be a Dictionary with key/value pairs
	or a combination of these.
	For readability the named parameters (and a Dictionary for binding) seems a good choice.
	See https://github.com/WiseLibs/better-sqlite3/blob/master/docs/api.md#binding-parameters

	If execution of the statement fails, an Error is thrown."

	^ self apply: #run withArguments: (aDictionaryOrArray ifNotNil: [ { aDictionaryOrArray } ])
]

{ #category : #accessing }
CpNodeJSSqlite3Statement >> source [

	"string - The source string that was used to create the prepared statement"

	^ self propertyAt: #source
]
