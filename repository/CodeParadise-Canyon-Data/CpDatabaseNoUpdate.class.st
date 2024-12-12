Class {
	#name : #CpDatabaseNoUpdate,
	#superclass : #CpDatabaseError,
	#category : #'CodeParadise-Canyon-Data-Database'
}

{ #category : #accessing }
CpDatabaseNoUpdate >> messageText [

	^ messageText ifNil: [ 'No row is updated' ]
]
