Class {
	#name : #CynDatabaseTooManyUpdates,
	#superclass : #CynDatabaseError,
	#category : #'CodeParadise-Canyon-Data-Database'
}

{ #category : #accessing }
CynDatabaseTooManyUpdates >> messageText [

	^ messageText ifNil: [ 'More than 1 row is updated' ]
]
