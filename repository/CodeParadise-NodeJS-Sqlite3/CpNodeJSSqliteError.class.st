Class {
	#name : #CpNodeJSSqliteError,
	#superclass : #CpJavaScriptError,
	#category : #'CodeParadise-NodeJS-Sqlite3-Core'
}

{ #category : #accessing }
CpNodeJSSqliteError class >> getClassName [

	^ self nameWithoutPrefix
		withoutPrefix: 'NodeJS'
]

{ #category : #accessing }
CpNodeJSSqliteError class >> module [

	^ CpNodeJSBetterSqlite3
]

{ #category : #accessing }
CpNodeJSSqliteError >> code [

	"Answer a string matching one of the 'extended result codes' defined in the link below (for example, 'SQLITE_CONSTRAINT_UNIQUE').
	Link: https://sqlite.org/rescode.html"

	^ self propertyAt: #code
]

{ #category : #testing }
CpNodeJSSqliteError >> isSqliteError [

	^ true
]
