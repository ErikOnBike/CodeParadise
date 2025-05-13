Class {
	#name : #CpNodeJSSqlite3Database,
	#superclass : #CpJavaScriptObject,
	#category : #'CodeParadise-NodeJS-Sqlite3-Core'
}

{ #category : #accessing }
CpNodeJSSqlite3Database class >> getClassName [

	"Answer the name of the JavaScript class"

	^ #Database
]

{ #category : #accessing }
CpNodeJSSqlite3Database class >> module [

	^ CpNodeJSBetterSqlite3
]

{ #category : #'instance creation' }
CpNodeJSSqlite3Database class >> onPath: aString withOptions: aDictionary [

	"Open a Database on the specified path using the specified options.

	Various options are accepted:

		options.readonly: open the database connection in readonly mode (default: false).

		options.fileMustExist: if the database does not exist, an Error will be thrown instead of creating a new file. This option is ignored for in-memory, temporary, or readonly database connections (default: false).

		options.timeout: the number of milliseconds to wait when executing queries on a locked database, before throwing a SQLITE_BUSY error (default: 5000).

		options.verbose: provide a function that gets called with every SQL string executed by the database connection (default: null).

		options.nativeBinding: if you're using a complicated build system that moves, transforms, or concatenates your JS files, better-sqlite3 might have trouble locating its native C++ addon (better_sqlite3.node). If you get an error that looks like this, you can solve it by using this option to provide the file path of better_sqlite3.node (relative to the current working directory).

	Implementation:
	Because require provides the Database class itself, use the constructor
	directly here."

	^ (self global
		apply: #require withArguments: { self moduleName } resultAs: CpJavaScriptFunction)
			call: nil withArguments: { aString . aDictionary } resultAs: self
]

{ #category : #operations }
CpNodeJSSqlite3Database >> exec: aString [

	"Execute the specified SQL Statement"

	self apply: #exec withArguments: { aString }
]

{ #category : #accessing }
CpNodeJSSqlite3Database >> inTransaction [

	"boolean - Whether the database connection is currently in an open transaction"

	^ self propertyAt: #inTransaction
]

{ #category : #accessing }
CpNodeJSSqlite3Database >> memory [

	"boolean - Whether the database is an in-memory or temporary database"

	^ self propertyAt: #memory
]

{ #category : #accessing }
CpNodeJSSqlite3Database >> name [

	"string - The string that was used to open the database connection"

	^ self propertyAt: #name
]

{ #category : #accessing }
CpNodeJSSqlite3Database >> open [

	"boolean - Whether the database connection is currently open"

	^ self propertyAt: #open
]

{ #category : #operations }
CpNodeJSSqlite3Database >> pragma: aString withOptions: aDictionary [

	"Executes the given PRAGMA and returns its result. By default, the return value will be an array of result rows. Each row is represented by an object whose keys correspond to column names.

	Since most PRAGMA statements return a single value, the simple option is provided to make things easier. When simple is true, only the first column of the first row will be returned.

	If execution of the PRAGMA fails, an Error is thrown.

	It's better to use this method instead of normal prepared statements when executing PRAGMA, because this method normalizes some odd behavior that may otherwise be experienced. The documentation on SQLite3 PRAGMA can be found https://www.sqlite.org/pragma.html."

	^ self apply: #pragma withArguments: { aString . aDictionary }
]

{ #category : #operations }
CpNodeJSSqlite3Database >> prepare: aString [

	"Creates a new prepared Statement from the given SQL string"

	^ self apply: #prepare withArguments: { aString } resultAs: CpNodeJSSqlite3Statement
]

{ #category : #accessing }
CpNodeJSSqlite3Database >> readonly [

	"boolean - Whether the database connection was created in readonly mode"

	^ self propertyAt: #readonly
]

{ #category : #operations }
CpNodeJSSqlite3Database >> transaction: aBlock [

	"Creates a function that always runs inside a transaction. When the function is invoked, it will begin a new transaction. When the function returns, the transaction will be committed. If an exception is thrown, the transaction will be rolled back (and the exception will propagate as usual)."

	^ self apply: #transaction withArguments: { aBlock asJavaScriptFunction } resultAs: CpJavaScriptFunction
]
