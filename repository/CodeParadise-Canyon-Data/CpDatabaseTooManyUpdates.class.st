Class {
	#name : #CpDatabaseTooManyUpdates,
	#superclass : #CpDatabaseError,
	#category : #'CodeParadise-Canyon-Data-Database'
}

{ #category : #accessing }
CpDatabaseTooManyUpdates >> messageText [

	^ messageText ifNil: [ 'More than 1 row is updated' ]
]
