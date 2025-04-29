Class {
	#name : #CynDatabaseNoUpdate,
	#superclass : #CynDatabaseError,
	#category : #'CodeParadise-Canyon-Data-Database'
}

{ #category : #accessing }
CynDatabaseNoUpdate >> messageText [

	^ messageText ifNil: [ 'No row is updated' ]
]
