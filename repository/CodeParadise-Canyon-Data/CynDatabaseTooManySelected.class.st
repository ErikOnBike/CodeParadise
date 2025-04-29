Class {
	#name : #CynDatabaseTooManySelected,
	#superclass : #CynDatabaseError,
	#category : #'CodeParadise-Canyon-Data-Database'
}

{ #category : #accessing }
CynDatabaseTooManySelected >> messageText [

	^ messageText ifNil: [ 'More than 1 row is selected' ]
]
