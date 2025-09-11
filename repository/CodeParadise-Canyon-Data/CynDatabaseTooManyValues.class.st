Class {
	#name : #CynDatabaseTooManyValues,
	#superclass : #CynDatabaseError,
	#category : #'CodeParadise-Canyon-Data-Database'
}

{ #category : #accessing }
CynDatabaseTooManyValues >> messageText [

	^ messageText ifNil: [ 'More than 1 value is selected' ]
]
