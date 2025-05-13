"
I am the module for BetterSqlite3.

Do not forget to include 'better-sqlite3' in your package dependencies.

I support the basic Database and Statement classes and transactions,
but currently not iterators.

See https://github.com/WiseLibs/better-sqlite3

"
Class {
	#name : #CpNodeJSBetterSqlite3,
	#superclass : #CpNodeJSImportedModule,
	#category : #'CodeParadise-NodeJS-Sqlite3-Core'
}

{ #category : #accessing }
CpNodeJSBetterSqlite3 class >> moduleName [

	^ 'better-sqlite3'
]
