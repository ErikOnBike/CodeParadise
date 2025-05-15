"
I am a Database. I am responsible for querying and updating records.
I am using SQL as the query language.

My implementation is based on Sqlite. For performance I keep track of
the prepared statements which are created while creating query and
update statements. Prepared statements are kept by an identifier, meaning
the user is responsible to come up with unique names (although a safety
check is made the identifier and query are matching).

"
Class {
	#name : #CynDatabase,
	#superclass : #Object,
	#instVars : [
		'database',
		'preparedStatements',
		'booleanColumns'
	],
	#category : #'CodeParadise-Canyon-Data-Database'
}

{ #category : #'instance creation' }
CynDatabase class >> new [

	self errorNewReplacedBy: #on:
]

{ #category : #'instance creation' }
CynDatabase class >> on: aString [

	"Answer a new instance of the receiver using the specified Database (file) name.

	Implementation:
	The specified name should be the filename of a Sqlite database."

	^ self basicNew
		initializeWithDatabaseFile: aString ;
		yourself
]

{ #category : #initialization }
CynDatabase >> initializeWithDatabaseFile: aString [

	self initialize.

	database := CpNodeJSSqlite3Database onPath: aString withOptions: Dictionary new.
	preparedStatements := Dictionary new.
	booleanColumns := Dictionary new
]

{ #category : #database }
CynDatabase >> performInTransaction: aBlock [

	"Perform the specified Block in a transaction
	and answer the result of evaluating the Block.

	Implementation:
	Create a transaction function based on the specified Block and execute it."

	^ (database transaction: aBlock) value
]

{ #category : #database }
CynDatabase >> performInTransaction: aBlock with: anObject [

	"Perform the specified Block in a transaction with the specified argument
	and answer the result of evaluating the Block.

	Implementation:
	Create a transaction function based on the specified Block and execute it."

	^ (database transaction: aBlock) value: anObject
]

{ #category : #database }
CynDatabase >> performInTransaction: aBlock with: arg1Object with: arg2Object [

	"Perform the specified Block in a transaction with the specified arguments
	and answer the result of evaluating the Block.

	Implementation:
	Create a transaction function based on the specified Block and execute it."

	^ (database transaction: aBlock) value: arg1Object value: arg2Object
]

{ #category : #database }
CynDatabase >> performInTransaction: aBlock with: arg1Object with: arg2Object with: arg3Object [

	"Perform the specified Block in a transaction with the specified arguments
	and answer the result of evaluating the Block.

	Implementation:
	Create a transaction function based on the specified Block and execute it."

	^ (database transaction: aBlock) value: arg1Object value: arg2Object value: arg3Object
]

{ #category : #database }
CynDatabase >> performInTransaction: aBlock withArguments: anArray [

	"Perform the specified Block in a transaction with the specified arguments
	and answer the result of evaluating the Block.

	Implementation:
	Create a transaction function based on the specified Block and execute it."

	^ (database transaction: aBlock) valueWithArguments: anArray
]

{ #category : #database }
CynDatabase >> performMulti: aSymbol statement: aString [

	^ self performMulti: aSymbol statement: aString bind: nil
]

{ #category : #database }
CynDatabase >> performMulti: aSymbol statement: aString bind: aDictionary [

	"Update (possibly) multiple rows in the database.
	Answer the number of rows updated.

	Implementation:
	If an Error is signaled, a more accurate Error is signaled (if available),
	otherwise the Error is (re)signaled."

	| resultInfo |

	[
		resultInfo := (self prepare: aSymbol statement: aString)
			runWithBindings: (self sqliteBinding: aDictionary)
	] on: Error do: [ :error | self signalSqliteError: error ].

	^ resultInfo at: #changes
]

{ #category : #database }
CynDatabase >> performOne: aSymbol statement: aString [

	^ self performOne: aSymbol statement: aString bind: nil
]

{ #category : #database }
CynDatabase >> performOne: aSymbol statement: aString bind: aDictionary [

	"Update a row in the database.
	Signal an Error if no or multiple rows are updated."

	| changeCount |

	changeCount := self performMulti: aSymbol statement: aString bind: aDictionary.

	changeCount == 0
		ifTrue: [ CynDatabaseNoUpdate signal ].
	changeCount > 1
		ifTrue: [ CynDatabaseTooManyUpdates signal ]
]

{ #category : #private }
CynDatabase >> prepare: aSymbol selectStatement: aString [

	"Answer the prepared statement identified by a Symbol (for a select query).

	Implementation:
	Because sqlite does not support native booleans, keep track of the boolean
	columns to allow converting result values. A temporary #prepared is assigned
	if (and only if) a new prepared statement is created.

	Currently the implementation is extra careful and also checks whethe the SQL
	expression has changed between consecutive calls. In a production environment
	this might not be necessary. Since most often the source is a literal in a
	method, comparison is a cheap identity comparison and therefore has little
	overall impact."

	| preparedStatement prepared |

	preparedStatement := preparedStatements
		at: aSymbol
		ifPresent: [ :statement |
			"Since most often the statement source is a literal in a method compare for identity first"
			(statement source == aString or: [ statement source = aString ])
				ifTrue: [ statement ]
				ifFalse: [ preparedStatements at: aSymbol put: (prepared := database prepare: aString) ] ]
		ifAbsentPut: [ prepared := database prepare: aString ].

	"Only if new prepared statement is created extract the boolean columns"
	prepared
		ifNil: [ ^ preparedStatement ].

	booleanColumns
		at: aSymbol
		put: ((preparedStatement columns
			select: [ :each | (each at: #type) = #BOOLEAN ])
				collect: [ :each | each at: #name ]).

	^ preparedStatement
]

{ #category : #private }
CynDatabase >> prepare: aSymbol statement: aString [

	"Answer the prepared statement identified by a Symbol.

	Implementation:
	Currently the implementation is extra careful and also checks whethe the SQL
	expression has changed between consecutive calls. In a production environment
	this might not be necessary. Since most often the source is a literal in a
	method, comparison is a cheap identity comparison and therefore has little
	overall impact."

	^ preparedStatements
		at: aSymbol
		ifPresent: [ :statement |
			"Since most often the statement source is a literal in a method compare for identity first"
			(statement source == aString or: [ statement source = aString ])
				ifTrue: [ statement ]
				ifFalse: [ preparedStatements at: aSymbol put: (database prepare: aString) ] ]
		ifAbsentPut: [ database prepare: aString ]
]

{ #category : #database }
CynDatabase >> selectCount: aSymbol statement: aString [

	^ self selectCount: aSymbol statement: aString bind: nil
]

{ #category : #database }
CynDatabase >> selectCount: aSymbol statement: aString bind: aDictionary [

	"Answer the count of a count query.
	It is assumed the statement uses 'COUNT(*)' as result.
	This is case sensitive."

	^ (self selectOne: aSymbol statement: aString bind: aDictionary)
		at: #'COUNT(*)'
]

{ #category : #database }
CynDatabase >> selectMany: aSymbol statement: aString [

	^ self selectMany: aSymbol statement: aString bind: nil
]

{ #category : #database }
CynDatabase >> selectMany: aSymbol statement: aString bind: aDictionary [

	"Select (possibly) multiple rows from the database and answer a collection.

	Implementation:
	Convert boolean column values (which are 0's and 1's in sqlite) back to the
	native boolean value. Since the results are coming from the database we can
	replace the value 'in place' and don't need to create a copy of the result."

	| rows |

	rows := (self prepare: aSymbol selectStatement: aString)
		allWithBindings: (self sqliteBinding: aDictionary).

	"Convert boolean values (integers) to actual booleans"
	(booleanColumns at: aSymbol) do: [ :each |
		rows do: [ :row | row at: each put: (row at: each) = 1 ] ].

	^ rows
]

{ #category : #database }
CynDatabase >> selectOne: aSymbol statement: aString [

	^ self selectOne: aSymbol statement: aString bind: nil
]

{ #category : #database }
CynDatabase >> selectOne: aSymbol statement: aString bind: aDictionary [

	"Select a single row from the database and answer the object found"

	| rows |

	rows := self selectMany: aSymbol statement: aString bind: aDictionary.

	rows size > 1
		ifTrue: [ CynDatabaseTooManySelected signal ].

	^ rows
		ifNotEmpty: [ rows first ]
		ifEmpty: [ nil ]
]

{ #category : #errors }
CynDatabase >> signalSqliteError: error [

	"Inspect the specified Sqlite Error and signal a more specific Error (if applicable),
	otherwise (re)signal the Error specified"

	| rootException |

	rootException := error rootException.
	rootException isSqliteError
		ifTrue: [

			"Curently only the unique constraint violation is detected"
			rootException code = #SQLITE_CONSTRAINT_UNIQUE
				ifTrue: [ CynDatabaseUniqueConstraintViolation signal ] ].

	error pass
]

{ #category : #private }
CynDatabase >> sqliteBinding: aDictionary [

	"Sqlite does not support boolean values natively,
	convert bound booleans to integers 0 and 1.

	BE AWARE: The current implementation uses an 'in place' conversion
	for performance. Since literal Dictionaries don't exist in Pharo atm
	this seems a safe assumption."

	^ aDictionary ifNotNil: [
		aDictionary associationsDo: [ :each |
			each value == true
				ifTrue: [ each value: 1 ]
				ifFalse: [
					each value == false
						ifTrue: [ each value: 0 ] ] ] ]
]
