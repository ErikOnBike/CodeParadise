Class {
	#name : #CpDatabase,
	#superclass : #Object,
	#instVars : [
		'database',
		'preparedStatements'
	],
	#category : #'CodeParadise-Canyon-Data-Database'
}

{ #category : #'instance creation' }
CpDatabase class >> new [

	self errorNewReplacedBy: #on:
]

{ #category : #'instance creation' }
CpDatabase class >> on: aString [

	"Answer a new instance of the receiver using the specified Database (file) name.

	Implementation:
	The specified name should be the filename of a Sqlite database."

	^ self basicNew
		initializeWithDatabaseFile: aString ;
		yourself
]

{ #category : #initialization }
CpDatabase >> initializeWithDatabaseFile: aString [

	self initialize.

	database := CpNodeJSSqlite3Database onPath: aString withOptions: Dictionary new.
	preparedStatements := Dictionary new
]

{ #category : #database }
CpDatabase >> performMulti: aSymbol statement: aString bind: aDictionary [

	"Update (possibly) multiple rows in the database.
	Answer the number of rows updated.

	Implementation:
	If an Error is signaled, a more accurate Error is signaled (if available),
	otherwise the Error is (re)signaled."

	| resultInfo |

	[
		resultInfo := (self prepare: aSymbol statement: aString)
			runWithBindings: aDictionary
	] on: Error do: [ :error | self signalSqliteError: error ].

	^ resultInfo at: #changes
]

{ #category : #database }
CpDatabase >> performOne: aSymbol statement: aString bind: aDictionary [

	"Update a row in the database.
	Signal an Error if no or multiple rows are updated."

	| changeCount |

	changeCount := self performMulti: aSymbol statement: aString bind: aDictionary.

	changeCount == 0
		ifTrue: [ CpDatabaseNoUpdate signal ].
	changeCount > 1
		ifTrue: [ CpDatabaseTooManyUpdates signal ]
]

{ #category : #database }
CpDatabase >> prepare: aSymbol statement: aString [

	"Answer the prepared statement identified by a Symbol.

	Implementation:
	Currently the implementation is extra careful and also checks whethe the SQL
	expression has changed between consecutive calls. In a production environment
	this might not be necessary and saves one String comparison per invocation."

	^ preparedStatements
		at: aSymbol
		ifPresent: [ :statement |
			statement source = aString
				ifTrue: [ statement ]
				ifFalse: [ preparedStatements at: aSymbol put: (database prepare: aString) ] ]
		ifAbsentPut: [ database prepare: aString ]
]

{ #category : #database }
CpDatabase >> selectCount: aSymbol statement: aString bind: aDictionary [

	"Answer the count of a count query.
	It is assumed the statement uses 'COUNT(*)' as result.
	This is case sensitive."

	^ (self selectOne: aSymbol statement: aString bind: aDictionary)
		at: #'COUNT(*)'
]

{ #category : #database }
CpDatabase >> selectMany: aSymbol statement: aString bind: aDictionary [

	"Select (possibly) multiple rows from the database and answer a collection"

	^ (self prepare: aSymbol statement: aString)
		allWithBindings: aDictionary
]

{ #category : #database }
CpDatabase >> selectOne: aSymbol statement: aString bind: aDictionary [

	"Select a single row from the database and answer the object found"

	| rows |

	rows := (self prepare: aSymbol statement: aString)
		allWithBindings: aDictionary.

	rows size > 1
		ifTrue: [ CpDatabaseTooManySelected signal ].

	^ rows
		ifNotEmpty: [ rows first ]
		ifEmpty: [ nil ]
]

{ #category : #errors }
CpDatabase >> signalSqliteError: error [

	"Inspect the specified Sqlite Error and signal a more specific Error (if applicable),
	otherwise (re)signal the Error specified"

	| rootCause |

	rootCause := error rootCause.
	rootCause isSqliteError
		ifTrue: [

			"Curently only the unique constraint violation is detected"
			rootCause code = #SQLITE_CONSTRAINT_UNIQUE
				ifTrue: [ CpDatabaseUniqueConstraintViolation signal ] ].

	error signal
]
